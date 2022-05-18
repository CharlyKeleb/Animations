import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_project/androidlogo/home.dart';
import 'package:test_project/battery/battery.dart';

class AndroidSplash extends StatefulWidget {
  const AndroidSplash({Key? key}) : super(key: key);

  @override
  _AndroidSplashState createState() => _AndroidSplashState();
}

class _AndroidSplashState extends State<AndroidSplash> {
  bool transition = false;

  startTimeout() {
    return Timer(const Duration(seconds: 8), handleTimeout);
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
            ? const AndroidHome()
            : Center(
                child: Lottie.asset(
                  'assets/lottie/android.json',
                  animate: true,
                ),
              ),
      ),
    );
  }
}
