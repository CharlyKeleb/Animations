import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class Battery extends StatefulWidget {
  const Battery({Key? key}) : super(key: key);

  @override
  State<Battery> createState() => _BatteryState();
}

class _BatteryState extends State<Battery> with TickerProviderStateMixin {
  Animation<double>? chargeAnimation;
  AnimationController? chargeController;

  @override
  void initState() {
    super.initState();
    chargeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    chargeController!.forward();
    chargeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(chargeController!);
    chargeController!.addListener(() {
      setState(() {});
    });
    chargeController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        child: Container(),
        painter: BatteryPainter(chargeAnimation!.value),
      ),
    );
  }
}

class BatteryPainter extends CustomPainter {
  final double charge;

  BatteryPainter(this.charge);
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..strokeWidth = 2
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    final pinPaint = Paint()
      ..strokeWidth = 3
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final chargePaint = Paint()
      ..strokeWidth = 3
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    RRect _borderRRect(Size size) {
      // 1
      const symmetricalMargin = 100 * 2;
      // 2
      final width = size.width - symmetricalMargin - 10 - 10;
      // 3
      final height = width / 2;
      // 4
      final top = (size.height / 2) - (height / 2);
      // 5
      final radius = Radius.circular(height * 0.2);
      // 6
      final bounds = Rect.fromLTWH(100, top, width, height);
      // 7
      return RRect.fromRectAndRadius(bounds, radius);
    }

    // Battery border
    final bdr = _borderRRect(size);
    canvas.drawRRect(bdr, borderPaint);

    Rect _pinRect(RRect bdr) {
      // 1
      final center = Offset(bdr.right + 10, bdr.top + (bdr.height / 2.0));
      // 2
      final height = bdr.height * 0.38;
      // 3
      const width = 20 * 2;
      // 4
      return Rect.fromCenter(center: center, width: 25, height: height);
    }

    // Battery pin
    final pinRect = _pinRect(bdr);
    canvas.drawArc(pinRect, math.pi / 2, -math.pi, true, pinPaint);

    final percent = 0.1 * ((.3 / 0.1).round());

    RRect _chargeRRect(RRect bdr) {
      final left = bdr.left + 5;
      final top = bdr.top + 5;
      final right = bdr.right - 5;
      final bottom = bdr.bottom - 5;
      final height = bottom - top;
      final width = right - left;
      final radius = Radius.circular(height * 0.15);
      final rect = Rect.fromLTWH(left, top, width * charge, height);
      return RRect.fromRectAndRadius(rect, radius);
    }

    // Battery charge progress
    final chargeRRect = _chargeRRect(bdr);
    canvas.drawRRect(chargeRRect, chargePaint);
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




