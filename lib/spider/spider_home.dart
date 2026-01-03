import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SpiderHome extends StatefulWidget {
  const SpiderHome({super.key});

  @override
  State<SpiderHome> createState() => _SpiderHomeState();
}

class _SpiderHomeState extends State<SpiderHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: SpiderPainter(),
            child: Container(),
          ),
          Positioned(
            top: 170,
            width: MediaQuery.of(context).size.width/1.1097,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Center(
                child: SizedBox(
                  width: 25.0,
                  height: 45.0,
                  child: CustomPaint(painter: EyePainter()),
                ),
              ),
            ),
          ),
          //
            Positioned(
            top: 170,
            width: MediaQuery.of(context).size.width/0.7999997,
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Center(
                child: SizedBox(
                  width: 25.0,
                  height: 45.0,
                  child: CustomPaint(painter: EyePainter()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpiderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = Paint()
      ..strokeWidth = 3.0
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, convertRadiusToSigma(1));

    final fillPaint = Paint()
      ..strokeWidth = 3.0
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final spider = Path()
      ..moveTo(size.width / 3.0, size.height / 3.3)
      //Left Longer Leg
      ..relativeLineTo(22, -13)
      ..relativeLineTo(-50, 75)
      ..relativeLineTo(55, 45)
      ..relativeLineTo(-2, -15)
      ..relativeLineTo(-27, -28)
      ..relativeLineTo(60, -65)
      //
      ..relativeLineTo(-25, 45)
      ..relativeLineTo(25, 35)
      ..relativeLineTo(0.4, -15)
      ..relativeLineTo(-7.5, -19)
      ..relativeLineTo(30, -35)
      ..relativeLineTo(30, 35)
      ..relativeLineTo(-7.5, 19)
      ..relativeLineTo(-0.4, 15)
      ..relativeLineTo(25, -35) //---> change with 30
      //Rigth Longer Leg
      ..relativeLineTo(-25, -45)
      ..relativeLineTo(60, 65)
      ..relativeLineTo(-27, 28)
      ..relativeLineTo(-2, 15)
      ..relativeLineTo(55, -45)
      ..relativeLineTo(-50, -75) //----->
      //upper right hand
      ..relativeLineTo(22, 13)
      ..relativeLineTo(25, -75)
      ..relativeLineTo(-20, 10)
      ..relativeLineTo(-25.0, 45)
      //
      ..relativeLineTo(17.0, -75)
      ..relativeLineTo(-35, -25) //-- reduce back to 30 to fit better
      ..relativeLineTo(0.0, 18)
      //triangle header
      ..relativeLineTo(-40, -50)
      ..relativeLineTo(-40, 50)
      //
      ..relativeLineTo(0.0, -18)
      ..relativeLineTo(-35, 25)
      ..relativeLineTo(15.0, 75)
      //
      ..relativeLineTo(-25, -45)
      ..relativeLineTo(-20, -10)
      // ..relativeLineTo(36.899, 112.5)
      ..close();
    canvas.drawPath(spider, fillPaint);
    canvas.drawPath(spider, blackPaint);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class EyePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Adjust the paint properties
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Create a smaller path for the water drop
    Path path = Path();
    path.moveTo(size.width / 2, size.height * 0.1); // Top point
    path.cubicTo(
        size.width * 0.05,
        size.height * 0.2, // Control point 1
        size.width * 0.05,
        size.height * 0.8, // Control point 2
        size.width / 2,
        size.height * 0.9 // Bottom point
        );
    path.cubicTo(
        size.width * 0.95,
        size.height * 0.8, // Control point 1
        size.width * 0.95,
        size.height * 0.2, // Control point 2
        size.width / 2,
        size.height * 0.1 // Top point
        );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
