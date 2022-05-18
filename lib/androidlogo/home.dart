import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:math' as math;

class AndroidHome extends StatefulWidget {
  const AndroidHome({Key? key}) : super(key: key);

  @override
  State<AndroidHome> createState() => _AndroidHomeState();
}

class _AndroidHomeState extends State<AndroidHome>
    with TickerProviderStateMixin {
  //animation controllers
  AnimationController? logoController;
  AnimationController? logoTopController;
  AnimationController? androidTopController;
  AnimationController? strokeController;
  AnimationController? shadowController;
  AnimationController? fadeController;
  AnimationController? filledController;

  Animation<double>? logoAnimation;
  Animation<double>? logoTopAnimation;
  Animation<double>? androidTopAnimation;
  Animation<double>? strokeAnimation;
  Animation<double>? shadowAnimation;
  Animation<double>? fadeAnimation;
  Animation<double>? filledAnimation;

  @override
  void initState() {
    super.initState();
    shadowController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    logoTopController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    androidTopController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    strokeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3));
    filledController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    logoAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(logoController!);
    shadowAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(shadowController!);

    Timer(Duration(seconds: 1), () {
      logoController!.forward();
      shadowController!.forward();
    });
    logoController!.addListener(() {
      if (logoAnimation!.value == 1) {
        logoTopController!.forward();
        logoTopAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(logoTopController!);
      }
      setState(() {});
    });
    logoTopController!.addListener(() {
      if (logoTopAnimation!.value == 1) {
        androidTopController!.forward();
        androidTopAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(androidTopController!);
      }
      setState(() {});
    });

    androidTopController!.addListener(() {
      if (androidTopAnimation!.value == 1) {
        strokeController!.forward();
        strokeAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(strokeController!);
      }
      setState(() {});
    });

    strokeController!.addListener(() {
      if (strokeAnimation!.value == 1) {
        fadeController!.forward();
        fadeAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(fadeController!);
      }
      setState(() {});
    });
    shadowController!.addListener(() {
      setState(() {});
    });
    fadeController!.addListener(() {
      if (fadeAnimation!.value > 0.5) {
        filledController!.forward();
        filledAnimation =
            Tween<double>(begin: 0.0, end: 1000.0).animate(filledController!);
      }
      setState(() {});
    });
    filledController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Android Logo'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5.0, top: 100.0),
        child: CustomPaint(
          child: Container(),
          painter: AndroidLogoPainter(
            cupProgress: logoAnimation!.value,
            coverProgress: logoTopAnimation?.value ?? 0,
            coverTopProgress: androidTopAnimation?.value ?? 0,
            strawProgress: strokeAnimation?.value ?? 0,
            shadowProgress: shadowAnimation?.value ?? 0,
          ),
        ),
      ),
    );
  }
}

class AndroidLogoPainter extends CustomPainter {
  final double? cupProgress;
  final double? coverProgress;
  final double? coverTopProgress;
  final double? strawProgress;
  final double? shadowProgress;

  AndroidLogoPainter({
    this.cupProgress,
    this.coverProgress,
    this.coverTopProgress,
    this.strawProgress,
    this.shadowProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final eyesPaint = Paint()..color = Colors.white;

    final hornPaint = Paint()
      ..strokeWidth = 5
      ..color = Colors.greenAccent[700]!
      ..style = PaintingStyle.stroke;

    final curvesPaint = Paint()
      ..strokeWidth = 5
      ..color = Colors.greenAccent[700]!
      ..style =
          strawProgress == 1.0 ? PaintingStyle.fill : PaintingStyle.stroke;

    //android horn
    final horn = Path();
    horn.moveTo(75, 0);
    horn.relativeLineTo(50, 60);
    // canvas.drawPath(horn, hornPaint);
    animatePath(horn, hornPaint, canvas, shadowProgress!);

    //android second horn
    final horn2 = Path();
    horn2.moveTo(290, 65);
    horn2.relativeLineTo(50, -65);
    // canvas.drawPath(horn2, hornPaint);
    animatePath(horn2, hornPaint, canvas, shadowProgress!);

    //android logo head
    final _path1 = Path()
      ..moveTo(size.width / 5.5, 150)
      ..relativeCubicTo(50 - 15, -175, 250, -130, 250, -0)
      ..close();
    // canvas.drawPath(_path1, curvesPaint);
    animatePath(_path1, curvesPaint, canvas, coverProgress!);

    //android eyes
    canvas.drawCircle(const Offset(145.0, 90.0), 10, eyesPaint);
    //android second eyes
    canvas.drawCircle(const Offset(275.0, 90.0), 10, eyesPaint);

    //android logo body
    final _path2 = Path();
    _path2.moveTo(size.width / 5.5, 155);
    _path2.relativeLineTo(250, 0);
    _path2.relativeLineTo(0, 180);
    _path2.relativeLineTo(-250, 0);
    _path2.close();
    // canvas.drawPath(_path2, curvesPaint);
    animatePath(_path2, curvesPaint, canvas, coverTopProgress!);

    //android first hand
    final hand = Path();
    hand.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width / 1.25,
          size.height / 6,
          size.width / 8,
          size.height / 5,
        ),
        const Radius.circular(50),
      ),
    );
    // canvas.drawPath(hand, curvesPaint);
    animatePath(hand, curvesPaint, canvas, strawProgress!);

    //android second hand
    final hand2 = Path();
    hand2.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width / 30,
          size.height / 6,
          size.width / 8,
          size.height / 5,
        ),
        const Radius.circular(50),
      ),
    );
    // canvas.drawPath(hand2, curvesPaint);
    animatePath(hand2, curvesPaint, canvas, strawProgress!);

    //android first leg
    Path _path3 = Path();
    _path3.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width / 1.65,
          size.height / 2.5,
          size.width / 8,
          size.height / 5,
        ),
        const Radius.circular(50),
      ),
    );
    // canvas.drawPath(_path3, curvesPaint);
    animatePath(_path3, curvesPaint, canvas, strawProgress!);

    //android second leg
    Path _path4 = Path();
    _path4.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width / 4.5,
          size.height / 2.5,
          size.width / 8,
          size.height / 5,
        ),
        const Radius.circular(50),
      ),
    );
    animatePath(_path4, curvesPaint, canvas, strawProgress!);
  }

  double degreesToRadians(double degrees) {
    return (degrees * math.pi) / 180;
  }

  //animate the drawn path
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
