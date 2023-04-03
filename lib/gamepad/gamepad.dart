import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

class GamePad extends StatefulWidget {
  const GamePad({Key? key}) : super(key: key);

  @override
  State<GamePad> createState() => _GamePadState();
}

class _GamePadState extends State<GamePad> with TickerProviderStateMixin {
  AnimationController? playstationController;
  AnimationController? leftPsSocketController;
  AnimationController? rightPsSocketController;
  AnimationController? displayPadController;
  AnimationController? analogController;
  AnimationController? volumeController;
  AnimationController? opacityController;

  Animation<double>? playstationAnimation;
  Animation<double>? leftPsSocketAnimation;
  Animation<double>? rightPsSocketAnimation;
  Animation<double>? displayPadAnimation;
  Animation<double>? analogAnimation;
  Animation<double>? volumeAnimation;
  Animation<double>? opacityAnimation;

  @override
  void initState() {
    super.initState();
    playstationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    leftPsSocketController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    rightPsSocketController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    displayPadController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    analogController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    volumeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    opacityController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    //animate
    playstationAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(playstationController!);
    Timer(const Duration(seconds: 1), () {
      playstationController!.forward();
    });
    playstationController!.addListener(() {
      if (playstationAnimation!.value == 1) {
        leftPsSocketController!.forward();
        leftPsSocketAnimation = Tween<double>(begin: 0.0, end: 1.0)
            .animate(leftPsSocketController!);
      }
      setState(() {});
    });
    leftPsSocketController!.addListener(() {
      if (leftPsSocketAnimation!.value == 1) {
        rightPsSocketController!.forward();
        rightPsSocketAnimation = Tween<double>(begin: 0.0, end: 1.0)
            .animate(rightPsSocketController!);
        if (leftPsSocketAnimation!.value == 1) {
          rightPsSocketController!.forward();
          rightPsSocketAnimation = Tween<double>(begin: 0.0, end: 1.0)
              .animate(rightPsSocketController!);
        }
      }
      setState(() {});
    });
    rightPsSocketController!.addListener(() {
      if (rightPsSocketAnimation!.value == 1) {
        displayPadController!.forward();
        displayPadAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(displayPadController!);
      }
      setState(() {});
    });
    displayPadController!.addListener(() {
      if (displayPadAnimation!.value == 1) {
        analogController!.forward();
        analogAnimation =
            Tween<double>(begin: 0.0, end: 8.9).animate(analogController!);
      }
      setState(() {});
    });
    analogController!.addListener(() {
      if (analogAnimation!.value == 8.9) {
        volumeController!.forward();
        volumeAnimation =
            Tween<double>(begin: 0.0, end: 5.0).animate(volumeController!);
      }
      setState(() {});
    });
    volumeController!.addListener(() {
      if (volumeAnimation!.value == 5.0) {
        opacityController!.forward();
        opacityAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(opacityController!);
      }
      setState(() {});
    });
    opacityController!.addListener(() {
      if (opacityAnimation!.value == 1.0) {}
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print('value: $displayPadAnimation');
    print('ps: $playstationAnimation');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'G A M E P A D',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Stack(
        // alignment: Alignment.center,
        children: [
          CustomPaint(
            child: Container(),
            painter: GamePadPainter(
              leftSocketProgress: leftPsSocketAnimation?.value ?? 0,
              playstationProgress: playstationAnimation?.value,
              rightSocketProgress: rightPsSocketAnimation?.value ?? 0,
              displayProgress: displayPadAnimation?.value ?? 0,
              analogProgress: analogAnimation?.value ?? 0,
              volumeProgress: volumeAnimation?.value ?? 0,
            ),
          ),
          //Left - controller button
          Positioned(
            top: 245.0,
            left: 47.0,
            child: AnimatedOpacity(
              opacity: opacityAnimation?.value ?? 0.0,
              duration: const Duration(milliseconds: 1),
              child: Image.asset(
                'assets/images/d_pad.png',
                height: 55.0,
                width: 55.0,
                color: Colors.black,
              ),
            ),
          ),
          //Left top small line
          Positioned(
            top: 215.0,
            left: 118.0,
            child: Transform.rotate(
              angle: -.12,
              child: AnimatedOpacity(
                opacity: opacityAnimation?.value ?? 0.0,
                duration: const Duration(milliseconds: 100),
                child: AnimatedContainer(
                  height: 20.0,
                  width: 5.0,
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ),
          ),
          //Right top small line
          Positioned(
            top: 215.0,
            right: 118.0,
            child: Transform.rotate(
              angle: .12,
              child: AnimatedOpacity(
                opacity: opacityAnimation?.value ?? 0.0,
                duration: const Duration(milliseconds: 100),
                child: AnimatedContainer(
                  height: 20.0,
                  width: 5.0,
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ),
          ),
          //Playstation Logo
          Positioned(
            top: 285.0,
            left: 200.0,
            child: AnimatedOpacity(
              opacity: opacityAnimation?.value ?? 0.0,
              duration: const Duration(milliseconds: 100),
              child: Image.asset(
                'assets/images/ps_logo.png',
                height: 30.0,
                width: 30.0,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 315.0,
            left: 205.0,
            child: AnimatedOpacity(
              opacity: opacityAnimation?.value ?? 0.0,
              duration: const Duration(milliseconds: 100),
              child: Container(
                height: 5.0,
                width: 20.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    playstationController!.dispose();
    leftPsSocketController!.dispose();
    rightPsSocketController!.dispose();
    analogController!.dispose();
    displayPadController!.dispose();
    super.dispose();
  }
}

class GamePadPainter extends CustomPainter {
  final double dpadSize;
  final double dpadButtonSize;
  final double dpadButtonSpacing;
  final double dpadButtonBorderWidth;
  final Color dpadButtonBorderColor;
  final Color dpadButtonColor;
  final Color dpadBackgroundColor;

  final double? displayProgress;
  final double? playstationProgress;
  final double? leftSocketProgress;
  final double? rightSocketProgress;
  final double? analogProgress;
  final double? volumeProgress;

  GamePadPainter(
      {this.dpadSize = 25,
      this.dpadButtonSize = 15,
      this.dpadButtonSpacing = 5,
      this.dpadButtonBorderWidth = 5,
      this.dpadButtonBorderColor = Colors.black,
      this.dpadButtonColor = Colors.white,
      this.dpadBackgroundColor = Colors.transparent,
      //for animation
      required this.displayProgress,
      required this.playstationProgress,
      required this.rightSocketProgress,
      required this.analogProgress,
      required this.leftSocketProgress,
      required this.volumeProgress});

  @override
  void paint(Canvas canvas, Size size) {
    //curves

    final curvesPaint = Paint()
      ..strokeWidth = 5
      ..color = Colors.black
      ..style = PaintingStyle.stroke;
    final whitePaint = Paint()
      ..strokeWidth = 5
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final blackPaint = Paint()
      ..strokeWidth = 5
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    // final displayPad = Paint()
    //   ..strokeWidth = 4
    //   ..color = Colors.white
    //   ..style = PaintingStyle.stroke;
    final doubleLinePaint = Paint()
      ..strokeWidth = 5
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(
        BlurStyle.solid,
        convertRadiusToSigma(2),
      );
    final analogPaint = Paint()
      ..strokeWidth = 5
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(
        BlurStyle.solid,
        convertRadiusToSigma(2),
      );
    //first analog
    final center = Offset(size.width / 8 + 120, size.height / 3 + 25);
    //second analog
    final centre = Offset(size.width / 8 + 203, size.height / 3 + 25);

    final radius = math.min(17.0, 17.0);

    final ps5Skeleton = Path()
      ..moveTo(size.width / 8, size.height / 4)
      //left curve
      ..relativeQuadraticBezierTo(-30, 100, -5, 200)
      //left short curve
      ..relativeQuadraticBezierTo(10, 30, 50, 25)
      //left-right line
      ..relativeQuadraticBezierTo(20, -55, 30, -85)
      //left-right top curve
      ..relativeQuadraticBezierTo(10, -25, 35, -20)
      //analog left box
      ..relativeQuadraticBezierTo(10, 10, 25, 0)
      //line
      ..relativeLineTo(57, 0)
      //analog right box
      ..relativeQuadraticBezierTo(10, 10, 25, 0)
      //right curve
      ..relativeQuadraticBezierTo(35, -5, 40, 35)
      //support line for curve (GAME PAD handle)
      ..relativeLineTo(14, 75)
      //bottom curve for right handle
      ..relativeQuadraticBezierTo(45, 5, 50, -25)
      //right handle long curve
      ..relativeQuadraticBezierTo(30, -100, -5, -200)
      //R1 L1 button
      ..relativeLineTo(-10, 0)
      ..relativeLineTo(0, -10)
      ..relativeQuadraticBezierTo(-10, -12, -50, -15)
      ..relativeLineTo(0, 15)
      //top curve
      ..relativeQuadraticBezierTo(-100, -10, -190, 0)
      //left L2 R2 button
      ..relativeLineTo(0, -15)
      ..relativeQuadraticBezierTo(-10, -8, -50, 5)
      ..relativeLineTo(0, 12)
      ..relativeLineTo(-15, 3.8);

    animatePath(ps5Skeleton, curvesPaint, canvas, playstationProgress!);
    if (displayProgress == 1.0) {
      canvas.drawPath(ps5Skeleton, blackPaint);
      canvas.drawPath(ps5Skeleton, doubleLinePaint);
    }

    //left controller socket
    final ps5LeftControlSocket = Path()
      ..moveTo(size.width / 8, size.height / 3.9 + 2)
      //Please omit
      /* ..relativeQuadraticBezierTo(-30, 100, -5, 195)
          ..moveTo(size.width / 8, size.height / 3.9 + 2)
          ..relativeLineTo(75, -10)
          ..relativeLineTo(4, 45)
          ..relativeQuadraticBezierTo(0, 10, -7, 20)
          ..relativeQuadraticBezierTo(-50, 50, -45, 160)
          ..relativeQuadraticBezierTo(-20, 5, -34, -25)*/
      ..relativeQuadraticBezierTo(-30, 100, -5, 195)
      ..relativeQuadraticBezierTo(10, 20, 50, 22)
      ..relativeQuadraticBezierTo(-30, -85, 25, -160)
      ..relativeQuadraticBezierTo(10, -10, 12, -20)
      ..relativeLineTo(-4, -42)
      ..relativeLineTo(-75, 5);

    animatePath(ps5LeftControlSocket, curvesPaint, canvas, leftSocketProgress!);
    if (displayProgress == 1.0) {
      canvas.drawPath(ps5LeftControlSocket, whitePaint);
      canvas.drawPath(ps5LeftControlSocket, doubleLinePaint);
    }

    //top controller display
    final ps5DisplayPad = Path()
      ..moveTo(size.width / 5.4 + 55, size.height / 4)
      ..relativeQuadraticBezierTo(10, -5, 150, -2)
      ..relativeLineTo(-10, 45)
      ..relativeQuadraticBezierTo(-5, 15, -20, 12)
      ..relativeLineTo(-75, 1)
      ..relativeQuadraticBezierTo(-30, 4, -30, -10)
      ..relativeLineTo(-12, -50);

    animatePath(ps5DisplayPad, curvesPaint, canvas, displayProgress!);
    if (displayProgress == 1.0) {
      canvas.drawPath(ps5DisplayPad, whitePaint);
      canvas.drawPath(ps5DisplayPad, doubleLinePaint);
    }

    //right controller socket
    final ps5RightControlSocket = Path()
      ..moveTo(size.width / 1.17, size.height / 3.9 + 10)
      ..relativeQuadraticBezierTo(42, 65, 5, 195)
      ..relativeQuadraticBezierTo(-5, 15, -40, 20)
      ..relativeQuadraticBezierTo(20, -100, -30, -160)
      ..relativeQuadraticBezierTo(-10, -12, -10, -20)
      ..relativeLineTo(0, -50)
      ..relativeLineTo(64, 8);

    animatePath(
        ps5RightControlSocket, curvesPaint, canvas, rightSocketProgress!);
    if (displayProgress == 1.0) {
      canvas.drawPath(ps5RightControlSocket, whitePaint);
      canvas.drawPath(ps5RightControlSocket, doubleLinePaint);
    }

    ///volumes button
    // !-- 4 circles
    canvas.drawCircle(Offset(size.width / 5 + 105, size.height / 3.085),
        volumeProgress!, whitePaint);
    canvas.drawCircle(Offset(size.width / 5 + 125, size.height / 3.085),
        volumeProgress!, whitePaint);
    canvas.drawCircle(Offset(size.width / 5 + 145, size.height / 3.085),
        volumeProgress!, whitePaint);

    canvas.drawCircle(Offset(size.width / 5 + 165, size.height / 3.085),
        volumeProgress!, whitePaint);
    //
    // !-- 3 circles
    canvas.drawCircle(Offset(size.width / 5 + 115, size.height / 2.985),
        volumeProgress!, whitePaint);
    canvas.drawCircle(Offset(size.width / 5 + 135, size.height / 2.985),
        volumeProgress!, whitePaint);
    canvas.drawCircle(Offset(size.width / 5 + 155, size.height / 2.985),
        volumeProgress!, whitePaint);

    //first analog
    canvas.drawCircle(center, radius, analogPaint);

    for (double r = radius; r > 0; r -= 8.9) {
      canvas.drawCircle(center, analogProgress!, analogPaint);
    }
    //second analog
    canvas.drawCircle(centre, radius, analogPaint);

    for (double r = radius; r > 0; r -= 8.9) {
      canvas.drawCircle(centre, analogProgress!, analogPaint);
    }

    ///Right D-pad circular Buttons
    final dpadOffset = Offset(
      size.width / 1.26 - dpadSize / 2,
      size.height / 3.9 + 55 - dpadSize / 2,
    );
    final dpadRect = Rect.fromLTWH(
      dpadOffset.dx,
      dpadOffset.dy,
      dpadSize,
      dpadSize,
    );

    final dpadPaint = Paint()..color = dpadBackgroundColor;
    canvas.drawRect(dpadRect, dpadPaint);

    final buttonOffsetX = dpadOffset.dx + (dpadSize - dpadButtonSize) / 2;
    final buttonOffsetY = dpadOffset.dy + (dpadSize - dpadButtonSize) / 2;

    if (volumeProgress == 5.0) {
      // draw up button
      final upButtonOffset = Offset(
        buttonOffsetX,
        buttonOffsetY - dpadButtonSpacing - dpadButtonSize,
      );
      drawButton(canvas, upButtonOffset);

      // draw down button
      final downButtonOffset = Offset(
        buttonOffsetX,
        buttonOffsetY + dpadButtonSpacing + dpadButtonSize,
      );
      drawButton(canvas, downButtonOffset);

      // draw left button
      final leftButtonOffset = Offset(
        buttonOffsetX - dpadButtonSpacing - dpadButtonSize,
        buttonOffsetY,
      );
      drawButton(canvas, leftButtonOffset);

      // draw right button
      final rightButtonOffset = Offset(
        buttonOffsetX + dpadButtonSpacing + dpadButtonSize,
        buttonOffsetY,
      );
      drawButton(canvas, rightButtonOffset);
    }
  }

  void drawButton(Canvas canvas, Offset offset) {
    final buttonRect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      dpadButtonSize,
      dpadButtonSize,
    );
    final buttonPaint = Paint()..color = dpadButtonColor;

    canvas.drawOval(buttonRect, buttonPaint);

    final borderPaint = Paint()
      ..color = dpadButtonBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = dpadButtonBorderWidth;

    canvas.drawOval(buttonRect, borderPaint);
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
