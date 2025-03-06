import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF39B424);
  static const Color secondaryColor = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF121212);
  static const Color lightBackground = Color(0xFFFFFFFF);

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: Color.fromARGB(255, 177, 240, 136),
      secondary: secondaryColor,
      onSecondary: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    
    useMaterial3: true, // Enable Material 3 for future-proofing
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: Colors.black,
      secondary: secondaryColor,
      onSecondary: Colors.white,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
      error: Colors.redAccent,
      onError: Colors.black,
    ),
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.black,
    ),
    useMaterial3: true,
  );
}
