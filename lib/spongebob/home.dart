import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_project/spongebob/painter.dart';

class SpongeBobHome extends StatefulWidget {
  const SpongeBobHome({Key? key}) : super(key: key);

  @override
  _SpongeBobHomeState createState() => _SpongeBobHomeState();
}

class _SpongeBobHomeState extends State<SpongeBobHome>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AnimationController _frownAnimationController;
  late final AnimationController _idleBobController;
  late final AnimationController _strokeController;

  late final Animation<double> _animation;
  late final Animation<double> _idleBob;
  late final Animation<double> _strokeProgress;

  bool _forwardOnlySmile = false;

  @override
  void initState() {
    _controllEyeAnimation();
    _controlFrownAnimation();
    _controlIdleBob();
    _controlStrokeAnimation();
    super.initState();
  }

  void _controllEyeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        if (!mounted) return;
        _animationController.forward();
      },
    );

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);

    _animationController.addStatusListener((status) {
      if (_forwardOnlySmile) return;

      if (status == AnimationStatus.completed) {
        Future.delayed(
          const Duration(milliseconds: 1000),
          () {
            if (!mounted) return;
            _animationController.reverse();
          },
        );
      } else if (status == AnimationStatus.reverse) {
        if (_animationController.value == 1) {
          Future.delayed(
            const Duration(milliseconds: 3500),
            () {
              if (!mounted) return;
              _frownAnimationController.forward();
            },
          );
        }
      }
    });
  }

  void _controlFrownAnimation() {
    _frownAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _frownAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(
          const Duration(milliseconds: 2000),
          () {
            if (!mounted) return;
            _frownAnimationController.reverse();
          },
        );
      } else if (status == AnimationStatus.reverse) {
        _forwardOnlySmile = true;
      }

      Future.delayed(
        const Duration(milliseconds: 3500),
        () {
          if (!mounted) return;
          _animationController.forward();
        },
      );
    });
  }

  void _controlIdleBob() {
    _idleBobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _idleBob = CurvedAnimation(
      parent: _idleBobController,
      curve: Curves.easeInOut,
    );
  }

  void _controlStrokeAnimation() {
    _strokeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _strokeProgress = CurvedAnimation(
      parent: _strokeController,
      curve: Curves.easeInOut,
    );

    // Start the stroke draw-in early, then later eye/mouth changes can follow.
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      _strokeController.forward();
    });
  }

  @override
  void dispose() {
    _frownAnimationController.dispose();
    _animationController.dispose();
    _idleBobController.dispose();
    _strokeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Note: this widget returns a MaterialApp today; keeping it for compatibility
    // with the existing demo navigation in this repo.
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(),
      home: Scaffold(
        body: Center(
          child: AspectRatio(
            aspectRatio: 360 / 500,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _animationController,
                _frownAnimationController,
                _idleBobController,
                _strokeController,
              ]),
              builder: (context, _) {
                // A tiny idle bob to make SpongeBob feel alive.
                final dy = lerpDouble(-6, 6, _idleBob.value) ?? 0;

                return Transform.translate(
                  offset: Offset(0, dy),
                  child: CustomPaint(
                    painter: SpongeBob(
                      eyeValue: _animation.value,
                      frownMouthValue: _frownAnimationController.value,
                      strokeProgress: _strokeProgress.value,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

