import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Cup extends StatefulWidget {
  const Cup({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CupState();
}

class CupState extends State<Cup> with TickerProviderStateMixin {
  AnimationController? cupController;
  AnimationController? coverController;
  AnimationController? coverTopController;
  AnimationController? strawController;
  AnimationController? shadowController;
  AnimationController? fadeController;
  AnimationController? filledController;

  Animation<double>? cupAnimation;
  Animation<double>? coverAnimation;
  Animation<double>? coverTopAnimation;
  Animation<double>? strawAnimation;
  Animation<double>? shadowAnimation;
  Animation<double>? fadeAnimation;
  Animation<double>? filledAnimation;

  @override
  void initState() {
    super.initState();
    shadowController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    cupController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    coverController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    coverTopController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    strawController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    fadeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    filledController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    cupAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(cupController!);
    shadowAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(shadowController!);
    Timer(Duration(seconds: 1), () {
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

  List<Offset> animList1 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 200.0,
          width: 120.0,
          child: Stack(
            children: [
              CustomPaint(
                painter: CupOfWater(
                  skew: .3,
                  ratio: .6,
                  fullness: 0.9,
                  cupProgress: cupAnimation!.value,
                  strawProgress: strawAnimation?.value ?? 0,
                ),
                child: Container(),
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
                          color: Colors.blue[800],
                          height: filledAnimation?.value ?? 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CupOfWater extends CustomPainter {
  final double? skew;
  final double? ratio;
  final double? fullness;
  final double? cupProgress;

  final double? strawProgress;
  CupOfWater(
      {this.skew,
      this.ratio,
      this.fullness,
      this.cupProgress,
      this.strawProgress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint black = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    Paint straw = Paint()
      ..color = Colors.black
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    Rect top = Rect.fromLTRB(0, 0, size.width, skew! + 15);
    Rect bottom = Rect.fromCenter(
      center: Offset(
        size.width * .5,
        size.height - size.width * .5 * skew! * ratio!,
      ),
      width: size.width * ratio!,
      height: size.width * skew! * ratio!,
    );

    //draw the straw
    Path strawPath = Path()
      ..moveTo(top.right - 20, top.top * top.height - 30)
      ..lineTo(size.width / 1.829, size.height / 2.9)
      ..lineTo(size.width / 1.7, size.height / 2.96)
      ..lineTo(size.width / 1.689, size.height / 2.9)
      ..lineTo(size.width / 1.78, size.height / 2.84)
      ..lineTo(bottom.right - 30, bottom.top + bottom.height * .5);

    animatePath(strawPath, straw, canvas, strawProgress!);

    //draw black line around the cup
    Path cupPath = Path()
      ..moveTo(top.left, top.top * top.height * .5)
      ..arcTo(top, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height * .5)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(top.left, top.top + top.height * .5);

    animatePath(cupPath, black, canvas, cupProgress!);

    //draw the top oval shape
    // canvas.drawOval(top, black);s
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
    Rect top = Rect.fromLTRB(0, 0, size.width, .3 + 15);
    Rect bottom = Rect.fromCenter(
      center: Offset(
        size.width * .5,
        size.height - size.width * .5 * .3 * .6,
      ),
      width: size.width * .6,
      height: size.width * .3 * .6,
    );
    Rect? water = Rect.lerp(bottom, top, .7);
    print(size.width / 1.506);
    Path waterPath = Path()
      ..moveTo(water!.left, water.top * water.height * .5)
      ..arcTo(water, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height * .5)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(water.left, water.top + water.height * .5);

    return waterPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
