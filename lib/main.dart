import 'package:flutter/material.dart';
import 'package:test_project/androidlogo/home.dart';
import 'package:test_project/androidlogo/splash.dart';

import 'package:test_project/battery/home.dart';
import 'package:test_project/chess/chess.dart';
import 'package:test_project/chess/home.dart';
import 'package:test_project/cup/cup.dart';
import 'package:test_project/squidgame/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        primarySwatch: Colors.blue,
      ),

      ///Home page for the battery animation
      // home: BatteryHomePage(),
      ///Home page for squid game onboard screen
      // home: const SquidGameHome(),
      ///Home page for chess animation
      // home: const ChessHome(),
      ///Home page for android logo animation
      home: const AndroidSplash(),
    );
  }
}
