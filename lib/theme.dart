import 'package:flutter/material.dart';

class AppTheme {
  static const String light = 'light';
  // static const String dark = 'dark';
  static const String system = 'system';

  static const String font = 'Poppins';

  static const lightTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Color(0xFF242424)),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF242424)),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF242424)),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF242424)),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF242424)),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xFF242424)),
  );

  static const darkTextTheme = TextTheme();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF008DDA),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF008DDA),
      secondary: Color(0xFF242424),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFFFFFFF),
      error: Color(0xFFD32F2F),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onSurface: Color(0xFF242424),
      onBackground: Color(0xFF242424),
      onError: Color(0xFFFFFFFF),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
    hintColor: const Color(0xFFD9D9D9),
    focusColor: const Color(0xFF008DDA),
    textTheme: lightTextTheme,
    fontFamily: font,
  );
}
