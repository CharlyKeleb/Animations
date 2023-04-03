import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/utils/extensions.dart';
import 'package:test_project/utils/type_write.dart';

class DiscordHome extends StatefulWidget {
  const DiscordHome({Key? key}) : super(key: key);

  @override
  State<DiscordHome> createState() => _DiscordHomeState();
}

class _DiscordHomeState extends State<DiscordHome>
    with TickerProviderStateMixin {
  Animation<double>? discordAnimation;
  AnimationController? discordController;

  AnimationController? shakeController;

  @override
  void initState() {
    super.initState();
    discordController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    discordController!.forward();
    discordAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(discordController!);
    discordController!.addListener(() {
      if (discordAnimation!.value == 1) {
        //shake six times
        shakeController!.forward();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    shakeController!.dispose();
    discordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Curve curve = Curves.bounceOut;

    /// convert 0-1 to 0-1-0
    double shake(double animation) =>
        2 * (0.5 - (0.5 - curve.transform(animation)).abs());

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade700,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
              animation: shakeController!,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(20 * shake(shakeController!.value), 0),
                  child: CustomPaint(
                    painter: DiscordPainter(
                      discordProgress: discordAnimation?.value ?? 0,
                    ),
                    child: Container(),
                  ),
                );
              }),
          if (discordAnimation?.value == 1)
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to',
                      style: GoogleFonts.lato(
                        letterSpacing: 1.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 12.0,
                      ),
                    ).fadeInList(1, true),
                    TypeWrite(
                      textScaleFactor: 1,
                      seconds: 2,
                      word: 'D i S C O R D',
                      style: GoogleFonts.lato(
                        letterSpacing: 1.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DiscordPainter extends CustomPainter {
  final double? discordProgress;

  DiscordPainter({required this.discordProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final curvesPaint = Paint()
      ..strokeWidth = 5
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final blackPaint = Paint()
      ..strokeWidth = 2.6
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    final eyePaint = Paint()
      ..strokeWidth = 5
      ..color = Colors.deepPurple.shade700
      ..style = PaintingStyle.fill;

    final discordBody = Path()
      //moveto desired positon
      ..moveTo(size.width / 3.3, size.height / 4)
      //first discord curve from the left
      ..relativeQuadraticBezierTo(-30, 50, -10, 135)
      //discord left leg
      ..relativeLineTo(50, 18)
      ..relativeLineTo(10, -20)
      ..relativeLineTo(-30, -10)
      ..relativeLineTo(10, -12)
      //discord base curve
      ..relativeQuadraticBezierTo(60, 30, 125, 2)
      //discord right leg
      ..relativeLineTo(10, 12)
      ..relativeLineTo(-30, 10)
      ..relativeLineTo(10, 20)
      ..relativeLineTo(50, -20)
      //discord right curve
      ..relativeQuadraticBezierTo(20, -50, -10, -135)
      //discord right shoulder
      ..relativeLineTo(-50, -15)
      ..relativeLineTo(-10, 15)
      //discord head curve
      ..relativeQuadraticBezierTo(-25, -10, -65, 0)
      //discord left shoulder
      ..relativeLineTo(-10, -15)
      ..relativeLineTo(-50, 15);

    //this will draw the discord
    animatePath(discordBody, blackPaint, canvas, discordProgress!);
    //white paint
    animatePath(
        discordBody, curvesPaint, canvas, discordProgress == 1.0 ? 1.0 : 0);

    //left discord eye
    canvas.drawCircle(Offset(size.width / 2.4, size.height / 3), 22, eyePaint);
    //right discord eye
    canvas.drawCircle(Offset(size.width / 1.6, size.height / 3), 22, eyePaint);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  animatePath(Path path, Paint paint, Canvas canvas, double progress) {
    PathMetrics shadowMetrics = path.computeMetrics();
    for (PathMetric pathMetric in shadowMetrics) {
      Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * progress,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
