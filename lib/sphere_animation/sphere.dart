import 'dart:math';
import 'package:flutter/material.dart';


class SphereAnimation extends StatefulWidget {
  const SphereAnimation({super.key});

  @override
  State<SphereAnimation> createState() => SphereAnimationState();
}

class SphereAnimationState extends State<SphereAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late DateTime _start;

  @override
  void initState() {
    super.initState();
    _start = DateTime.now();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final time = DateTime.now().difference(_start).inMilliseconds / 1000.0;
          final rotation = sin(time) * 2;

          return CustomPaint(
            painter: SpherePainter(
              time: time,
              rotation: rotation,
              // screenSize: MediaQuery.of(context).size,
            ),
            size: MediaQuery.of(context).size,
          );
        },
      ),
    );
  }
}

class SpherePainter extends CustomPainter {
  final double time;
  final double rotation;

  SpherePainter({required this.time, required this.rotation});

  @override
  void paint(Canvas canvas, Size size) {
    final pointSize = min(size.width, size.height) * 0.002;
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint();

    for (int ring = 0; ring < 40; ring++) {
      final ringRadius = ring * 12.0;
      final points = min((ringRadius * 1.5).toInt(), 100);

      for (int point = 0; point < points; point++) {
        final angle = (point / points) * 2 * pi + rotation;

        final wobble = sin(time * 2 + ringRadius / 10) * 10;
        final distanceModifier = 1 + sin(angle * 3 + time) * 0.1;
        final adjustedRadius = (ringRadius + wobble) * distanceModifier;

        final x = cos(angle) * adjustedRadius;
        final y = sin(angle) * adjustedRadius;
        final offset = Offset(center.dx + x, center.dy + y);

        // Fixing hue calculation
        final hue = (((ringRadius / 360 + time / 5) % 1.0) * 1.5) % 1.0;
        final brightness = 0.7 + sin(time * 3 + angle) * 0.3;
        final color = HSVColor.fromAHSV(1.0, hue * 360, 1.0, brightness)
            .toColor();

        paint.color = color.withOpacity(1.0);
        canvas.drawCircle(offset, pointSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
