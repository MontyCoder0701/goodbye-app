import 'package:flutter/material.dart';

class CustomTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF0BB78),
      brightness: Brightness.light,
      primary: const Color(0xFFF0BB78),
      secondary: const Color(0xFF543A14),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
    ),
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF0BB78),
      brightness: Brightness.dark,
      primary: const Color(0xFFF0BB78),
      secondary: const Color(0xFF543A14),
      surface: const Color(0xFF131010),
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
  );
}
