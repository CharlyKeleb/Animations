import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_project/utils/type_write.dart';

class Github extends StatefulWidget {
  const Github({Key? key}) : super(key: key);

  @override
  State<Github> createState() => _GithubState();
}

class _GithubState extends State<Github> with TickerProviderStateMixin {
  AnimationController? catController;
  AnimationController? earController;
  AnimationController? leftBodyController;
  AnimationController? rightBodyController;
  AnimationController? tailController;

  Animation<double>? catAnimation;
  Animation<double>? earAnimation;
  Animation<double>? leftBodyAnimation;
  Animation<double>? rightBodyAnimation;
  Animation<double>? tailAnimation;

  @override
  void initState() {
    super.initState();
    tailController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    catController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    earController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    leftBodyController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    rightBodyController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    //animate
    catAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(catController!);
    Timer(const Duration(seconds: 1), () {
      catController!.forward();
    });
    catController!.addListener(() {
      if (catAnimation!.value == 1) {
        leftBodyController!.forward();
        leftBodyAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(leftBodyController!);
      }
      setState(() {});
    });
    leftBodyController!.addListener(() {
      if (leftBodyAnimation!.value == 1) {
        rightBodyController!.forward();
        rightBodyAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(rightBodyController!);
        if (leftBodyAnimation!.value == 1) {
          tailController!.forward();
          tailAnimation =
              Tween<double>(begin: 0.0, end: 1.0).animate(tailController!);
        }
      }
      setState(() {});
    });
    rightBodyController!.addListener(() {
      if (rightBodyAnimation!.value == 1) {
        earController!.forward();
        earAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(earController!);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          // Container(
          //     height: 200,
          //     width: 100,
          //     color: Colors.green,
          //     child: ShatteringWidget(
          //       builder: (shatter) => GestureDetector(
          //           child: Container(height: 40.0,width: 60.0,color: Colors.red,),
          //           onTap: shatter),
          //       onShatterCompleted: () {
          //         print('Completed');
          //       },
          //     )),
          CustomPaint(
            size: Size.infinite,
            painter: GithubPainter(
              leftBodyProgress: leftBodyAnimation?.value ?? 0,
              catProgress: catAnimation?.value,
              rightBodyProgress: rightBodyAnimation?.value ?? 0,
              tailProgress: tailAnimation?.value ?? 0,
            ),
          ),
          if (rightBodyAnimation?.value == 1)
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: TypeWrite(
                word: 'Github',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
                textScaleFactor: 1,
              ),
            ),
        ],
      ),
    );
  }
}

class GithubPainter extends CustomPainter {
  // final double? earProgress;
  final double? tailProgress;
  final double? catProgress;
  final double? leftBodyProgress;
  final double? rightBodyProgress;

  GithubPainter(
      {required this.tailProgress,
      required this.catProgress,
      required this.leftBodyProgress,
      required this.rightBodyProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final curvesPaint = Paint()
      ..strokeWidth = rightBodyProgress == 1 ? 8 : 4
      ..color = rightBodyProgress == 1 ? Colors.white : Colors.grey
      ..style = PaintingStyle.stroke;
    // ..maskFilter = MaskFilter.blur(BlurStyle.inner, convertRadiusToSigma(10));

    final tailPaint = Paint()
      ..strokeWidth = 8
      ..color = rightBodyProgress == 1 ? Colors.white : Colors.grey
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, convertRadiusToSigma(2));

    final ears = Path()
      ..moveTo(150, 150)
      ..relativeQuadraticBezierTo(-1, -20, 7, -30)
      ..relativeQuadraticBezierTo(8, -5, 30, 19)
      ..relativeQuadraticBezierTo(55, -10, 85, 0)
      ..relativeQuadraticBezierTo(1, -9, 26, -19)
      ..relativeQuadraticBezierTo(12, -8, 6, 36);

    // canvas.drawPath(ears, curvesPaint);
    animatePath(ears, curvesPaint, canvas, catProgress!);

    final leftBody = Path()
      ..moveTo(150, 150)
      ..relativeCubicTo(-30, 10, -60, 120, 40, 130)
      ..relativeQuadraticBezierTo(-25, 0, -18, 100);
    // canvas.drawPath(leftBody, curvesPaint);
    animatePath(leftBody, curvesPaint, canvas, leftBodyProgress!);

    final rightBody = Path()
      ..moveTo(300, 150)
      ..relativeCubicTo(30, 10, 60, 120, -40, 130)
      ..relativeQuadraticBezierTo(25, 0, 18, 100);
    // canvas.drawPath(rightBody, curvesPaint);
    animatePath(rightBody, curvesPaint, canvas, rightBodyProgress!);

    final tail = Path()
      ..moveTo(70, 330)
      ..relativeCubicTo(0, -40, 70, 45, 100, 0);
    // canvas.drawPath(tail, tailPaint);
    animatePath(tail, tailPaint, canvas, tailProgress!);
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
