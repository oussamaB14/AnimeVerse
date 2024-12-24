import 'package:animeverse/core/models/movie.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hugeicons/hugeicons.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final bookmarked = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Movie Poster with Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.movie.image),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Stack(
                    children: [
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      // Content
                      Column(
                        children: [
                          AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Bookmark Row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.movie.title,
                          style: GoogleFonts.urbanist(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkDark3,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          bookmarked.value = !bookmarked.value;
                        },
                        icon: ValueListenableBuilder<bool>(
                          valueListenable: bookmarked,
                          builder: (context, value, child) {
                            return HeroIcon(
                              HeroIcons.bookmark,
                              color: AppColors.primary500,
                              style: value ? HeroIconStyle.solid : HeroIconStyle.outline,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Info Row
                  Row(
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedStar,
                        color: AppColors.primary500,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "4.5",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedCalendar01,
                        color: AppColors.primary500,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.movie.releaseDate ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkDark3,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Handle play action
                          },
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedPlay,
                            color: AppColors.othersWhite,
                          ),
                          label: const Text(
                            'Play',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary500,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Handle download action
                          },
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedDownload02,
                            color: AppColors.primary500,
                          ),
                          label: const Text(
                            'Download',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary500,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(
                              color: AppColors.primary500,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkDark3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This is a sample description for the movie. You can add the actual description here when available in the Movie model.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // More Like This Section
                  // const Text(
                  //   'More Like This',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: AppColors.darkDark3,
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  // SizedBox(
                  //   height: 200,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: 5,
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding: const EdgeInsets.only(right: 12),
                  //         child: ClipRRect(
                  //           borderRadius: BorderRadius.circular(8),
                  //           child: Image.network(
                  //             widget.movie.image,
                  //             width: 120,
                  //             height: 180,
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
