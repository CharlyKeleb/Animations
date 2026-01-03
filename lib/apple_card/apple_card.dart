

import 'package:flutter/material.dart';

class AppleCard extends StatefulWidget {
  const AppleCard({super.key});

  @override
  State<AppleCard> createState() => _AppleCardState();
}

class _AppleCardState extends State<AppleCard> {
  Offset _mousePosition = Offset.zero;
  final GlobalKey _cardKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            _mousePosition = event.position;
          });
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Center(
                  child: GlowBorderCard(
                    key: _cardKey,
                    mousePosition: _mousePosition,
                    width: 300,
                    height: 300,
                    borderRadius: 28,
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.apple, color: Colors.white, size: 40),
                          SizedBox(height: 20),
                          Text(
                            'Apple',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'All my hardware is Apple. It\'s simple, reliable, and keeps my workflow smooth.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


class GlowBorderCard extends StatelessWidget {
  final Offset mousePosition;
  final Widget child;
  final double width;
  final double height;
  final double borderRadius;

  const GlowBorderCard({
    super.key,
    required this.mousePosition,
    required this.child,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    RenderBox? box = key is GlobalKey ? (key as GlobalKey).currentContext?.findRenderObject() as RenderBox? : null;
    Offset cardPosition = box?.localToGlobal(Offset.zero) ?? Offset.zero;

    Offset localMouse = mousePosition - cardPosition;

    return CustomPaint(
      painter: GlowPainter(
        mouseLocal: localMouse,
        cardSize: Size(width, height),
        borderRadius: borderRadius,
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }
}

class GlowPainter extends CustomPainter {
  final Offset mouseLocal;
  final Size cardSize;
  final double borderRadius;

  GlowPainter({
    required this.mouseLocal,
    required this.cardSize,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & cardSize;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final path = Path()..addRRect(rrect);

    final glowPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment(
          (mouseLocal.dx / cardSize.width) * 2 - 1,
          (mouseLocal.dy / cardSize.height) * 2 - 1,
        ),
        radius: 0.5,
        colors: [
          Colors.pinkAccent.withOpacity(0.8),
          Colors.orange.withOpacity(0.6),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawPath(path, glowPaint);
  }

  @override
  bool shouldRepaint(covariant GlowPainter oldDelegate) {
    return oldDelegate.mouseLocal != mouseLocal;
  }
}


