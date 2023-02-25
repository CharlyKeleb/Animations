import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/flutter_compass/compass.dart';

class CompassHome extends StatefulWidget {
  const CompassHome({Key? key}) : super(key: key);

  @override
  State<CompassHome> createState() => _CompassHomeState();
}

class _CompassHomeState extends State<CompassHome>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _compassAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
    _compassAnimation =
        Tween(begin: 22.roundToDouble(), end: 25.roundToDouble()).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCirc),
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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: Colors.blue.shade900.withAlpha(90),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'N O R T H',
              style: GoogleFonts.lato(fontSize: _compassAnimation.value),
            ),
          ),
          body: const Align(
            alignment: Alignment.center,
            child: CompassView(
              bearing: 0,
              heading: 0,
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
