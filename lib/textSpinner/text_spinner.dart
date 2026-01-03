import 'package:flutter/material.dart';
import 'package:test_project/textSpinner/list_colors.dart' as clr;
import 'package:test_project/textSpinner/circular_typography.dart';
import 'package:test_project/textSpinner/list_colors.dart';

class RotatingTextApp extends StatefulWidget {
  const RotatingTextApp({super.key});

  @override
  State<RotatingTextApp> createState() => _RotatingTextAppState();
}

class _RotatingTextAppState extends State<RotatingTextApp> {
  ValueNotifier<Color> textColor = ValueNotifier(Colors.black);
  bool showColorBoxes = false;

  @override
  void dispose() {
    textColor.dispose();
    super.dispose();
  }

  toggleColorBox() {
    showColorBoxes = !showColorBoxes;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width / 2;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 254, 254, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(254, 254, 254, 1),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: toggleColorBox,
            icon: Icon(
              showColorBoxes ? Icons.check : Icons.edit,
            ),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: textColor,
        builder: (context, Color color, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircularTypograpgy(
                      opacity: 2,
                      radius: width * 0.45,
                      fontSize: 12,
                      textColor: color,
                      duration: 3,
                    ),
                    CircularTypograpgy(
                      opacity: 2,
                      radius: width * 0.6,
                      fontSize: 13,
                      textColor: color,
                      duration: 2,
                    ),
                    CircularTypograpgy(
                      opacity: 4,
                      radius: width * 0.75,
                      fontSize: 14,
                      textColor: color,
                      duration: 3,
                    ),
                    CircularTypograpgy(
                      opacity: 4,
                      radius: width * 0.9,
                      fontSize: 15,
                      textColor: color,
                      duration: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              AnimatedOpacity(
                opacity: showColorBoxes ? 1 : 0,
                duration: const Duration(milliseconds: 700),
                child: ListColors(
                  selectedColor: color,
                  onSelected: (color) => textColor.value = color,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          );
        },
      ),
    );
  }
}