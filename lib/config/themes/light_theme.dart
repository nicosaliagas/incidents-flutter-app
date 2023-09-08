import 'package:flutter/material.dart';

// Kinda like a getter to import theme from other files
final ThemeData lightTheme = _buildTheme();

//Define Base theme for app
ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: const Color(0xFF0061A4),
      primaryContainer: const Color(0xFFD1E4FF),
      onPrimary: Colors.white,
      onPrimaryContainer: const Color(0xFF001D36),
      secondary: const Color(0xFF535F70),
      secondaryContainer: const Color(0xFFD7E3F7),
      onSecondary: Colors.white,
      onSecondaryContainer: const Color(0xFF101C2B),
      error: const Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: const Color(0xFFFFDAD6),
      onErrorContainer: const Color(0xFF410002),
      background: const Color(0xFFFDFCFF),
      onBackground: Color(0xFF1A1C1E),
      surface: const Color(0xFFFDFCFF),
      onSurface: const Color(0xFF1A1C1E),
    ),
    //textTheme: _textTheme(base.textTheme),
    // below text theme add this
    // Define styles for elevated button
    elevatedButtonTheme: _elevatedButtonTheme(base.elevatedButtonTheme),
    scaffoldBackgroundColor: const Color(0xfffbfcfd),
    // Set Themes for Input Your homework

    // Define theme for text input
  );
}

// Outside of _asthaTutorialTheme function  create another function

TextTheme _textTheme(TextTheme base) => base.copyWith(
      headlineLarge: base.headlineLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 40,
          letterSpacing: 0.25,
          fontWeight: FontWeight.w400,
          color: const Color(0xb3ffffff)),
      headlineMedium: base.headlineLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 34,
          letterSpacing: 0.25,
          fontWeight: FontWeight.w400,
          color: const Color(0xb3ffffff)),
      headlineSmall: base.headlineLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 24,
          letterSpacing: 0.25,
          fontWeight: FontWeight.w400,
          color: Colors.white),
      bodyLarge: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 16,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400,
          color: Colors.white),
      bodyMedium: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 14,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400,
          color: Colors.white),
      bodySmall: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 14,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400,
          color: const Color(0xb3ffffff)),
      displayLarge: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 96,
          letterSpacing: -1.5,
          fontWeight: FontWeight.w300,
          color: const Color(0xb3ffffff)),
      displayMedium: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 60,
          letterSpacing: -0.5,
          fontWeight: FontWeight.w300,
          color: const Color(0xb3ffffff)),
      displaySmall: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 48,
          letterSpacing: 0,
          fontWeight: FontWeight.w400,
          color: const Color(0xb3ffffff)),
      labelLarge: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 14,
          letterSpacing: 1.25,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFffffff)),
      labelMedium: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 11,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFffffff)),
      labelSmall: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 10,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFffffff)),
      titleLarge: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 20,
          letterSpacing: 0.15,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFffffff)),
      titleMedium: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 16,
          letterSpacing: 0.15,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFffffff)),
      titleSmall: base.bodyLarge!.copyWith(
          fontFamily: "Segoe UI",
          fontSize: 14,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFffffff)),
    );

InputDecorationTheme _inputDecorationTheme(InputDecorationTheme base) =>
    const InputDecorationTheme(
// Label color for the input widget
      labelStyle: TextStyle(color: Colors.black),
// Define border of input form while focused on
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
          color: Colors.black,
          style: BorderStyle.solid,
        ),
      ),
    );

ElevatedButtonThemeData _elevatedButtonTheme(ElevatedButtonThemeData base) =>
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
