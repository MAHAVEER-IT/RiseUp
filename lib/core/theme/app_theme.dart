import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF88A992), // Sage Green
      background: const Color(0xFFF9F9F7), // Pearl/Oatmeal
      surface: const Color(0xFFFFFFFF),
      primary: const Color(0xFF88A992),
      secondary: const Color(0xFFE8AFA1), // Sunrise Dawn
      onBackground: const Color(0xFF2D3130), // Deep Charcoal
    ),
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF9F9F7),
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF2D3130)),
      titleTextStyle: TextStyle(
        color: Color(0xFF2D3130),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF88A992),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
  );
}
