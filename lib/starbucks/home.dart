import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class StarBucks extends StatefulWidget {
  const StarBucks({Key? key}) : super(key: key);

  @override
  State<StarBucks> createState() => _StarBucksState();
}

class _StarBucksState extends State<StarBucks> with TickerProviderStateMixin {
  AnimationController? cupController;
  AnimationController? coverController;
  AnimationController? coverTopController;
  AnimationController? strawController;
  AnimationController? shadowController;
  AnimationController? fadeController;
  AnimationController? filledController;
  AnimationController? topController;

  Animation<double>? cupAnimation;
  Animation<double>? coverAnimation;
  Animation<double>? coverTopAnimation;
  Animation<double>? strawAnimation;
  Animation<double>? shadowAnimation;
  Animation<double>? fadeAnimation;
  Animation<double>? filledAnimation;
  Animation<double>? topAnimation;

  @override
  void initState() {
    super.initState();
    shadowController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    cupController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    coverController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    coverTopController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    strawController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    filledController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    topController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    cupAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(cupController!);
    shadowAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(shadowController!);
    Timer(const Duration(seconds: 2), () {
      cupController!.forward();
      shadowController!.forward();
    });
    cupController!.addListener(() {
      if (cupAnimation!.value == 1) {
        coverController!.forward();
        coverAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(coverController!);
      }
      setState(() {});
    });
    coverController!.addListener(() {
      if (coverAnimation!.value == 1) {
        coverTopController!.forward();
        coverTopAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(coverTopController!);
      }
      setState(() {});
    });

    coverTopController!.addListener(() {
      if (coverTopAnimation!.value == 1) {
        strawController!.forward();
        strawAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(strawController!);
      }
      setState(() {});
    });

    strawController!.addListener(() {
      if (strawAnimation!.value == 1) {
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
        topController!.forward();
        filledController!.forward();
        filledAnimation =
            Tween<double>(begin: 0.0, end: 1000.0).animate(filledController!);
        topController!.forward();
        topAnimation =
            Tween<double>(begin: 0.0, end: 1000.0).animate(topController!);
      }
      setState(() {});
    });

    filledController!.addListener(() {
      setState(() {});
    });
    topController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'StarBucks',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomPaint(
            child: Container(),
            painter: StarBucksPainter(
              cupProgress: cupAnimation!.value,
              coverProgress: coverAnimation?.value ?? 0,
              coverTopProgress: coverTopAnimation?.value ?? 0,
              strawProgress: strawAnimation?.value ?? 0,
              shadowProgress: shadowAnimation?.value ?? 0,
              topProgress: topAnimation?.value ?? 0,
            ),
          ),
          ClipPath(
            clipper: DrinkClipper(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: DrinkClipper(),
                    child: Container(
                      color: const Color(0xffB37A4C),
                      height: filledAnimation?.value ?? 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipPath(
            clipper: HeaderClipper(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipPath(
                    clipper: HeaderClipper(),
                    child: Container(
                      color: const Color(0xffB37A4C),
                      height: topAnimation?.value ?? 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedOpacity(
            opacity: fadeAnimation?.value ?? 0,
            duration: const Duration(seconds: 1),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.asset(
                  'assets/images/starbucks.png',
                  height: 200.0,
                  width: 200.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarBucksPainter extends CustomPainter {
  final double? cupProgress;
  final double? coverProgress;
  final double? coverTopProgress;
  final double? strawProgress;
  final double? shadowProgress;
  final double? topProgress;

  StarBucksPainter(
      {this.cupProgress,
      this.coverProgress,
      this.topProgress,
      this.coverTopProgress,
      this.strawProgress,
      this.shadowProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final coverPaint = Paint()
      ..strokeWidth = topProgress == 1000 ? 7 : 5
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    final curvesPaint = Paint()
      ..strokeWidth = 5
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    final strawPaint = Paint()
      ..strokeWidth = 4
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    final footerPaint = Paint()
      ..strokeWidth = 5
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, convertRadiusToSigma(1));

    //draw straw
    final straw = Path();
    straw.moveTo(size.width / 2.5, 85);
    straw.relativeLineTo(30, 20);
    straw.relativeLineTo(-0, 30);
    straw.relativeLineTo(10, -0);
    straw.relativeLineTo(1, -35);
    straw.relativeLineTo(-35, -20);
    straw.close();
    //Animate straw
    animatePath(straw, strawPaint, canvas, strawProgress!);

    //draw cup cover
    final cupCover = Path()
      ..moveTo(size.width / 5.5, 250)
      ..relativeCubicTo(50 - 15, -175, 250, -130, 250, -0)
      ..close();
    // Animate cup
    animatePath(cupCover, coverPaint, canvas, coverTopProgress!);

    //draw cup first line
    final cupTop = Path();
    cupTop.moveTo(54, 250);
    cupTop.relativeLineTo(300, 0);
    cupTop.relativeLineTo(0, 20);
    cupTop.relativeLineTo(-300, 0);
    cupTop.close();
    //Animate cup top layer
    animatePath(cupTop, curvesPaint, canvas, coverProgress!);

    //draw cup second line
    final cupTop2 = Path();
    cupTop2.moveTo(size.width / 5.5, 270);
    cupTop2.relativeLineTo(250, 0);
    cupTop2.relativeLineTo(0, 20);
    cupTop2.relativeLineTo(-250, 0);
    cupTop2.close();
    //Animate second cup top layer
    animatePath(cupTop2, curvesPaint, canvas, coverTopProgress!);

    //draw cup body
    final cupBody = Path();
    cupBody.moveTo(size.width / 5.2, 292);
    cupBody.relativeLineTo(30, 275);
    cupBody.relativeLineTo(179, 0);
    cupBody.relativeLineTo(30, -275);
    //Animate Cup body
    animatePath(cupBody, curvesPaint, canvas, cupProgress!);

    //draw first footer
    final footer = Path();
    footer.moveTo(120, 565.0);
    footer.relativeLineTo(165.0, 0);
    footer.relativeLineTo(0, 20);
    footer.relativeLineTo(-165.0, 0);
    footer.close();
    //Animate cup footer
    animatePath(footer, footerPaint, canvas, shadowProgress!);
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

class DrinkClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final _path4 = Path();
    _path4.moveTo(size.width / 5.2, 292);
    _path4.relativeLineTo(30, 275);
    _path4.relativeLineTo(179, 0);
    _path4.relativeLineTo(30, -275);
    return _path4;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final _path1 = Path()
      ..moveTo(size.width / 5.5, 250)
      ..relativeCubicTo(50 - 15, -175, 250, -130, 250, -0)
      ..close();
    return _path1;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
