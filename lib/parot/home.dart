import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';


class BirdLogoPage extends StatelessWidget {
  const BirdLogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: PathAnimatedBird()),
    );
  }
}

class PathAnimatedBird extends StatefulWidget {
  const PathAnimatedBird({super.key});

  @override
  State<PathAnimatedBird> createState() => _PathAnimatedBirdState();
}

class _PathAnimatedBirdState extends State<PathAnimatedBird>
    with TickerProviderStateMixin {
  late AnimationController _drawController;
  late AnimationController _loopController;

  @override
  void initState() {
    super.initState();
        _drawController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _loopController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _drawController.forward().then((_) {
      _loopController.repeat();
    });
  }

  @override
  void dispose() {
    _drawController.dispose();
    _loopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_drawController, _loopController]),
      builder: (context, child) {
        return CustomPaint(
          size: const Size(200, 250),
          painter: BirdPainter(
            drawProgress: _drawController.value,
            loopValue: _loopController.value,
            isDrawingFinished: _drawController.isCompleted,
          ),
        );
      },
    );
  }
}

class BirdPainter extends CustomPainter {
  final double drawProgress;
  final double loopValue;
  final bool isDrawingFinished;

  BirdPainter({
    required this.drawProgress,
    required this.loopValue,
    required this.isDrawingFinished,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double u = size.width / 2;

    // Define Paints
    final purplePaint = Paint()
      ..color = const Color(0xFF8376E7)
      ..style = isDrawingFinished ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final goldPaint = Paint()
      ..color = const Color(0xFFE3BC59)
      ..style = isDrawingFinished ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = isDrawingFinished ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2.0;

    if (isDrawingFinished) {
      double bounce = math.sin(loopValue * 2 * math.pi) * 8;
      canvas.translate(0, bounce);
    }
    
    // 1. Body Path
    final Path bodyPath = Path()
      ..addRRect(RRect.fromLTRBAndCorners(
        0, 0, u * 2, u * 2.5,
        topLeft: Radius.circular(u),
        topRight: Radius.circular(u),
        bottomRight: Radius.circular(u),
        bottomLeft: Radius.zero,
      ));

    // 2. Tail Path
    final Path tailPath = Path()
      ..moveTo(0, u * 2.5)
      ..relativeArcToPoint(Offset(-u, u), radius: Radius.circular(u), clockwise: false)
      ..relativeLineTo(u, 0)
      ..close();

    // 3. Beak Path
    final Path beakPath = Path()
      ..moveTo(u * 2, u * 0.5)
      ..relativeLineTo(u, 0)
      ..relativeArcToPoint(Offset(-u, u), radius: Radius.circular(u), clockwise: true)
      ..close();

    // 4. Eye Path (The user provided function works with Paths, so we define Eye as Path)
    final Path eyePath = Path()
      ..addOval(Rect.fromCenter(center: Offset(u, u), width: u * 0.7, height: u * 0.7));

    if (!isDrawingFinished) {
      animatePath(bodyPath, purplePaint, canvas, drawProgress);
      animatePath(tailPath, purplePaint, canvas, drawProgress);
      animatePath(beakPath, goldPaint, canvas, drawProgress);
      animatePath(eyePath, whitePaint, canvas, drawProgress);
    } else {
      
      // Draw Body
      canvas.drawPath(bodyPath, purplePaint);

      // Draw Tail with "Wag"
      canvas.save();
      canvas.translate(0, u * 2.5);
      canvas.rotate(math.sin(loopValue * 2 * math.pi) * 0.05);
      canvas.translate(0, -u * 2.5);
      canvas.drawPath(tailPath, purplePaint);
      canvas.restore();

      // Draw Beak with "Chirp"
      canvas.save();
      Offset beakPivot = Offset(u * 2, u * 0.5);
      canvas.translate(beakPivot.dx, beakPivot.dy);
      canvas.rotate(math.max(0, math.sin(loopValue * 4 * math.pi) * 0.1));
      canvas.translate(-beakPivot.dx, -beakPivot.dy);
      canvas.drawPath(beakPath, goldPaint);
      canvas.restore();

      // Draw Eye with "Blink"
      double blinkTrigger = math.sin(loopValue * 2 * math.pi);
      double eyeHeightFactor = (blinkTrigger < -0.9) ? 0.1 : 1.0;
      
      canvas.save();
      canvas.translate(u, u);
      canvas.scale(1.0, eyeHeightFactor);
      canvas.translate(-u, -u);
      canvas.drawPath(eyePath, whitePaint);
      canvas.restore();
    }
  }

  // Your provided PathMetric logic
  void animatePath(Path path, Paint paint, Canvas canvas, double progress) {
    PathMetrics metrics = path.computeMetrics();
    for (PathMetric pathMetric in metrics) {
      Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * progress,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(BirdPainter oldDelegate) => true;
}