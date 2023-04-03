import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/gamepad/gamepad.dart';


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
        home: const GamePad(),
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
