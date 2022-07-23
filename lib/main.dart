import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
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
        home: const WalletHome(),
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
