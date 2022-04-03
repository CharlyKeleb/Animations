import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_project/squidgame/squidgame_onboard.dart';

class SquidGameHome extends StatefulWidget {
  const SquidGameHome({Key? key}) : super(key: key);

  @override
  State<SquidGameHome> createState() => _SquidGameHomeState();
}

class _SquidGameHomeState extends State<SquidGameHome> {

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
        child: transition ? SquidGameOnboard() :  Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Lottie.asset('assets/lottie/lf30_editor_c8c9sumf.json',
            ),
          ),
        ),
      ),
    );
  }
}
