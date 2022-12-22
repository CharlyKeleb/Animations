import 'package:flutter/material.dart';

class CurveContainer extends StatefulWidget {
  const CurveContainer({Key? key}) : super(key: key);

  @override
  State<CurveContainer> createState() => _CurveContainerState();
}

class _CurveContainerState extends State<CurveContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exploring Curves'),
      ),
      body: Stack(
        children: [
          CustomPaint(
            size: Size(400,400),
            painter: CurvedPainter(),
          )
        ],
      ),
    );
  }
}
class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.79555,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}