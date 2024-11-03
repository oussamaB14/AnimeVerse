import 'package:animeverse/features/anime/widgets/anime_search_icon.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.urbanist(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.darkDark2,
        ),
      ),
      actions: const [
        AnimeSearchIcon(color: AppColors.darkDark3),
      ],
    );
  }

  // Implement preferredSize for PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
