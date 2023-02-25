import 'dart:math';
import 'package:flutter/material.dart';

class CompassView extends StatefulWidget {
  const CompassView({
    Key? key,
    required this.bearing,
    required this.heading,
    this.foregroundColor = Colors.white,
    this.bearingColor = Colors.red,
  }) : super(key: key);

  final double? bearing;

  final double heading;

  final Color foregroundColor;

  final Color bearingColor;

  @override
  State<CompassView> createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _compassAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
    _compassAnimation =
        Tween(begin: 50.roundToDouble(), end: 15.roundToDouble()).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCirc),
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Center(
          child: Container(
            width: 450.0,
            height: 450.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  offset: const Offset(-6.0, -6.0),
                  blurRadius: 16.0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: const Offset(6.0, 6.0),
                  blurRadius: 16.0,
                ),
              ],
              color: Colors.black,
            ),
          ),
        ),
        Center(
          child: Container(
            width: 350,
            height: 350,
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
        // compass painter
        Center(
          child: CustomPaint(
            size: const Size(400, 400),
            painter: _CompassViewPainter(
              heading: widget.heading,
              foregroundColor: widget.foregroundColor,
              angel: _compassAnimation.value,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CompassViewPainter extends CustomPainter {
  _CompassViewPainter({
    required this.heading,
    required this.foregroundColor,
    required this.angel,
    this.majorTickCount = 8,
    this.minorTickCount = 40,
    this.cardinalities = const {0: 'N', 90: 'E', 180: 'S', 270: 'W'},
  });

  final double heading;

  final Color foregroundColor;

  final int majorTickCount;

  final int minorTickCount;
  final double angel;

  final CardinalityMap cardinalities;

  late final bearingIndicatorPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = foregroundColor
    ..strokeWidth = 4.0
    ..blendMode = BlendMode.difference;

  late final majorScalePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = foregroundColor
    ..strokeWidth = 2.0;

  late final minorScalePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = foregroundColor.withOpacity(0.7)
    ..strokeWidth = 1.0;

  late final majorScaleStyle = TextStyle(
    color: foregroundColor,
    fontSize: 15,
  );

  late final cardinalityStyle = TextStyle(
    color: foregroundColor,
    fontSize: 20,
  );
  TextStyle cardinalityRedStyle = const TextStyle(
    color: Colors.red,
    fontSize: 20,
  );
  final _paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 10
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  late final _majorTicks = _layoutScale(majorTickCount);
  late final _minorTicks = _layoutScale(minorTickCount);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    assert(size.width == size.height, 'Size must be square');
    const origin = Offset.zero;
    final center = size.center(origin);
    final radius = size.width / 2.3;

    const tickPadding = 40.0;
    const tickLength = 5.0;

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
    }

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
    }

    // paint major scale text
    for (final angle in _majorTicks) {
      const majorScaleTextPadding = 20.0;

      final textPainter = TextSpan(
        text: angle.toStringAsFixed(0),
        style: majorScaleStyle,
      ).toPainter()
        ..layout();

      final layoutOffset = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - majorScaleTextPadding,
      );

      final offset = center + layoutOffset - textPainter.center;
      textPainter.paint(canvas, offset);
    }
    //inner black circle
    canvas.drawCircle(
      Offset(size.height / 2, size.height / 2),
      110,
      _paint,
    );

    //rotate the canvas to 2 degrees

    const degrees = 2;
    const radii = degrees * pi / 180;
    canvas.rotate(radii);

canvas.restore();
    // paint cardinality text
    for (final cardinality in cardinalities.entries) {
      const majorScaleTextPadding = 100.0;

      final angle = cardinality.key.toDouble() + angel - 30;
      final text = cardinality.value;
      final textPainter = TextSpan(
        text: text,
        style: angle < 45 ? cardinalityRedStyle : cardinalityStyle,
      ).toPainter()
        ..layout();

      final layoutOffset = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - majorScaleTextPadding,
      );

      final offset = center + layoutOffset - textPainter.center;
      textPainter.paint(canvas, offset);
    }
    // paint cardinality color
    for (final cardinality in cardinalities.entries) {
      const majorScaleTextPadding = 65.0;

      final angle = cardinality.key.toDouble() + angel - 31;
      IconData icon = angle < 45 ? Icons.navigation : Icons.circle;
      TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
      textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: angle < 45 ? 25 : 10.0,
          fontFamily: icon.fontFamily,
          color: angle < 45 ? Colors.red : Colors.yellow,
        ),
      );
      textPainter.layout();

      final layoutOffset = Offset.fromDirection(
        _correctedAngle(angle).toRadians(),
        radius - majorScaleTextPadding,
      );
      final offset = center + layoutOffset - textPainter.center;
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(_CompassViewPainter oldDelegate) {
    return true;
  }

  List<double> _layoutScale(int ticks) {
    final scale = 360 / ticks;
    return List.generate(ticks, (i) => i * scale);
  }

  double _correctedAngle(double angle) => angle - heading - 90;
}

typedef CardinalityMap = Map<num, String>;

extension on TextPainter {
  Offset get center => size.center(Offset.zero);
}

extension on TextSpan {
  TextPainter toPainter({TextDirection textDirection = TextDirection.ltr}) =>
      TextPainter(text: this, textDirection: textDirection);
}

extension on num {
  double toRadians() => this * pi / 180;
}
