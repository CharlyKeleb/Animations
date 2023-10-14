import 'package:flutter/material.dart';

class RotationHome extends StatefulWidget {
  const RotationHome({Key? key}) : super(key: key);

  @override
  State<RotationHome> createState() => _RotationHomeState();
}

class _RotationHomeState extends State<RotationHome>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _radiusAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    _rotationAnimation =
        Tween(begin: 0.roundToDouble(), end: 1.roundToDouble()).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _radiusAnimation = Tween(begin: 450.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  double x = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.003)
            ..rotateX(x),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                x = x + details.delta.dy / 100;
              });
            },
            child: Stack(
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: _rotationAnimation.value + 0.2,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(_radiusAnimation.value),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF692D94).withOpacity(0.8),
                          offset: const Offset(-6.0, -6.0),
                          // blurRadius: 5.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(6.0, 6.0),
                          // blurRadius: 16.0,
                        ),
                      ],
                      color: const Color(0xFF692D94),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _rotationAnimation.value + 0.4,
                  child: Container(
                    width: 375,
                    height: 375,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(_radiusAnimation.value),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7921B1).withOpacity(0.7),
                          offset: const Offset(-6.0, -6.0),
                          // blurRadius: 5.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(6.0, 6.0),
                          // blurRadius: 16.0,
                        ),
                      ],
                      color: const Color(0xFF7921B1),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _rotationAnimation.value + 0.6,
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(_radiusAnimation.value),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.8),
                          offset: const Offset(-6.0, -6.0),
                          // blurRadius: 5.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(6.0, 6.0),
                          // blurRadius: 16.0,
                        ),
                      ],
                      color: Colors.purple,
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _rotationAnimation.value + 0.8,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(_radiusAnimation.value),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.shade400,
                          offset: const Offset(-6.0, -6.0),
                          // blurRadius: 16.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(6.0, 6.0),
                        ),
                      ],
                      color: Colors.purple.shade400,
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _rotationAnimation.value + 1,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(_radiusAnimation.value),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFBC61F5).withOpacity(0.8),
                          offset: const Offset(-6.0, -6.0),
                          // blurRadius: 5.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(6.0, 6.0),
                        ),
                      ],
                      color: const Color(0xFFBC61F5),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _rotationAnimation.value + 1.2,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(_radiusAnimation.value),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC576F6).withOpacity(0.5),
                          offset: const Offset(-6.0, -6.0),
                          // blurRadius: 5.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(6.0, 6.0),
                        ),
                      ],
                      color: const Color(0xFFC576F6),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _rotationAnimation.value + 1.4,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(_radiusAnimation.value),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFCE8BF8).withOpacity(0.8),
                          offset: const Offset(-6.0, -6.0),
                          // blurRadius: 5.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(6.0, 6.0),
                        ),
                      ],
                      color: const Color(0xFFCE8BF8),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _rotationAnimation.value + 1.6,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(_radiusAnimation.value),
                      ),
                      boxShadow: [
                        const BoxShadow(
                          color: Color(0xFFE1BEE7),
                          offset: Offset(-6.0, -6.0),
                          // blurRadius: 5.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(6.0, 6.0),
                        ),
                      ],
                      color: const Color(0xFFE1BEE7),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: _rotationAnimation.value + 1.8,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(_radiusAnimation.value),
                      ),
                      boxShadow: [
                        const BoxShadow(
                          color: Color(0xFFF3E5F5),
                          offset: Offset(-6.0, -6.0),
                          // blurRadius: 5.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(6.0, 6.0),
                        ),
                      ],
                      color: const Color(0xFFF3E5F5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
