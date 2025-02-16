
import 'dart:async';

import 'package:flutter/material.dart';

class GlowAnimationScreen extends StatefulWidget {
  const GlowAnimationScreen({super.key});

  @override
  _GlowAnimationScreenState createState() => _GlowAnimationScreenState();
}

class _GlowAnimationScreenState extends State<GlowAnimationScreen> {
  List<_GlowPoint> points = [];
  late Timer _timer;
  double time = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        time = DateTime.now().millisecondsSinceEpoch / 1000.0;
        points.removeWhere((point) => time - point.creationTime > 3);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          points.add(_GlowPoint(details.localPosition, time));
          if (points.length > 100) {
            points.removeAt(0);
          }
        });
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: CustomPaint(
          painter: GlowPainter(points, time),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class GlowPainter extends CustomPainter {
  final List<_GlowPoint> points;
  final double time;

  GlowPainter(this.points, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);

    for (var point in points) {
      double age = time - point.creationTime;
      double opacity = (1 - age / 3).clamp(0, 1);
      double radius = (40 - age * 10).clamp(1, 40);

      paint.color = HSVColor.fromAHSV(1, (age * 360) % 360, 1, 1).toColor().withOpacity(opacity);
      canvas.drawCircle(point.position, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _GlowPoint {
  final Offset position;
  final double creationTime;

  _GlowPoint(this.position, this.creationTime);
}
