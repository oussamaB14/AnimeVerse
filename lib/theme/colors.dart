// theme_colors.dart

import 'package:flutter/material.dart';

class ThemeColors {
  static const ColorScheme lightMode = ColorScheme(
    brightness: Brightness.light, // Added brightness parameter
    onPrimary: Color(0xFF2196F3),
    onSecondary: Color(0xFF2196F3),
    primary: Color(0xFF2196F3), // primary variant color for light mode
    secondary: Color(0xFF9C27B0), // secondary variant color for light mode
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF2196F3), // background color for light mode
    error: Color(0xFFB00020),
    onError: Color(0xFF2196F3), // error color for light mode
  );

  static const ColorScheme darkMode = ColorScheme(
    brightness: Brightness.dark, // Added brightness parameter

    primary: Color(0xFF673AB7), // primary variant color for dark mode
    onPrimary: Color(0xFF2196F3),
    secondary: Color(0xFF03A9F4), // secondary variant color for dark mode
    onSecondary: Color(0xFF2196F3),
    surface: Color(0xFF212121), // background color for dark mode
    onSurface: Color(0xFF2196F3),
    error: Color(0xFFCF6679), // error color for dark mode
    onError: Color(0xFF2196F3),
  );
}
