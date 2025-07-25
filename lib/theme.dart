import 'package:flutter/material.dart';

class CustomColor {
  CustomColor._();

  static const stone = MaterialColor(0xFF78716C, <int, Color>{
    50: Color(0xFFFAFAF9),
    100: Color(0xFFF5F5F4),
    200: Color(0xFFE7E5E4),
    300: Color(0xFFD6D3D1),
    400: Color(0xFFA8A29E),
    500: Color(0xFF78716C),
    600: Color(0xFF57534E),
    700: Color(0xFF44403C),
    800: Color(0xFF292524),
    900: Color(0xFF1C1917),
  });
}

class CustomTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF0BB78),
      brightness: Brightness.light,
      primary: const Color(0xFFF0BB78),
      secondary: CustomColor.stone.shade600,
      onPrimary: Colors.white,
      onSecondary: CustomColor.stone.shade200,
      onSurface: CustomColor.stone.shade900,
      tertiary: CustomColor.stone.shade500,
      outline: CustomColor.stone.shade300,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: CustomColor.stone.shade900,
        fontWeight: FontWeight.w700,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(iconSize: 30),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: const Color(0xFFF0BB78),
        foregroundColor: CustomColor.stone.shade600,
        textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
    ),
  );
}
