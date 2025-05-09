import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF39B424);
  static const Color secondaryColor = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF121212);
  static const Color lightBackground = Color(0xFFFFFFFF);

  // Adding accent colors for navigation elements
  static const Color lightAccent = Color(0xFF2D9F1C); // Slightly darker green
  static const Color darkAccent = Color(0xFF4DCF33);  // Slightly lighter green
  static const Color lightSurface = Color(0xFFF5F5F5); // Very light gray for light surfaces
  static const Color darkSurface = Color(0xFF1E1E1E);  // Slightly lighter than dark background

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
      background: lightBackground,
      onBackground: Colors.black,
    ),
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: primaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    // Add NavigationBar theme for Material 3
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: primaryColor.withOpacity(0.4),
      elevation: 3,
      iconTheme: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const IconThemeData(
        color: primaryColor, 
        size: 26,
        weight: 600,
        );
      }
      return const IconThemeData(
        color: Color(0xFF757575),
        size: 24,
      );
      }),
      labelTextStyle: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const TextStyle(
        color: primaryColor,
        fontSize: 13,
        fontWeight: FontWeight.bold,
        );
      }
      return const TextStyle(
        color: Color(0xFF757575),
        fontSize: 12,
      );
      }),
      surfaceTintColor: Colors.transparent,
      height: 65,
    ),
    useMaterial3: true, // Enable Material 3 for future-proofing
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: Colors.black,
      secondary: darkBackground,
      onSecondary: Colors.white,
      surface: darkSurface,
      onSurface: Colors.white,
      error: Colors.redAccent,
      onError: Colors.black,
      background: darkBackground,
      onBackground: Colors.white,
    ),
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: primaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    // Add NavigationBar theme for Material 3
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: darkSurface,
      indicatorColor: darkAccent.withOpacity(0.3),
      iconTheme: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const IconThemeData(color: darkAccent);
        }
        return const IconThemeData(color: Colors.grey);
      }),
      labelTextStyle: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const TextStyle(
            color: darkAccent,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        }
        return const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        );
      }),
      surfaceTintColor: Colors.transparent,
      height: 60,
    ),
    // Keep the old BottomNavigationBar theme for backward compatibility
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkBackground,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
      ),
      selectedLabelStyle: TextStyle(
        color: primaryColor,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    useMaterial3: true,
  );
}