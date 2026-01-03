import 'package:flutter/material.dart';
import 'package:test_project/spongebob/painter.dart';

class SpongeBobHome extends StatefulWidget {
  const SpongeBobHome({Key? key}) : super(key: key);

  @override
  _SpongeBobHomeState createState() => _SpongeBobHomeState();
}

class _SpongeBobHomeState extends State<SpongeBobHome> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AnimationController _frownAnimationController;
  late final Animation _animation;
  bool _forwardOnlySmile = false;

  @override
  void initState() {
    _controllEyeAnimation();

    _controlFrownAnimation();

    super.initState();
  }

  void _controllEyeAnimation() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        _animationController.forward();
      },
    );

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation.addListener(() {
      setState(() {});
    });
    _animationController.addStatusListener((status) {
      if(_forwardOnlySmile) return;

      if (status == AnimationStatus.completed) {
        Future.delayed(
            const Duration(milliseconds: 1000), _animationController.reverse);
      } else if (status == AnimationStatus.reverse) {
        if (_animationController.value == 1) {
          Future.delayed(const Duration(milliseconds: 3500),
              _frownAnimationController.forward);
        }
      }
    });
  }

  void _controlFrownAnimation() {
    _frownAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _frownAnimationController.addListener(() {
      setState(() {});
    });

    _frownAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 2000),
            _frownAnimationController.reverse);
      } else if (status == AnimationStatus.reverse) {
        _forwardOnlySmile = true;
      }

      Future.delayed(
          const Duration(milliseconds: 3500), _animationController.forward);
    });
  }

  @override
  void dispose() {
    _frownAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(),
      home: Scaffold(
        body: Center(
          child: AspectRatio(
            aspectRatio: 360 / 500,
            child: CustomPaint(
              painter: SpongeBob(
                eyeValue: _animation.value,
                frownMouthValue: _frownAnimationController.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}