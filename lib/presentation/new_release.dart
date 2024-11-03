import 'package:animeverse/features/anime/widgets/anime_search_icon.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class NewReleasesScreen extends StatefulWidget {
  const NewReleasesScreen({super.key});

  @override
  State<NewReleasesScreen> createState() => _NewReleaseScreenState();
}

class _NewReleaseScreenState extends State<NewReleasesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Eposode Releases',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkDark2,
          ),
        ),
        actions: const [
          AnimeSearchIcon(color :AppColors.darkDark3),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust the number of columns as needed
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 0.8, // Adjust the aspect ratio as needed
          ),
          itemCount: 10, // Adjust the number of items as needed
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  width: 180,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://storage.googleapis.com/fc-freepik-pro-rev1-eu-static/ai-styles-landings/anime/characters-and-scenes.jpg?h=1280',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
            );
          },
        ),
      ),
    );
  }
}
