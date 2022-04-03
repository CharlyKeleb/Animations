import 'package:flutter/material.dart';

import 'package:test_project/battery/home.dart';
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

      //Home page for the battery animation
      // home: BatteryHomePage(),

      home: const SquidGameHome(),
    );
  }
}
