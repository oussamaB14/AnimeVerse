import 'package:animeverse/theme/colors.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animeverse/theme/AppTextTheme.dart';

class AppTheme {
  static ThemeData get lightTheme => _buildTheme(ThemeColors.lightMode);
  static ThemeData get darkTheme => _buildTheme(ThemeColors.darkMode);

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    try {
      final baseTheme = ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: AppTextTheme.getTextTheme(colorScheme),
      );

      return baseTheme.copyWith(
        // AppBar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          iconTheme: IconThemeData(color: colorScheme.onSurface),
          titleTextStyle: AppTextTheme.getTextTheme(colorScheme).titleLarge,
        ),

        // Icon Theme
        iconTheme: IconThemeData(
          color: colorScheme.onSurface,
          size: 24,
        ),
        primaryIconTheme: IconThemeData(
          color: colorScheme.primary,
          size: 24,
        ),

        // Button Themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary500,
            foregroundColor: Colors.white,
            textStyle: AppTextTheme.buttonText,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary500,
            side: const BorderSide(color: AppColors.primary500),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.error),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),

        // Card Theme
        cardTheme: CardTheme(
          color: colorScheme.surface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // Bottom Navigation Bar Theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: colorScheme.surface,
          selectedItemColor: AppColors.primary500,
          unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),

        // Chip Theme
        chipTheme: ChipThemeData(
          backgroundColor: colorScheme.surfaceContainerHighest,
          selectedColor: AppColors.primary500,
          labelStyle: TextStyle(color: colorScheme.onSurface),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    } catch (e) {
      debugPrint('❌ Error building theme: $e');
      // Return a fallback theme if there's an error
      return ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
      );
    }
  }
}
