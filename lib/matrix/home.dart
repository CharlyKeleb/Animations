import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test_project/matrix/matrix_line.dart';

class MatrixHome extends StatefulWidget {
  const MatrixHome({Key? key, this.speed = 12.0, this.maxLength = 10})
      : super(key: key);
  final double speed;
  final int maxLength;

  @override
  State<MatrixHome> createState() => _MatrixHomeState();
}

class _MatrixHomeState extends State<MatrixHome> {
  List<Widget> _verticalLines = [];
  Timer? timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _verticalLines
    );
  }
  
  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        _verticalLines.add(
            _getVerticalTextLine(context)
        );
      });
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
Widget _getVerticalTextLine(BuildContext context) {
    Key key = GlobalKey();
    return Positioned(
      key: key,
      left: Random().nextDouble() * MediaQuery.of(context).size.width,
      child: VerticalTextLine(
        onFinished: () {
          setState(() {
            _verticalLines.removeWhere((element) {
              return element.key == key;
            });
          });
        },
        speed: 20,
        maxLength: Random().nextInt(10) + 20
      ),
    );
  }
}
