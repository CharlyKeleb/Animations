import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

class FlutterDash extends StatefulWidget {
  const FlutterDash({super.key});

  @override
  State<FlutterDash> createState() => _FlutterDashState();
}

class _FlutterDashState extends State<FlutterDash>
    with TickerProviderStateMixin {
  late final AnimationController _revealController;
  late final AnimationController _paintInController;
  late final AnimationController _motionController;

  @override
  void initState() {
    super.initState();

    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();

    _paintInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _motionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Sequence:
    // 1) draw outline (reveal)
    // 2) short hold
    // 3) paint-in fill
    // 4) start bounce/flap loop
    _revealController.addStatusListener((status) async {
      if (!mounted) return;
      if (status == AnimationStatus.completed) {
        await Future<void>.delayed(const Duration(milliseconds: 250));
        if (!mounted) return;
        await _paintInController.forward();
        if (!mounted) return;
        _motionController.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _revealController.dispose();
    _paintInController.dispose();
    _motionController.dispose();
    super.dispose();
  }

  static const Size _designSize = Size(970, 850);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final scale = (constraints.maxWidth / _designSize.width <
                      constraints.maxHeight / _designSize.height
                  ? constraints.maxWidth / _designSize.width
                  : constraints.maxHeight / _designSize.height)
              .clamp(0.0, 1.0);

          final revealAnim = CurvedAnimation(
            parent: _revealController,
            curve: Curves.easeInOutQuart,
          );
          final paintInAnim = CurvedAnimation(
            parent: _paintInController,
            curve: Curves.easeOutCubic,
          );
          final motionAnim = CurvedAnimation(
            parent: _motionController,
            curve: Curves.easeInOutSine,
          );

          return Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _revealController,
                _paintInController,
                _motionController,
              ]),
              builder: (context, child) {
                return CustomPaint(
                  size: Size(
                    _designSize.width * scale,
                    _designSize.height * scale,
                  ),
                  painter: FlutterDashPainter(
                    revealProgress: revealAnim.value,
                    fillOpacity: paintInAnim.value,
                    motionValue: motionAnim.value,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class FlutterDashPainter extends CustomPainter {
  final double revealProgress;
  final double fillOpacity;
  final double motionValue;

  FlutterDashPainter({
    required this.revealProgress,
    required this.fillOpacity,
    required this.motionValue,
  });

  static const Size _designSize = Size(970, 850);

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / _designSize.width;
    final sy = size.height / _designSize.height;

    canvas.save();
    canvas.scale(sx, sy);

    // Motion only after paint-in is done.
    final double motionT = (revealProgress >= 1.0 && fillOpacity >= 1.0)
        ? motionValue
        : 0.0;

    final bobOffset = motionT * -30.0;
    final wingFlap = (motionT - 0.5) * 0.6;
    final shadowScale = 1.0 - (motionT * 0.2);

    // --- PAINTS ---
    // Use opacity for the fill-in phase.
    final Paint bodyBlue = Paint()
      ..color = const Color(0xFF40C4FF)
          .withValues(alpha: (1.0 * fillOpacity).clamp(0.0, 1.0))
      ..style = PaintingStyle.fill;
    final Paint maskBlue = Paint()
      ..color = const Color(0xFF2979FF)
          .withValues(alpha: (1.0 * fillOpacity).clamp(0.0, 1.0))
      ..style = PaintingStyle.fill; // Slightly darker for the face
    final Paint darkBlue = Paint()
      ..color = const Color(0xFF03A9F4)
          .withValues(alpha: (1.0 * fillOpacity).clamp(0.0, 1.0))
      ..style = PaintingStyle.fill;
    final Paint whitePaint = Paint()
      ..color = Colors.white
          .withValues(alpha: (1.0 * fillOpacity).clamp(0.0, 1.0))
      ..style = PaintingStyle.fill;
    final Paint eyeBlack = Paint()
      ..color = const Color(0xFF212121)
          .withValues(alpha: (1.0 * fillOpacity).clamp(0.0, 1.0))
      ..style = PaintingStyle.fill;
    final Paint beakPaint = Paint()
      ..color = const Color(0xFF8D6E63)
          .withValues(alpha: (1.0 * fillOpacity).clamp(0.0, 1.0))
      ..style = PaintingStyle.fill;

    // Drawn after scaling, so strokeWidth is in design-space.
    // Keep it responsive to widget size to avoid outlines getting too thick when scaled down.
    final double outlineWidth = (8.0 / min(sx, sy)).clamp(2.0, 10.0);
    final Paint outlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = outlineWidth
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    // --- BETTER BASE (floor + contact shadow + perch) ---
    final Rect floorRect = Rect.fromCenter(
      center: const Offset(485, 842),
      width: 820,
      height: 220,
    );
    final Paint floorPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF7F7F7), Color(0xFFE9E9E9)],
      ).createShader(floorRect);
    canvas.drawOval(floorRect, floorPaint);

    final Rect contactShadowRect = Rect.fromCenter(
      center: const Offset(485, 840),
      width: (420 * shadowScale),
      height: (55 * shadowScale),
    );
    final Paint contactShadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;
    canvas.drawOval(contactShadowRect, contactShadowPaint);

    final Rect perchRect = Rect.fromCenter(
      center: const Offset(485, 800),
      width: 560,
      height: 120,
    );
    final Paint perchPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFCFD8DC), Color(0xFFB0BEC5)],
      ).createShader(perchRect)
      ..style = PaintingStyle.fill;

    final RRect perchRRect = RRect.fromRectAndRadius(
      perchRect,
      const Radius.circular(48),
    );
    canvas.drawRRect(perchRRect, outlinePaint);
    canvas.drawRRect(perchRRect, perchPaint);

    final Paint perchHighlight = Paint()
      ..color = Colors.white.withValues(alpha: 0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = max(2.0, outlineWidth * 0.35)
      ..strokeCap = StrokeCap.round;
    final RRect highlightRRect = RRect.fromRectAndRadius(
      perchRect.deflate(14).translate(0, -10),
      const Radius.circular(42),
    );
    canvas.drawRRect(highlightRRect, perchHighlight);

    // --- REVEAL PHASE: draw the silhouette outline progressively ---
    if (revealProgress < 1.0) {
      final Path silhouette = _buildSilhouettePath(bobOffset: 0.0);
      _animatePath(silhouette, outlinePaint, canvas, revealProgress);
      canvas.restore();
      return;
    }

    // When reveal is done, keep outline visible while fills fade in.

    // 2) LEGS
    final Path dashLeg = Path()
      ..addOval(Rect.fromLTWH(0, 0, 50, 95))
      ..addOval(Rect.fromLTWH(33, 0, 50, 95))
      ..addOval(Rect.fromLTWH(66, 0, 50, 95));

    final leftLeg = dashLeg.transform(_matrix(230, 750 + bobOffset));
    final rightLeg = dashLeg.transform(_matrix(623, 750 + bobOffset));
    canvas.drawPath(leftLeg, outlinePaint);
    canvas.drawPath(leftLeg, beakPaint);
    canvas.drawPath(rightLeg, outlinePaint);
    canvas.drawPath(rightLeg, beakPaint);

    // 3. MAIN BODY
    final bodyRect = Rect.fromLTWH(0, 0 + bobOffset, 970, 850);
    canvas.drawOval(bodyRect, outlinePaint);
    canvas.drawOval(bodyRect, bodyBlue);

    // 4. HAIR
    final hairPath = dashLeg.transform(_matrix(426.5, -60 + bobOffset));
    canvas.drawPath(hairPath, outlinePaint);
    canvas.drawPath(hairPath, bodyBlue);

    // 5. BELLY
    final dashBelly = Path()
      ..moveTo(160, 500 + bobOffset)
      ..quadraticBezierTo(485, 860 + bobOffset, 810, 500 + bobOffset)
      ..quadraticBezierTo(
          810 + 50, 500 + 338 + bobOffset, 485, 845 + bobOffset)
      ..quadraticBezierTo(
          160 - 50, 500 + 338 + bobOffset, 160, 500 + bobOffset);
    canvas.drawPath(dashBelly, outlinePaint);
    canvas.drawPath(dashBelly, whitePaint);

    // 6. WINGS
    final Path wingPath = Path()
      ..addOval(Rect.fromPoints(const Offset(-65, 0), const Offset(65, 290)));
    final leftWing = wingPath.transform(
        _matrix(80, 450 + bobOffset, rotation: -pi / 4 + wingFlap));
    final rightWing = wingPath.transform(
        _matrix(890, 450 + bobOffset, rotation: pi / 4 - wingFlap));
    canvas.drawPath(leftWing, outlinePaint);
    canvas.drawPath(leftWing, darkBlue);
    canvas.drawPath(rightWing, outlinePaint);
    canvas.drawPath(rightWing, darkBlue);

    // --- 7.5 THE FACE MASK ---
    final leftMaskCenter = Offset(350, 380 + bobOffset);
    final rightMaskCenter = Offset(620, 380 + bobOffset);
    canvas.drawCircle(leftMaskCenter, 220, outlinePaint);
    canvas.drawCircle(rightMaskCenter, 220, outlinePaint);
    canvas.drawCircle(leftMaskCenter, 220, maskBlue);
    canvas.drawCircle(rightMaskCenter, 220, maskBlue);

    // 7. EYES
    final leftEyeRect = Rect.fromLTWH(260, 275 + bobOffset, 180, 180);
    final rightEyeRect = Rect.fromLTWH(530, 275 + bobOffset, 180, 180);
    canvas.drawOval(leftEyeRect, outlinePaint);
    canvas.drawOval(leftEyeRect, eyeBlack);
    canvas.drawOval(rightEyeRect, outlinePaint);
    canvas.drawOval(rightEyeRect, eyeBlack);

    final leftSpark = Offset(320, 330 + bobOffset);
    final rightSpark = Offset(590, 330 + bobOffset);
    canvas.drawCircle(leftSpark, 25, outlinePaint);
    canvas.drawCircle(leftSpark, 25, whitePaint);
    canvas.drawCircle(rightSpark, 25, outlinePaint);
    canvas.drawCircle(rightSpark, 25, whitePaint);

    // 8. BEAK
    final Path beakPath = Path()
      ..moveTo(-40, 0)
      ..lineTo(40, 0)
      ..lineTo(0, 160)
      ..close();
    final beak = beakPath.transform(_matrix(485, 410 + bobOffset));
    canvas.drawPath(beak, outlinePaint);
    canvas.drawPath(beak, beakPaint);

    canvas.restore();
  }

  Path _buildSilhouettePath({required double bobOffset}) {
    // Keep it simple: animate-draw the main body oval + hair + belly curve.
    // (This avoids complex boolean ops, and still gives a clean "draw-on" reveal.)
    final Path dashLeg = Path()
      ..addOval(Rect.fromLTWH(0, 0, 50, 95))
      ..addOval(Rect.fromLTWH(33, 0, 50, 95))
      ..addOval(Rect.fromLTWH(66, 0, 50, 95));

    final Path p = Path();

    // Main body oval.
    p.addOval(Rect.fromLTWH(0, 0 + bobOffset, 970, 850));

    // Hair.
    p.addPath(dashLeg.transform(_matrix(426.5, -60 + bobOffset)), Offset.zero);

    // Belly outline.
    final Path dashBelly = Path()
      ..moveTo(160, 500 + bobOffset)
      ..quadraticBezierTo(485, 860 + bobOffset, 810, 500 + bobOffset)
      ..quadraticBezierTo(
          810 + 50, 500 + 338 + bobOffset, 485, 845 + bobOffset)
      ..quadraticBezierTo(
          160 - 50, 500 + 338 + bobOffset, 160, 500 + bobOffset);
    p.addPath(dashBelly, Offset.zero);

    return p;
  }

  void _animatePath(Path path, Paint paint, Canvas canvas, double progress) {
    final PathMetrics metrics = path.computeMetrics();
    for (final PathMetric metric in metrics) {
      final Path extractPath = metric.extractPath(0.0, metric.length * progress);
      canvas.drawPath(extractPath, paint);
    }
  }

  Float64List _matrix(double tx, double ty, {double rotation = 0}) {
    return (Matrix4.identity()
          ..translateByDouble(tx, ty, 0, 1)
          ..rotateZ(rotation))
        .storage;
  }

  @override
  bool shouldRepaint(FlutterDashPainter oldDelegate) => true;
}
