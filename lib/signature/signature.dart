import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SignatureAnimation extends StatefulWidget {
  const SignatureAnimation({super.key});

  @override
  State<SignatureAnimation> createState() => _SignatureAnimationState();
}

class _SignatureAnimationState extends State<SignatureAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Replicating SwiftUI hue rotation logic: sign ? 0 : 180
        double hueRotation = lerpDouble(180, 0, _controller.value) ?? 0;

        return Center(
          child: Transform.scale(
            scale: 0.3, // Replicating SwiftUI .scaleEffect(0.3)
            child: ColorFiltered(
              colorFilter: ColorFilter.matrix(_hueMatrix(hueRotation)),
              child: CustomPaint(
                painter: SignaturePainter(_controller.value),
                size: const Size(400, 400),
              ),
            ),
          ),
        );
      },
    );
  }

  List<double> _hueMatrix(double rotation) {
    double rad = rotation * math.pi / 180;
    double cosV = math.cos(rad);
    double sinV = math.sin(rad);
    return [
      0.213 + cosV * 0.787 - sinV * 0.213, 0.715 - cosV * 0.715 - sinV * 0.715, 0.072 - cosV * 0.072 + sinV * 0.928, 0, 0,
      0.213 - cosV * 0.213 + sinV * 0.143, 0.715 + cosV * 0.285 + sinV * 0.140, 0.072 - cosV * 0.072 - sinV * 0.283, 0, 0,
      0.213 - cosV * 0.213 - sinV * 0.787, 0.715 - cosV * 0.715 + sinV * 0.715, 0.072 + cosV * 0.928 + sinV * 0.072, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }
}

class SignaturePainter extends CustomPainter {
  final double progress;
  SignaturePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();
    
    //Left Base Segment
    path.moveTo(0.24829*w, 0.85103*h);
    path.lineTo(0.02337*w, 0.85103*h);
    path.cubicTo(0.0105*w, 0.85103*h, 0, 0.83889*h, 0, 0.82403*h);
    path.cubicTo(0, 0.80947*h, 0.0105*w, 0.79733*h, 0.02337*w, 0.79733*h);
    path.lineTo(0.26303*w, 0.79733*h);
    path.cubicTo(0.25605*w, 0.81583*h, 0.25103*w, 0.83392*h, 0.24829*w, 0.85103*h);
    path.close();

    // Middle Base Segment
    path.moveTo(0.45619*w, 0.85103*h);
    path.lineTo(0.293*w, 0.85103*h);
    path.cubicTo(0.29592*w, 0.83433*h, 0.30155*w, 0.81615*h, 0.30966*w, 0.79733*h);
    path.lineTo(0.47918*w, 0.79733*h);
    path.cubicTo(0.4723*w, 0.81684*h, 0.46461*w, 0.83485*h, 0.45619*w, 0.85103*h);
    path.close();

    // Right Base Segment 
    path.moveTo(0.99842*w, 0.82403*h);
    path.cubicTo(0.99842*w, 0.83889*h, 0.98792*w, 0.85103*h, 0.97505*w, 0.85103*h);
    path.lineTo(0.50655*w, 0.85103*h);
    path.cubicTo(0.51424*w, 0.83452*h, 0.52105*w, 0.81646*h, 0.52713*w, 0.79733*h);
    path.lineTo(0.97505*w, 0.79733*h);
    path.cubicTo(0.98792*w, 0.79733*h, 0.99842*w, 0.80947*h, 0.99842*w, 0.82403*h);
    path.close();

    // The 'X' 
    path.moveTo(0.04123*w, 0.53975*h);
    path.lineTo(0.08574*w, 0.59094*h);
    path.lineTo(0.13025*w, 0.53975*h);
    path.cubicTo(0.13787*w, 0.53125*h, 0.14942*w, 0.53095*h, 0.1573*w, 0.53975*h);
    path.cubicTo(0.16492*w, 0.54884*h, 0.16492*w, 0.56219*h, 0.1573*w, 0.571*h);
    path.lineTo(0.11285*w, 0.62212*h);
    path.lineTo(0.1573*w, 0.67324*h);
    path.cubicTo(0.16492*w, 0.68174*h, 0.16492*w, 0.69539*h, 0.1573*w, 0.70449*h);
    path.cubicTo(0.14942*w, 0.71329*h, 0.13787*w, 0.71329*h, 0.13025*w, 0.70449*h);
    path.lineTo(0.08574*w, 0.6533*h);
    path.lineTo(0.04123*w, 0.70449*h);
    path.cubicTo(0.03361*w, 0.71299*h, 0.02206*w, 0.71329*h, 0.01418*w, 0.70449*h);
    path.cubicTo(0.00657*w, 0.69539*h, 0.00657*w, 0.68204*h, 0.01418*w, 0.67324*h);
    path.lineTo(0.05863*w, 0.62212*h);
    path.lineTo(0.01418*w, 0.571*h);
    path.cubicTo(0.00657*w, 0.5625*h, 0.00657*w, 0.54884*h, 0.01418*w, 0.53975*h);
    path.cubicTo(0.02206*w, 0.53095*h, 0.03361*w, 0.53095*h, 0.04123*w, 0.53975*h);
    path.close();

    // The Signature flourish 
    path.moveTo(0.33456*w, 0.99787*h);
    path.cubicTo(0.47216*w, 0.99787*h, 0.56329*w, 0.79612*h, 0.56329*w, 0.53883*h);
    path.cubicTo(0.56329*w, 0.31826*h, 0.47794*w, 0.14411*h, 0.34454*w, 0.14411*h);
    path.cubicTo(0.25972*w, 0.14411*h, 0.1938*w, 0.22755*h, 0.1938*w, 0.33465*h);
    path.cubicTo(0.1938*w, 0.48756*h, 0.29911*w, 0.61863*h, 0.43041*w, 0.68659*h);
    path.cubicTo(0.43435*w, 0.68902*h, 0.43776*w, 0.68962*h, 0.44144*w, 0.68962*h);
    path.cubicTo(0.45326*w, 0.68962*h, 0.46192*w, 0.679*h, 0.46192*w, 0.66748*h);
    path.cubicTo(0.46192*w, 0.65898*h, 0.45824*w, 0.65109*h, 0.44958*w, 0.64593*h);
    path.cubicTo(0.36161*w, 0.59769*h, 0.23845*w, 0.48968*h, 0.23845*w, 0.33465*h);
    path.cubicTo(0.23845*w, 0.25607*h, 0.28466*w, 0.19539*h, 0.34454*w, 0.19539*h);
    path.cubicTo(0.45089*w, 0.19539*h, 0.51865*w, 0.35042*h, 0.51865*w, 0.53883*h);
    path.cubicTo(0.51865*w, 0.76153*h, 0.44302*w, 0.9466*h, 0.33981*w, 0.9466*h);
    path.cubicTo(0.30515*w, 0.9466*h, 0.28913*w, 0.92051*h, 0.28913*w, 0.88441*h);
    path.cubicTo(0.28913*w, 0.77154*h, 0.43146*w, 0.55613*h, 0.6313*w, 0.55613*h);
    path.cubicTo(0.64601*w, 0.55613*h, 0.65415*w, 0.56281*h, 0.65415*w, 0.57464*h);
    path.cubicTo(0.65415*w, 0.6074*h, 0.63708*w, 0.63744*h, 0.63708*w, 0.67142*h);
    path.cubicTo(0.63708*w, 0.69964*h, 0.65467*w, 0.71541*h, 0.677*w, 0.71541*h);
    path.cubicTo(0.74344*w, 0.71541*h, 0.82537*w, 0.57767*h, 0.85452*w, 0.57767*h);
    path.cubicTo(0.88209*w, 0.57767*h, 0.84795*w, 0.70116*h, 0.92936*w, 0.70116*h);
    path.cubicTo(0.94275*w, 0.70116*h, 0.95929*w, 0.6969*h, 0.97321*w, 0.68689*h);
    path.cubicTo(0.9803*w, 0.68143*h, 0.98529*w, 0.67324*h, 0.98529*w, 0.66292*h);
    path.cubicTo(0.98529*w, 0.65018*h, 0.97794*w, 0.63956*h, 0.96639*w, 0.63956*h);
    path.cubicTo(0.95588*w, 0.63956*h, 0.94564*w, 0.65079*h, 0.9333*w, 0.65079*h);
    path.cubicTo(0.8947*w, 0.65079*h, 0.93225*w, 0.52093*h, 0.86686*w, 0.52093*h);
    path.cubicTo(0.80961*w, 0.52093*h, 0.72006*w, 0.65595*h, 0.69302*w, 0.65595*h);
    path.cubicTo(0.68934*w, 0.65595*h, 0.68671*w, 0.65383*h, 0.68671*w, 0.64806*h);
    path.cubicTo(0.68671*w, 0.63016*h, 0.70326*w, 0.59709*h, 0.70326*w, 0.56553*h);
    path.cubicTo(0.70326*w, 0.52791*h, 0.677*w, 0.50485*h, 0.63445*w, 0.50485*h);
    path.cubicTo(0.40914*w, 0.50485*h, 0.2437*w, 0.74879*h, 0.2437*w, 0.8935*h);
    path.cubicTo(0.2437*w, 0.95449*h, 0.27416*w, 0.99787*h, 0.33456*w, 0.99787*h);
    path.close();

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..shader = const LinearGradient(
        colors: [Colors.red, Colors.blue, Colors.green],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    // Calculate total sequential length across all subpaths
    double totalLength = 0;
    for (PathMetric metric in path.computeMetrics()) {
      totalLength += metric.length;
    }

    double drawTarget = totalLength * progress;
    double currentAccumulated = 0;

    // Draw subpaths sequentially to match SwiftUI .trim behavior
    for (PathMetric metric in path.computeMetrics()) {
      if (currentAccumulated < drawTarget) {
        double segmentEnd = (drawTarget - currentAccumulated).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(0.0, segmentEnd), paint);
      }
      currentAccumulated += metric.length;
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => oldDelegate.progress != progress;
}