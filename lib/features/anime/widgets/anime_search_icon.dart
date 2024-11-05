import 'package:animeverse/presentation/search_anime.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AnimeSearchIcon extends StatefulWidget {
  final Color color;

  const AnimeSearchIcon({
    super.key,
    required this.color,
  });

  @override
  State<AnimeSearchIcon> createState() => _AnimeSearchIconState();
}

class _AnimeSearchIconState extends State<AnimeSearchIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: HugeIcon(
        icon: HugeIcons.strokeRoundedSearch01,
        color: widget.color,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchAnimeScreen(),
          ),
        );
      },
    );
  }
}

