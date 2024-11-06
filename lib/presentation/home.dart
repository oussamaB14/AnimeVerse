import 'package:animeverse/features/anime/pages/anime_list.dart';
import 'package:animeverse/features/anime/widgets/anime_search_icon.dart';
import 'package:animeverse/presentation/new_release.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:animeverse/features/anime/provider/AnimeProvider.dart';
import 'package:animeverse/presentation/anime_details.dart';
import 'package:provider/provider.dart';
import 'package:animeverse/features/movies/providers/movieProvider.dart';
import 'package:animeverse/core/models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch anime list when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AnimeProvider>(context, listen: false);
      provider.fetchAnimeList();
      provider.fetchRecentEpisodes();
      provider.fetchRandomTopAiringAnime();
    });
    // Fetch movies when the home page loads
    Future.microtask(() => 
      context.read<MovieProvider>().fetchMovies()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    context.watch<AnimeProvider>().randomAnime?.image ?? '',
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(
                      'AnimeVerse',
                      style: GoogleFonts.urbanist(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.othersWhite,
                      ),
                    ),
                    actions: [
                      const AnimeSearchIcon(
                        color: AppColors.othersWhite,
                      ),
                      IconButton(
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedNotification02,
                          color: AppColors.othersWhite,
                        ),
                        onPressed: () {
                          // Handle notifications action
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Consumer<AnimeProvider>(
                        builder: (context, provider, child) {
                          if (provider.isLoadingRandom) {
                            return const CircularProgressIndicator();
                          }
                          
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.randomAnime?.title ?? 'Loading...',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                provider.randomAnime?.genres.join(' | ') ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      if (provider.randomAnime != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AnimeDetailsScreen(
                                              animeId: provider.randomAnime!.id,
                                            ),
                                          ),
                                        );
                                      }
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
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      // Handle button press
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'My list',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Hits Anime',
                    style: GoogleFonts.urbanist(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkDark1,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AnimeListScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See all',
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 155,
              child: Consumer<AnimeProvider>(
                builder: (context, animeProvider, child) {
                  if (animeProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(left: 8.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: animeProvider.animeList.length,
                    itemBuilder: (context, index) {
                      final anime = animeProvider.animeList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                GestureDetector(
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
                                  child: Container(
                                    width: 120,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        image: NetworkImage(anime.image),
                                        fit: BoxFit.cover,
                                      ),
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
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Episode Releases',
                    style: GoogleFonts.urbanist(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkDark1,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewReleasesScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See all',
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 155,
              child: Consumer<AnimeProvider>(
                builder: (context, animeProvider, child) {
                  if (animeProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(left: 8.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: animeProvider.recentEpisodes.length,
                    itemBuilder: (context, index) {
                      final anime = animeProvider.recentEpisodes[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 120,
                                  height: 150,
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
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Hits Movies',
                    style: GoogleFonts.urbanist(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkDark1,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewReleasesScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See all',
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: Consumer<MovieProvider>(
                builder: (context, movieProvider, child) {
                  if (movieProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movieProvider.movies.length,
                      itemBuilder: (context, index) {
                        final movie = movieProvider.movies[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  movie.image,
                                  height: 150,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  movie.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
