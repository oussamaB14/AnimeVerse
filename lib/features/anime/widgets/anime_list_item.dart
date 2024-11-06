import 'package:animeverse/core/models/anime.dart';
import 'package:animeverse/features/anime/provider/AnimeProvider.dart';
import 'package:animeverse/presentation/anime_details.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class AnimeListItem extends StatefulWidget {
  final Anime anime;

  const AnimeListItem({super.key, required this.anime});

  @override
  State<AnimeListItem> createState() => _AnimeListItemState();
}

class _AnimeListItemState extends State<AnimeListItem> {
  bool _isAdded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final animeId = widget.anime.id;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetailsScreen(animeId: animeId),
          ),
        );
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(widget.anime.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '4.5', // You can replace this with an actual rating if available
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.anime.title,
                      style: GoogleFonts.urbanist(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkDark3,
                      ),
                    ),
                    // const SizedBox(height: 4),
                    // Text(
                    //   widget.anime.genres.join(' | '),
                    //   style: Theme.of(context).textTheme.bodySmall,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    const SizedBox(height: 8),
                    Row(children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedCalendar01,
                        size: 20,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.anime.releaseDate ?? "Unknown",
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkDark3,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isAdded = !_isAdded;
                        });
                      },
                      child: Chip(
                        label: Text(
                          'My List',
                          style: TextStyle(
                            color: _isAdded ? Colors.green : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        backgroundColor:
                            _isAdded ? Colors.transparent : Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          side: const BorderSide(color: Colors.green),
                        ),
                        avatar: Icon(
                          _isAdded ? Icons.done : Icons.add,
                          color: _isAdded ? Colors.green : Colors.white,
                          size: 16,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
