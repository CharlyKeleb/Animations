import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton> with TickerProviderStateMixin {
  AnimationController? borderController;

  Animation<double>? borderAnimation;
  @override
  void initState() {
    super.initState();
    borderController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    borderAnimation =
        Tween<double>(begin: 50.0, end: 200.0).animate(borderController!);
    borderController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => borderController!.forward(),
          child: Container(
            height: 50.0,
            width: borderAnimation!.value,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 3.0),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: const  Icon(CupertinoIcons.search),
          ),
        ),
      ),
    );
  }
}