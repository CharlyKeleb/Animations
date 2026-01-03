import 'dart:math';

import 'package:flutter/material.dart';

class CircularText extends StatelessWidget {
  final Text text;
  final double radius;

  const CircularText({
    super.key,
    required this.text,
    required this.radius,
  }) : assert(radius >= 0);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(2 * radius, 2 * radius),
      child: CustomPaint(
        painter: _CircularTextPainter(
          text: text,
          textDirection: Directionality.of(context),
        ),
      ),
    );
  }
}

class _CircularTextPainter extends CustomPainter {
  final Text text;
  final TextDirection textDirection;

  _CircularTextPainter({
    required this.text,
    required this.textDirection,
  });

  double _radius = 0.0;

  @override
  void paint(Canvas canvas, Size size) {
    _radius = min(size.width / 2, size.height / 2);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.save();
    List<TextPainter> charPainters = text.data!.split('').map((e) {
      return TextPainter(
        text: TextSpan(
          text: e,
          style: text.style,
        ),
        textDirection: textDirection,
      )..layout();
    }).toList();
    _paintTextClockwise(canvas, size, charPainters);
    canvas.restore();
  }

  void _paintTextClockwise(
    Canvas canvas,
    Size size,
    List<TextPainter> charPainters,
  ) {
    double angleStep = 2 * pi / charPainters.length;

    for (int i = 0; i < charPainters.length; i++) {
      final tp = charPainters[i];
      final x = -tp.width / 2;
      final y = -_radius - (tp.height / 2);

      tp.paint(canvas, Offset(x, y));
      canvas.rotate(angleStep);
    }
  }

  @override
  bool shouldRepaint(_CircularTextPainter oldDelegate) {
    return true;
    // bool isTextItemsChanged() {
    //   bool isChanged = false;
    //   for (int i = 0; i < children.length; i++) {
    //     if (children[i].isChanged(oldDelegate.children[i])) {
    //       isChanged = true;
    //       break;
    //     }
    //   }
    //   return isChanged;
    // }

    // return isTextItemsChanged() || oldDelegate.textDirection != textDirection;
  }
}