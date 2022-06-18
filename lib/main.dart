import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/androidlogo/home.dart';
import 'package:test_project/androidlogo/splash.dart';

import 'package:test_project/battery/home.dart';
import 'package:test_project/chess/chess.dart';
import 'package:test_project/chess/home.dart';
import 'package:test_project/cup/cup.dart';
import 'package:test_project/card_flip/flip_animation.dart';
import 'package:test_project/squidgame/home.dart';
import 'package:test_project/web_ui/pepsi/pepsi.dart';

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

        ///Home page for the battery animation
        // home: BatteryHomePage(),
        ///Home page for squid game onboard screen
        // home: const SquidGameHome(),
        ///Home page for chess animation
        // home: const ChessHome(),
        ///Home page for android logo animation
        // home: const AndroidSplash(),
        ///Home page for flip animation
        // home: FlipAnimation(),
        ///Home page of the pepi UI(Flutter Web)
        home: PepsiUi(),
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
