// theme_colors.dart

import 'package:flutter/material.dart';
import 'package:animeverse/theme/AppColors.dart';

class ThemeColors {
  static const ColorScheme lightMode = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary500,
    onPrimary: AppColors.othersWhite,
    primaryContainer: AppColors.primary300,
    onPrimaryContainer: AppColors.primary100,
    secondary: AppColors.secondary500,
    onSecondary: AppColors.othersWhite,
    secondaryContainer: AppColors.secondary300,
    onSecondaryContainer: AppColors.secondary100,
    surface: AppColors.othersWhite,
    onSurfaceVariant: AppColors.darkDark1,
    onSurface: AppColors.darkDark2,
    error: AppColors.alertsStatusError,
    onError: AppColors.othersWhite,
    errorContainer: AppColors.backgroundRed,
    onErrorContainer: AppColors.alertsStatusError,
    outline: AppColors.greyscale300,
    shadow: AppColors.greyscale900,
  );

  static const ColorScheme darkMode = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary500,
    onPrimary: AppColors.othersWhite,
    primaryContainer: AppColors.primary300,
    onPrimaryContainer: AppColors.primary100,
    secondary: AppColors.secondary500,
    onSecondary: AppColors.othersWhite,
    secondaryContainer: AppColors.secondary300,
    onSecondaryContainer: AppColors.secondary100,
    surface: AppColors.darkDark2,
    onSurface: AppColors.othersWhite,
    surfaceContainerHighest: AppColors.darkDark3,
    error: AppColors.alertsStatusError,
    onError: AppColors.othersWhite,
    errorContainer: AppColors.backgroundRed,
    onErrorContainer: AppColors.alertsStatusError,
    outline: AppColors.greyscale700,
    shadow: Colors.black,
  );
}
