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
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    hintColor: const Color(0xFFD9D9D9),
    focusColor: const Color(0xFF008DDA),
    textTheme: lightTextTheme,
    fontFamily: font,
    inputDecorationTheme: const InputDecorationTheme(
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      prefixIconColor: Color(0xFF242424),
      labelStyle: TextStyle(
        color: Color(0xFF242424),
        fontFamily: font,
      ),
      hintStyle: TextStyle(
        color: Color(0xFFD9D9D9),
        fontFamily: font,
        fontWeight: FontWeight.w300,
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFD9D9D9),
          width: 2,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF008DDA),
          width: 2,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFD9D9D9),
          width: 2,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF008DDA)),
        overlayColor: MaterialStateProperty.all<Color>(const Color(0xFF005F8A)),
        foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFFFFFF)),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: font,
          ),
        ),
        padding:
            MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
        shape:
            MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      ),
    ),
  );
}
