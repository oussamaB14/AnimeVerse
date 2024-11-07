import 'package:animeverse/core/models/anime.dart';
import 'package:animeverse/features/anime/provider/AnimeProvider.dart';
import 'package:animeverse/features/bookmarks/providers/bookmark_provider.dart';
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
  late Future<bool> _isBookmarkedFuture;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _isBookmarkedFuture = context.read<BookmarkProvider>().isBookmarked(widget.anime.id);
  }

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
                        '4.5',
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
                    FutureBuilder<bool>(
                      future: _isBookmarkedFuture,
                      builder: (context, snapshot) {
                        final isBookmarked = snapshot.data ?? false;
                        
                        return GestureDetector(
                          onTap: _isProcessing ? null : () async {
                            setState(() {
                              _isProcessing = true;
                            });
                            
                            try {
                              await context.read<BookmarkProvider>().toggleAnimeBookmark(
                                widget.anime,
                                context: context,
                              );
                              setState(() {
                                _isBookmarkedFuture = context.read<BookmarkProvider>().isBookmarked(widget.anime.id);
                              });
                            } finally {
                              setState(() {
                                _isProcessing = false;
                              });
                            }
                          },
                          child: Chip(
                            label: _isProcessing 
                              ? const SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary500),
                                  ),
                                )
                              : Text(
                                  'My List',
                                  style: TextStyle(
                                    color: isBookmarked ? Colors.green : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                            backgroundColor: isBookmarked ? Colors.transparent : Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                              side: const BorderSide(color: Colors.green),
                            ),
                            avatar: _isProcessing 
                              ? null
                              : Icon(
                                  isBookmarked ? Icons.done : Icons.add,
                                  color: isBookmarked ? Colors.green : Colors.white,
                                  size: 16,
                                ),
                            visualDensity: VisualDensity.compact,
                          ),
                        );
                      },
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
