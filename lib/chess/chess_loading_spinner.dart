import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_project/chess/chess.dart';

class ChessLoadingSpinner extends StatefulWidget {
  const ChessLoadingSpinner({Key? key}) : super(key: key);

  @override
  State<ChessLoadingSpinner> createState() => _ChessLoadingSpinnerState();
}

class _ChessLoadingSpinnerState extends State<ChessLoadingSpinner> {
  bool transition = false;

  startTimeout() {
    return Timer(const Duration(seconds: 5), handleTimeout);
  }

  void handleTimeout() {
    setState(() {
      transition = true;
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(
          seconds: 1,
        ),
        child: transition
            ? const Chess()
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    const Positioned(
                      top: 150.0,
                      right: 160.0,
                      child: Text(
                        'CHESS',
                        style: TextStyle(
                            fontSize: 22.0,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 150.0),
                        child: Lottie.network(
                          'https://assets2.lottiefiles.com/packages/lf20_memvksno.json',
                          width: 500.0,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 100.0,
                      left: 20.0,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/king_b.png',
                            height: 300,
                          ),
                          RotationTransition(
                            turns: const AlwaysStoppedAnimation(15 / 360),
                            child: Image.asset(
                              'assets/images/king_w.png',
                              height: 300.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
