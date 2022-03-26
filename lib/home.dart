import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_project/battery/battery.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        duration: const Duration(seconds: 1),
        child: transition
            ? const Battery()
            : Center(
                child: Lottie.network(
                  'https://assets1.lottiefiles.com/packages/lf20_biWZlL.json',
                  animate: true,
                ),
              ),
      ),
    );
  }
}
