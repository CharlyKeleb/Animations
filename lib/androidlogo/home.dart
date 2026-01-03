import 'dart:math' as math;

import 'package:flutter/material.dart';

class AndroidHome extends StatefulWidget {
  const AndroidHome({super.key});

  @override
  State<AndroidHome> createState() => _AndroidHomeState();
}

class _AndroidHomeState extends State<AndroidHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Staged animations (0..1 each) derived from one master timeline.
  late final Animation<double> _shadow;
  late final Animation<double> _horns;
  late final Animation<double> _head;
  late final Animation<double> _body;
  late final Animation<double> _limbs;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..forward();

    // Quick fade-in for shadows/accent first.
    _shadow = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.18, curve: Curves.easeOut),
    );

    // Draw horns early.
    _horns = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.10, 0.35, curve: Curves.easeOutCubic),
    );

    // Head dome.
    _head = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.30, 0.60, curve: Curves.easeInOutCubic),
    );

    // Body.
    _body = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.52, 0.80, curve: Curves.easeInOutCubic),
    );

    // Limbs last.
    _limbs = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.70, 1.0, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Android Logo'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5.0, top: 100.0),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: AndroidLogoPainter(
                shadowProgress: _shadow.value,
                hornProgress: _horns.value,
                headProgress: _head.value,
                bodyProgress: _body.value,
                limbsProgress: _limbs.value,
              ),
              child: const SizedBox.expand(),
            );
          },
        ),
      ),
    );
  }
}

class AndroidLogoPainter extends CustomPainter {
  final double shadowProgress;
  final double hornProgress;
  final double headProgress;
  final double bodyProgress;
  final double limbsProgress;

  AndroidLogoPainter({
    required this.shadowProgress,
    required this.hornProgress,
    required this.headProgress,
    required this.bodyProgress,
    required this.limbsProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final eyesPaint = Paint()..color = Colors.white;

    final accentColor = Colors.greenAccent[700] ?? Colors.greenAccent;

    final outlinePaint = Paint()
      ..strokeWidth = 5
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Fill kicks in near the end for a nicer "finished" look.
    final isFilled = limbsProgress >= 0.98;
    final mainPaint = Paint()
      ..strokeWidth = 5
      ..color = accentColor
      ..style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // --- horns ---
    final horn1 = Path()
      ..moveTo(75, 0)
      ..relativeLineTo(50, 60);
    _drawTrimmedPath(canvas, horn1, outlinePaint, hornProgress);

    final horn2 = Path()
      ..moveTo(290, 65)
      ..relativeLineTo(50, -65);
    _drawTrimmedPath(canvas, horn2, outlinePaint, hornProgress);

    // --- head ---
    final head = Path()
      ..moveTo(size.width / 5.5, 150)
      ..relativeCubicTo(35, -175, 250, -130, 250, 0)
      ..close();
    _drawTrimmedPath(canvas, head, mainPaint, headProgress);

    // eyes (fade in with shadowProgress)
    final eyeAlpha = (255 * shadowProgress).clamp(0, 255).toInt();
    canvas.drawCircle(
      const Offset(145.0, 90.0),
      10,
      eyesPaint..color = Colors.white.withAlpha(eyeAlpha),
    );
    canvas.drawCircle(
      const Offset(275.0, 90.0),
      10,
      eyesPaint..color = Colors.white.withAlpha(eyeAlpha),
    );

    // --- body ---
    final body = Path()
      ..moveTo(size.width / 5.5, 155)
      ..relativeLineTo(250, 0)
      ..relativeLineTo(0, 180)
      ..relativeLineTo(-250, 0)
      ..close();
    _drawTrimmedPath(canvas, body, mainPaint, bodyProgress);

    // --- limbs ---
    final handRight = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width / 1.25,
            size.height / 6,
            size.width / 8,
            size.height / 5,
          ),
          const Radius.circular(50),
        ),
      );
    _drawTrimmedPath(canvas, handRight, mainPaint, limbsProgress);

    final handLeft = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width / 30,
            size.height / 6,
            size.width / 8,
            size.height / 5,
          ),
          const Radius.circular(50),
        ),
      );
    _drawTrimmedPath(canvas, handLeft, mainPaint, limbsProgress);

    final legRight = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width / 1.65,
            size.height / 2.5,
            size.width / 8,
            size.height / 5,
          ),
          const Radius.circular(50),
        ),
      );
    _drawTrimmedPath(canvas, legRight, mainPaint, limbsProgress);

    final legLeft = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width / 4.5,
            size.height / 2.5,
            size.width / 8,
            size.height / 5,
          ),
          const Radius.circular(50),
        ),
      );
    _drawTrimmedPath(canvas, legLeft, mainPaint, limbsProgress);
  }

  void _drawTrimmedPath(
    Canvas canvas,
    Path path,
    Paint paint,
    double progress,
  ) {
    final p = progress.clamp(0.0, 1.0);
    for (final metric in path.computeMetrics()) {
      final extract = metric.extractPath(0.0, metric.length * p);
      canvas.drawPath(extract, paint);
    }
  }

  // Kept for compatibility if other demos used it (currently unused here).
  double degreesToRadians(double degrees) {
    return (degrees * math.pi) / 180;
  }

  @override
  bool shouldRepaint(covariant AndroidLogoPainter oldDelegate) {
    return oldDelegate.shadowProgress != shadowProgress ||
        oldDelegate.hornProgress != hornProgress ||
        oldDelegate.headProgress != headProgress ||
        oldDelegate.bodyProgress != bodyProgress ||
        oldDelegate.limbsProgress != limbsProgress;
  }
}
