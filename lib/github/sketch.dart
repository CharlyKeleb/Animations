import 'dart:ui';
import 'package:flutter/material.dart';

class GithubLoader extends StatefulWidget {
  @override
  _GithubLoaderState createState() => _GithubLoaderState();
}

class _GithubLoaderState extends State<GithubLoader>
    with TickerProviderStateMixin {
  late AnimationController bodyController;
  late Animation<double> bodyAnimation;
  late AnimationController tailController;
  late Animation<double> tailAnimation;

  @override
  void initState() {
    super.initState();

    // Body Animation
    bodyController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    bodyAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(bodyController)
      ..addListener(() {
        setState(() {});

        // Start tail animation when body is 98% complete
        if (bodyAnimation.value >= 0.98 && !tailController.isAnimating) {
          tailController.forward();
        }
      });

    // Tail Animation
    tailController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Shorter duration for a trailing effect
    );

    tailAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(tailController)
      ..addListener(() {
        setState(() {});
      });

    bodyController.forward();
  }

  @override
  void dispose() {
    bodyController.dispose();
    tailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Octocat
          Center(
            child: CustomPaint(
              size: const Size(400, 900),
              painter: OctocatPainter(opacity: 0.35, strokeWidth: 2.5),
            ),
          ),
          // Animate Body
          Center(
            child: CustomPaint(
              size: const Size(400, 900),
              painter: OctocatTrimPainter(
                bodyProgress: bodyAnimation.value,
                tailProgress: tailAnimation.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OctocatTrimPainter extends CustomPainter {
  final double bodyProgress;
  final double tailProgress;

  OctocatTrimPainter({required this.bodyProgress, required this.tailProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Octocat body path
    path.moveTo(243.77, 483.38);
    path.lineTo(243.77, 441.77);
    path.lineTo(243.79, 441.46);
    path.cubicTo(244.53, 431, 240.68, 420.73, 233.25, 413.32);
    path.cubicTo(267.46, 409.95, 303, 397.16, 303, 338.47);
    path.cubicTo(303, 323.32, 297.11, 308.76, 286.56, 297.86);
    path.cubicTo(291.84, 284.47, 291.33, 269.84, 285.57, 256.94);
    path.cubicTo(285.88, 257.63, 273.17, 253.87, 243.77, 273.54);
    path.lineTo(243.37, 273.43);
    path.cubicTo(218.94, 266.9, 193.21, 266.9, 168.78, 273.43);
    path.cubicTo(138.98, 253.87, 126.28, 257.63, 126.28, 257.63);
    path.lineTo(126.2, 257.81);
    path.cubicTo(120.67, 270.81, 120.42, 285.45, 125.49, 298.63);
    path.cubicTo(115.05, 308.76, 109.15, 323.33, 109.15, 338.48);
    path.cubicTo(109.15, 397.06, 144.69, 409.85, 178.51, 414.04);
    path.cubicTo(171.34, 421.45, 167.67, 431.52, 168.38, 441.76);
    path.lineTo(168.38, 483.38);

    // Animate Body Path
    animatePath(path, paint, canvas, bodyProgress);

    // Tail Path
    Path tailPath = Path();
    tailPath.moveTo(168.38, 451.13);
    tailPath.cubicTo(114.54, 467.25, 114.54, 424.25, 93, 418.88);

    // Animate Tail Path separately
    animatePath(tailPath, paint, canvas, tailProgress);
  }

  animatePath(Path path, Paint paint, Canvas canvas, double progress) {
    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(0.0, pathMetric.length * progress);
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class OctocatPainter extends CustomPainter {
  final double opacity;
  final double strokeWidth;

  OctocatPainter({this.opacity = 1.0, this.strokeWidth = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Define the Octocat path
    path.moveTo(243.77, 483.38);
    path.lineTo(243.77, 441.77);
    path.lineTo(243.79, 441.46);
    path.cubicTo(244.53, 431, 240.68, 420.73, 233.25, 413.32);
    path.cubicTo(267.46, 409.95, 303, 397.16, 303, 338.47);
    path.cubicTo(303, 323.32, 297.11, 308.76, 286.56, 297.86);
    path.cubicTo(291.84, 284.47, 291.33, 269.84, 285.57, 256.94);
    path.cubicTo(285.88, 257.63, 273.17, 253.87, 243.77, 273.54);
    path.lineTo(243.37, 273.43);
    path.cubicTo(218.94, 266.9, 193.21, 266.9, 168.78, 273.43);
    path.cubicTo(138.98, 253.87, 126.28, 257.63, 126.28, 257.63);
    path.lineTo(126.2, 257.81);
    path.cubicTo(120.67, 270.81, 120.42, 285.45, 125.49, 298.63);
    path.cubicTo(115.05, 308.76, 109.15, 323.33, 109.15, 338.48);
    path.cubicTo(109.15, 397.06, 144.69, 409.85, 178.51, 414.04);
    path.cubicTo(171.34, 421.45, 167.67, 431.52, 168.38, 441.76);
    path.lineTo(168.38, 483.38);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
