import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:test_project/androidlogo/home.dart';
import 'package:test_project/clock/home.dart';
import 'package:test_project/discord/discord.dart';
import 'package:test_project/draggable_squares/home.dart';
import 'package:test_project/flutter_compass/home.dart';
import 'package:test_project/gamepad/gamepad.dart';
import 'package:test_project/github/home.dart';
import 'package:test_project/github/sketch.dart';
import 'package:test_project/glow/glow.dart';
import 'package:test_project/google/google_home.dart';
import 'package:test_project/gradient_spinner/spinner_home.dart';
import 'package:test_project/loading_circle/loading_circle.dart';
import 'package:test_project/matrix/home.dart';
import 'package:test_project/parallax_ui/parallax_scroll.dart';
import 'package:test_project/rotating_container/home.dart';
import 'package:test_project/sphere_animation/sphere.dart';
import 'package:test_project/spider/spider_home.dart';
import 'package:test_project/spongebob/home.dart';
import 'package:test_project/spongebob/painter.dart';
import 'package:test_project/squidgame/home.dart';
import 'package:test_project/starbucks/home.dart';
import 'package:test_project/textSpinner/text_spinner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Animation',
          debugShowCheckedModeBanner: false,
          theme: themeData(
            ThemeData(
              appBarTheme: const AppBarTheme(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
                brightness: Brightness.light,
              ).copyWith(
                surface: Colors.white,
              ),
            ),
          ),
            home:   GlowAnimationScreen(),
        );
      },
    );
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


