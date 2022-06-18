import 'package:flutter/material.dart';
import 'package:test_project/chess/chess_loading_spinner.dart';
import 'package:test_project/chess/shake_animation.dart';
import 'package:test_project/utils/extensions.dart';

class ChessHome extends StatefulWidget {
  const ChessHome({Key? key}) : super(key: key);

  @override
  State<ChessHome> createState() => _ChessHomeState();
}

class _ChessHomeState extends State<ChessHome> {
  bool transition = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(
          seconds: 1,
        ),
        child: transition
            ? const ChessLoadingSpinner()
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 120.0,
                        ),
                        child: Text(
                          'WANNA BE THE\nKING OF\nCHESS',
                          style: TextStyle(
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w900,
                            fontSize: 35.0,
                          ),
                        ),
                      ).fadeInList(0, false),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ShakeWidget(
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
                      ),
                      const SizedBox(height: 40.0),
                      Center(
                        child: Container(
                          height: 45.0,
                          width: 300.0,
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                transition = true;
                              });
                            },
                            style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                  const BorderSide(
                                color: Colors.white,
                              )),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'START',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ).fadeInList(1, false),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
