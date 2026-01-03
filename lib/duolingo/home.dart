import 'package:flutter/material.dart';

class Duolingo extends StatelessWidget {
  const Duolingo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: CustomPaint(
            painter: DuoPainter(),
          ),
        ),
      ),
    );
  }
}

class DuoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // --- Palette ---
    const Color bodyGreenColor = Color(0xFF78C800);
    const Color maskGreenColor = Color(0xFF8EE000);
    const Color beakOrangeColor = Color(0xFFFFB020);
    const Color mouthShadowColor = Color(0xFFD24A22);
    const Color footOrangeColor = Color(0xFFE08A18);
    const Color outlineColor = Color(0xFF3C3C3C);

    final bodyGreen = Paint()..color = bodyGreenColor;
    final maskGreen = Paint()..color = maskGreenColor;
    final white = Paint()..color = Colors.white;
    final beakOrange = Paint()..color = beakOrangeColor;
    final footOrange = Paint()..color = footOrangeColor;

    final stroke = Paint()
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // 1. FEET (Bottom layer)
    void drawFoot(double x) {
      final footPath = Path()
        ..addRRect(RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(x, h * 0.88), width: w * 0.16, height: h * 0.08),
            const Radius.circular(20)));
      canvas.drawPath(footPath, footOrange);
      canvas.drawPath(footPath, stroke);

      // Toe dividers
      canvas.drawLine(Offset(x - 6, h * 0.86), Offset(x - 6, h * 0.92), stroke);
      canvas.drawLine(Offset(x + 6, h * 0.86), Offset(x + 6, h * 0.92), stroke);
    }
    drawFoot(w * 0.42);
    drawFoot(w * 0.58);

    // 2. LOWER WINGS (Drawn BEFORE body to tuck behind)
    void drawLowerWing(bool left) {
      double dir = left ? -1 : 1;
      double startX = left ? w * 0.25 : w * 0.75;
      double startY = h * 0.58;

      final wingPath = Path()
        ..moveTo(startX, startY)
        ..cubicTo(
            startX + (dir * w * 0.3), startY + (h * 0.05), // Flare out
            startX + (dir * w * 0.25), startY + (h * 0.28), // Bottom curve
            startX, startY + (h * 0.22)                    // Return to body
        )
        ..close();

      canvas.drawPath(wingPath, bodyGreen);
      canvas.drawPath(wingPath, stroke);

      // Feather detail line
      final detailPath = Path()
        ..moveTo(startX + (dir * w * 0.12), startY + (h * 0.10))
        ..quadraticBezierTo(
            startX + (dir * w * 0.18), startY + (h * 0.16),
            startX + (dir * w * 0.12), startY + (h * 0.22)
        );
      canvas.drawPath(detailPath, stroke);
    }
    drawLowerWing(true);
    drawLowerWing(false);

    // 3. MAIN BODY
    final bodyPath = Path()
      ..moveTo(w * 0.25, h * 0.3)
      ..quadraticBezierTo(w * 0.5, h * 0.18, w * 0.75, h * 0.3)
      ..lineTo(w * 0.82, h * 0.6)
      ..quadraticBezierTo(w * 0.82, h * 0.9, w * 0.5, h * 0.9)
      ..quadraticBezierTo(w * 0.18, h * 0.9, w * 0.18, h * 0.6)
      ..close();
    canvas.drawPath(bodyPath, bodyGreen);
    canvas.drawPath(bodyPath, stroke);

    // 4. FACE MASK
    final maskPath = Path()
      ..moveTo(w * 0.23, h * 0.45)
      ..cubicTo(w * 0.3, h * 0.25, w * 0.4, h * 0.38, w * 0.5, h * 0.34) // Left brow peak
      ..cubicTo(w * 0.6, h * 0.38, w * 0.7, h * 0.25, w * 0.77, h * 0.45) // Right brow peak
      ..lineTo(w * 0.79, h * 0.6)
      ..quadraticBezierTo(w * 0.5, h * 0.76, w * 0.21, h * 0.6)
      ..close();
    canvas.drawPath(maskPath, maskGreen);
    canvas.drawPath(maskPath, stroke);

    // 5. EYES
    void drawEye(double cx) {
      canvas.drawOval(Rect.fromCenter(center: Offset(cx, h * 0.46), width: w * 0.2, height: h * 0.25), white);
      canvas.drawOval(Rect.fromCenter(center: Offset(cx, h * 0.46), width: w * 0.2, height: h * 0.25), stroke);

      final pupilPath = Path()
        ..addOval(Rect.fromCenter(center: Offset(cx, h * 0.46), width: w * 0.08, height: h * 0.14));
      canvas.drawPath(pupilPath, Paint()..color = outlineColor);

      canvas.drawCircle(Offset(cx - w * 0.015, h * 0.43), w * 0.018, white);
    }
    drawEye(w * 0.36);
    drawEye(w * 0.64);

    // 6. BEAK
    final beakPath = Path()
      ..moveTo(w * 0.44, h * 0.54)
      ..quadraticBezierTo(w * 0.5, h * 0.5, w * 0.56, h * 0.54)
      ..lineTo(w * 0.5, h * 0.66)
      ..close();
    canvas.drawPath(beakPath, beakOrange);
    canvas.drawPath(beakPath, stroke);

    final mouthPaint = Paint()..color = mouthShadowColor;
    final mouthPath = Path()
      ..moveTo(w * 0.47, h * 0.6)
      ..lineTo(w * 0.5, h * 0.63)
      ..lineTo(w * 0.53, h * 0.6)
      ..close();
    canvas.drawPath(mouthPath, mouthPaint);

    // 7. CHEST MARKS
    final chestPaint = Paint()
      ..color = maskGreenColor.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    void drawChestMark(double x, double y) {
      canvas.drawOval(Rect.fromLTWH(x, y, w * 0.08, h * 0.032), chestPaint);
    }
    drawChestMark(w * 0.39, h * 0.72);
    drawChestMark(w * 0.53, h * 0.72);
    drawChestMark(w * 0.46, h * 0.78);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}