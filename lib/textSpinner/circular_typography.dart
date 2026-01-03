import 'dart:math';

import 'package:flutter/material.dart';

import 'circular_text.dart';

class CircularTypograpgy extends StatefulWidget {
  final double radius;
  final double fontSize;
  final int duration;
  final Color textColor;
  final int opacity;
  const CircularTypograpgy({
    super.key,
    required this.radius,
    required this.fontSize,
    required this.textColor,
    required this.opacity,
    required this.duration,
  });

  @override
  State<CircularTypograpgy> createState() => _CircularTypograpgyState();
}

class _CircularTypograpgyState extends State<CircularTypograpgy>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late Animation _scaleAnimation;
  late Animation _rotationAnimation;
  double sizeScale = 0.95;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      reverseDuration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1, end: sizeScale).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
      reverseDuration: Duration(seconds: widget.duration),
    )..repeat(reverse: true);

    _rotationAnimation = Tween<double>(begin: -90.0, end: 90.0).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotationAnimation, _scaleAnimation]),
      builder: (context, _) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value * (pi / 180),
            child: Opacity(
              opacity: widget.opacity / 4,
              child: CircularText(
                radius: widget.radius,
                text: Text(
                  "あいうえおかきくけこさしすせそたちつてとあいうえさしすせそ",
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    color: widget.textColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}