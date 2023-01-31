import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/androidlogo/home.dart';
import 'package:test_project/battery/battery.dart';
import 'package:test_project/battery/home.dart';
import 'package:test_project/card_flip/flip_animation.dart';
import 'package:test_project/chess/home.dart';
import 'package:test_project/draggable_squares/home.dart';
import 'package:test_project/github/home.dart';
import 'package:test_project/rotating_container/home.dart';
import 'package:test_project/squidgame/home.dart';
import 'package:test_project/squidgame/squidgame_onboard.dart';
import 'package:test_project/starbucks/home.dart';
import 'package:test_project/wallet/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Animation',
        debugShowCheckedModeBanner: false,
        theme: themeData(
          ThemeData(
            brightness: Brightness.dark,
            backgroundColor: Colors.black,
            primarySwatch: Colors.blue,
          ),
        ),
        home: const RotationHome(),
        // home: Scaffold(
        //   body:  Center(
        //     child: AnimatedContainer(
        //             duration: const Duration(microseconds: 50),
        //             width: 420,
        //             height: 420,
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.all(
        //                 Radius.circular(300),
        //               ),
        //               boxShadow: [
        //                 BoxShadow(
        //                   color: const Color(0xFFCE8BF8).withOpacity(0.8),
        //                   offset: const Offset(-6.0, -6.0),
        //                   blurRadius: 5.0,
        //                 ),
        //                 BoxShadow(
        //                   color: Colors.black.withOpacity(0.1),
        //                   offset: const Offset(6.0, 6.0),
        //                   blurRadius: 16.0,
        //                 ),
        //               ],
        //               color: const Color(0xFFCE8BF8),
        //             ),
        //           ),
        //   ),
        // ),
      );
    });
  }
}
// Apply font to our app's theme
ThemeData themeData(ThemeData theme) {
  return theme.copyWith(
    textTheme: GoogleFonts.corbenTextTheme(
      theme.textTheme,
    ),
  );
}
