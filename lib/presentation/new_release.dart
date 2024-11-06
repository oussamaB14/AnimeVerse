import 'package:animeverse/app/shared/app_bar.dart';
import 'package:animeverse/features/anime/provider/AnimeProvider.dart';
import 'package:animeverse/presentation/anime_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewReleasesScreen extends StatefulWidget {
  const NewReleasesScreen({super.key});

  @override
  State<NewReleasesScreen> createState() => _NewReleaseScreenState();
}

class _NewReleaseScreenState extends State<NewReleasesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch recent episodes when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AnimeProvider>(context, listen: false).fetchRecentEpisodes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'New Episode Releases'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<AnimeProvider>(
          builder: (context, animeProvider, child) {
            if (animeProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: animeProvider.recentEpisodes.length,
              itemBuilder: (context, index) {
                final anime = animeProvider.recentEpisodes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimeDetailsScreen(
                          animeId: anime.id,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(anime.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
                                child: Text(
                                  'EP ${anime.episodeNumber}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        anime.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
