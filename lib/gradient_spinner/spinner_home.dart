import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class GradientSpinner extends StatefulWidget {
  const GradientSpinner({super.key});

  @override
  GradientSpinnerState createState() => GradientSpinnerState();
}

class GradientSpinnerState extends State<GradientSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RotationTransition(
          turns: _animation,
          child: CustomPaint(
            size: const Size.square(35.0),
            painter: SpinnerPainter(
              animation: _controller,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SpinnerPainter extends CustomPainter {
  final Animation<double> animation;

  SpinnerPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    const Color greyColor = Colors.grey;
    const Color whiteColor = Colors.white;

    final Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [greyColor, whiteColor, greyColor],
        stops: [0.0, 0.5, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(
        center: const Offset(0.0, 0.0),
        radius: 30.0,
      ))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final double progress = animation.value;
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    const double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * progress;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
