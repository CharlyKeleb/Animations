import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlippingCard extends StatefulWidget {
  @override
  _FlippingCardState createState() => _FlippingCardState();
}

class _FlippingCardState extends State<FlippingCard> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!);

    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller!.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller!.forward();
      }
    });

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_animation!.value * math.pi),
          child: child,
        );
      },
      child: Container(
        width: 300,
        height: 300,
        color: Colors.red,
      ),
    );
  }
}
