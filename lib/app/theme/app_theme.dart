import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized app theme.
///
/// Individual demos should avoid creating their own MaterialApp. They can
/// still override colors locally (Theme.of(context).copyWith(...)) if needed.
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    final base = ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      colorScheme: const ColorScheme.dark(
        primary: Colors.blue,
        surface: Color(0xFF121212),
      ),
      scaffoldBackgroundColor: const Color(0xFF0B0B0B),
    );

    return base.copyWith(
      textTheme: GoogleFonts.corbenTextTheme(base.textTheme),
    );
  }
}
