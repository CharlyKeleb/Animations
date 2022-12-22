import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final position = useState(const Offset(150, 350));
    return Scaffold(
      backgroundColor: Colors.black,
      body: Draggable(
        feedback: const CircleAvatar(
          radius: 10.0,
          backgroundColor: Colors.transparent,
        ),
        onDragUpdate: (details) => position.value = details.globalPosition,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            children: [
              //container 9
              AnimatedPositioned(
                left: position.value.dx,
                top: position.value.dy,
                duration: const Duration(microseconds:10,milliseconds: 1200),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              //container 8
              AnimatedPositioned(
                left: position.value.dx,
                top: position.value.dy,
                duration: const Duration(microseconds: 10, milliseconds: 1100),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              //container 7
              AnimatedPositioned(
                left: position.value.dx,
                top: position.value.dy,
                duration: const Duration(microseconds: 10, milliseconds: 1000),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              //container 6
              AnimatedPositioned(
                left: position.value.dx,
                top: position.value.dy,
                duration: const Duration(microseconds: 10, milliseconds: 900),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ),
              //container 5
              AnimatedPositioned(
                left: position.value.dx,
                top: position.value.dy,
                duration: const Duration(microseconds: 10, milliseconds: 800),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ),
              ),

              //container 4
              AnimatedPositioned(
                left: position.value.dx,
                top: position.value.dy,
                duration: const Duration(microseconds: 10, milliseconds: 700),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ),
              //container 3
              AnimatedPositioned(
                left: position.value.dx,
                top: position.value.dy,
                duration: const Duration(microseconds: 10, milliseconds: 600),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
              ),
              //container 2
              AnimatedPositioned(
                left: position.value.dx,
                top: position.value.dy,
                duration: const Duration(microseconds: 10, milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              //container 1
              AnimatedPositioned(
                left: position.value.dx,
                top: position.value.dy,
                duration: const Duration(microseconds: 10, milliseconds: 400),
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
