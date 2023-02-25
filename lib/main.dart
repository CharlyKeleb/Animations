import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/androidlogo/home.dart';
import 'package:test_project/battery/battery.dart';
import 'package:test_project/battery/home.dart';
import 'package:test_project/card_flip/flip_animation.dart';
import 'package:test_project/chess/home.dart';
import 'package:test_project/discord/discord.dart';
import 'package:test_project/draggable_squares/home.dart';
import 'package:test_project/flutter_compass/home.dart';
import 'package:test_project/flutter_dash/home.dart';
import 'package:test_project/github/home.dart';
import 'package:test_project/matrix/home.dart';
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
            appBarTheme: const AppBarTheme(
              elevation:0.0,
              backgroundColor: Colors.transparent
            ),
            brightness: Brightness.dark,
            backgroundColor: Colors.black,
            primarySwatch: Colors.blue,
          ),
        ),
        home: const CompassHome(),
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
