import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/utils/type_write.dart';

class GoogleLogo extends StatefulWidget {
  final double size;

  const GoogleLogo({Key? key, this.size = 32}) : super(key: key);

  @override
  _GoogleLogoState createState() => _GoogleLogoState();
}

class _GoogleLogoState extends State<GoogleLogo> with TickerProviderStateMixin {
  AnimationController? controller;
  CurvedAnimation? curvedAnimation;

  @override
  void initState() {
    animate();
    super.initState();
  }

  int index = 4;

  @override
  Widget build(BuildContext context) {
    print('============> ${controller!.status}');
    print('============> $index');

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: index == -1 ? 105 : MediaQuery.of(context).size.width / 2.5,
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: AnimatedBuilder(
                animation: controller!,
                builder: (context, _) {
                  return CustomPaint(
                    painter: GoogleLogoPainter(
                      animation: curvedAnimation!,
                      index: index,
                    ),
                    size: Size.square(widget.size),
                  );
                },
              ),
            ),
          ),
          if (index == -1) ...[
            Center(
              child: Material(
                color: Colors.transparent,
                child: TypeWrite(
                  word: 'O O G L E',
                  seconds: 1,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w900,
                    fontSize: 30.0,
                  ),
                  textScaleFactor: 1,
                ),
              ),
            )
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void animate() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    curvedAnimation = CurvedAnimation(
      parent: controller!,
      curve: Curves.fastOutSlowIn,
    );
    controller!.forward();
    controller!.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          controller!.reset();
          setState(() {
            index--;
          });
          controller!.forward();
          if (index == -1) {
            controller!.stop();
          }
        }
      },
    );
  }
}

class GoogleLogoPainter extends CustomPainter {
  GoogleLogoPainter({required this.index, required this.animation});

  @override
  bool shouldRepaint(_) => true;

  final int index;
  final Animation animation;

  @override
  void paint(Canvas canvas, Size size) {
    final length = size.width;
    final verticalOffset = (size.height / 2) - (length / 2);
    final bounds = Offset(0, verticalOffset) & Size.square(length);
    final center = bounds.center;
    final arcThickness = size.width / 4.5;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = arcThickness;

    void drawArc(double startAngle, double sweepAngle, Color color, int index) {
      final _paint = paint..color = color;
      var animatedSweepAngle = (this.index == index
              ? animation.value
              : this.index > index
                  ? 0.0
                  : 1.0) *
          sweepAngle;
      canvas.drawArc(
        bounds,
        startAngle,
        animatedSweepAngle,
        false,
        _paint,
      );
    }

    drawArc(3.5, 1.9, Colors.red, 0);
    drawArc(2.5, 1.0, Colors.amber, 1);
    drawArc(0.9, 1.6, Colors.green.shade600, 2);
    drawArc(-0.18, 1.1, Colors.blue.shade600, 3);

    var r = bounds.centerRight.dx + (arcThickness / 2) - 4;
    canvas.drawRect(
      Rect.fromLTRB(
        center.dx,
        center.dy - (arcThickness / 2),
        index == 4
            ? getAnimValue(start: size.width / 2, end: r, animation: animation)
            : r,
        bounds.centerRight.dy + (arcThickness / 2),
      ),
      paint
        ..color = Colors.blue.shade600
        ..style = PaintingStyle.fill
        ..strokeWidth = 0,
    );
  }

  double getAnimValue({double? start, double? end, Animation? animation}) {
    return ((end! - start!) * animation!.value) + start;
  }
}
