import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ClockHome extends StatefulWidget {
  const ClockHome({super.key});

  @override
  State<ClockHome> createState() => _ClockHomeState();
}

class _ClockHomeState extends State<ClockHome> with TickerProviderStateMixin {
  Animation<double>? clockAnimation;
  AnimationController? clockController;

  @override
  void initState() {
    clockController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    clockController!.forward();
    clockAnimation =
        Tween<double>(begin: 0.0, end: 0.5).animate(clockController!);
    clockController!.addListener(() {
      setState(() {});
    });
    clockController!.addListener(() {
      if (clockAnimation!.value == 0.5) {
        clockController!.reverse();
      }
      if (clockAnimation!.value == 0.0) {
        clockController!.forward();
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue.shade900.withAlpha(90),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'T I C K E R ',
          style: GoogleFonts.lato(
            fontSize: 20 + clockAnimation!.value * 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    width: 400.0,
                    height: 400.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade900.withAlpha(90),
                          offset: const Offset(-6.0, -6.0),
                          blurRadius: 16.0,
                        ),
                        BoxShadow(
                          color: Colors.blue.shade900.withAlpha(90),
                          offset: const Offset(6.0, 6.0),
                          blurRadius: 16.0,
                          spreadRadius: 10.0,
                        ),
                      ],
                      color: Colors.black26.withAlpha(100),
                    ),
                  ),
                ),

                /// First Progress Indicator
                CircularPercentIndicator(
                  radius: 120,
                  percent: clockAnimation?.value ?? 0,
                  lineWidth: 12.0,
                  backgroundColor: Colors.transparent,
                  progressColor: Colors.green,
                  circularStrokeCap: CircularStrokeCap.round,
                ),

                /// Second Progress Indicator
                CircularPercentIndicator(
                  radius: 100.0,
                  percent: 0.31,
                  lineWidth: 12.0,
                  progressColor: Colors.blue,
                  backgroundColor: Colors.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                ),

                /// Third Progress Indicator
                CircularPercentIndicator(
                  radius: 80.0,
                  percent: 0.7,
                  lineWidth: 12.0,
                  progressColor: Colors.red,
                  backgroundColor: Colors.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                ),

                /// Hours Clock Hand
                const ClockHand(
                  rotationAngle: 37 * 6.4,
                  color: Colors.red,
                  height: 35.0,
                ),

                /// Minutes Clock Hand
                const ClockHand(
                  rotationAngle: (20 / 60) * 6.4,
                  color: Colors.blue,
                ),

                /// Seconds Clock Hand
                ClockHand(
                  rotationAngle: clockAnimation!.value * 6.4,
                  color: Colors.green,
                  height: 45.0,
                ),

                /// Center Anchor
                const CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.deepPurple,
                ),

                Center(
                  child: CustomPaint(
                    size: const Size(400, 400),
                    painter: TickerPainter(
                      heading: 0.0,
                      foregroundColor: Colors.white,
                      angel: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClockHand extends StatelessWidget {
  final double rotationAngle;
  final Color color;
  final double height;
  final double width;

  const ClockHand({
    Key? key,
    this.rotationAngle = 0.0,
    this.color = Colors.green,
    this.width = 3.0,
    this.height = 35.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAngle,
      child: SizedBox(
        width: 80,
        height: 80,
        child: Column(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TickerPainter extends CustomPainter {
  TickerPainter({
    required this.heading,
    required this.foregroundColor,
    required this.angel,
    this.majorTickCount = 4,
    this.minorTickCount = 12,
  });

  final double heading;

  final Color foregroundColor;

  final int majorTickCount;

  final int minorTickCount;
  final double angel;

  late final majorScalePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = foregroundColor
    ..strokeWidth = 2.5;

  late final minorScalePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = foregroundColor.withOpacity(0.7)
    ..strokeWidth = 1.5;

  late final majorScaleStyle = TextStyle(
    color: foregroundColor,
    fontSize: 15,
  );

  late final _majorTicks = _layoutScale(majorTickCount);
  late final _minorTicks = _layoutScale(minorTickCount);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    assert(size.width == size.height, 'Size must be square');
    const origin = Offset.zero;
    final center = size.center(origin);
    final radius = size.width / 4.0;

    const tickPadding = 40.0;
    const tickLength = 7.0;

    // paint major scale
    for (final angle in _majorTicks) {
      final tickStart = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - tickPadding,
      );

      final tickEnd = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - tickPadding - tickLength,
      );

      canvas.drawLine(
        center + tickStart,
        center + tickEnd,
        majorScalePaint,
      );
      canvas.save();
    }
    canvas.restore();

    // paint minor scale
    for (final angle in _minorTicks) {
      final tickStart = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - tickPadding,
      );

      final tickEnd = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - tickPadding - tickLength,
      );

      canvas.drawLine(
        center + tickStart,
        center + tickEnd,
        minorScalePaint,
      );
      canvas.save();
    }
  }

  @override
  bool shouldRepaint(TickerPainter oldDelegate) {
    return true;
  }

  List<double> _layoutScale(int ticks) {
    final scale = 360 / ticks;
    return List.generate(ticks, (i) => i * scale);
  }

  double _correctedAngle(double angle) => angle - heading - 90;
}

extension on num {
  double toRadians() => this * pi / 180;
}
