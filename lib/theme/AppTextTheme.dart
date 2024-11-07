import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animeverse/theme/AppColors.dart';

class AppTextTheme {
  static TextTheme getTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      // Display styles
      displayLarge: GoogleFonts.urbanist(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),
      displayMedium: GoogleFonts.urbanist(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),
      displaySmall: GoogleFonts.urbanist(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.urbanist(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),
      headlineMedium: GoogleFonts.urbanist(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),
      headlineSmall: GoogleFonts.urbanist(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),

      // Title styles
      titleLarge: GoogleFonts.urbanist(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),
      titleMedium: GoogleFonts.urbanist(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colorScheme.onBackground,
      ),
      titleSmall: GoogleFonts.urbanist(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colorScheme.onBackground,
      ),

      // Body styles
      bodyLarge: GoogleFonts.urbanist(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: colorScheme.onBackground,
      ),
      bodyMedium: GoogleFonts.urbanist(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: colorScheme.onBackground,
      ),
      bodySmall: GoogleFonts.urbanist(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: colorScheme.onBackground,
      ),

      // Label styles
      labelLarge: GoogleFonts.urbanist(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colorScheme.onBackground,
      ),
      labelMedium: GoogleFonts.urbanist(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: colorScheme.onBackground,
      ),
      labelSmall: GoogleFonts.urbanist(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: colorScheme.onBackground,
      ),
    );
  }

  // Helper methods for common text styles
  static TextStyle get sectionTitle {
    return GoogleFonts.urbanist(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get cardTitle {
    return GoogleFonts.urbanist(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get buttonText {
    return GoogleFonts.urbanist(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }
}