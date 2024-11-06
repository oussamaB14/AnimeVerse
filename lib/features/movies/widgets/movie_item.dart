import 'package:animeverse/core/models/movie.dart';
import 'package:animeverse/features/movies/pages/movies_details.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class MovieItem extends StatefulWidget {
  final Movie movie;

  const MovieItem({super.key, required this.movie});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  bool _isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Movie Poster
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(
                          movie: widget.movie,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(widget.movie.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Rating Badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
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
            // Movie Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: GoogleFonts.urbanist(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkDark3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Release Date
                  Row(
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedCalendar01,
                        size: 20,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.movie.releaseDate ?? "Unknown",
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkDark3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // My List Button
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
    );
  }
}
