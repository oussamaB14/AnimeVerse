import 'package:animeverse/theme/AppColors.dart';
import 'package:animeverse/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hugeicons/hugeicons.dart';

class ThemeswitcherScreen extends StatelessWidget {
  const ThemeswitcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Theme Settings',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkDark2,
          ),
        ),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Column(
            children: [
              const SizedBox(height: 20),
              _buildThemeOption(
                context,
                title: 'Light Theme',
                subtitle: 'Use light theme',
                icon: HugeIcons.strokeRoundedSun03,
                isSelected: themeProvider.themeMode == ThemeMode.light,
                onTap: () => themeProvider.setThemeMode(ThemeMode.light),
              ),
              _buildThemeOption(
                context,
                title: 'Dark Theme',
                subtitle: 'Use dark theme',
                icon: HugeIcons.strokeRoundedMoon02,
                isSelected: themeProvider.themeMode == ThemeMode.dark,
                onTap: () => themeProvider.setThemeMode(ThemeMode.dark),
              ),
              _buildThemeOption(
                context,
                title: 'System Theme',
                subtitle: 'Follow system theme',
                icon: HugeIcons.strokeRoundedSystemUpdate02,
                isSelected: themeProvider.themeMode == ThemeMode.system,
                onTap: () => themeProvider.setThemeMode(ThemeMode.system),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Current theme: ${_getThemeModeName(themeProvider.themeMode)}',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    color: AppColors.greyscale600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary100 : AppColors.greyscale100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: HugeIcon(
          icon :icon,
          color: isSelected ? AppColors.primary500 : AppColors.greyscale600,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.urbanist(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.urbanist(
          fontSize: 14,
          color: AppColors.greyscale600,
        ),
      ),
      trailing: isSelected
          ? const Icon(
              Icons.check_circle,
              color: AppColors.primary500,
            )
          : null,
      onTap: onTap,
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
}
