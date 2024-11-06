import 'package:animeverse/features/anime/provider/AnimeProvider.dart';
import 'package:animeverse/features/anime/widgets/anime_list_item.dart';
import 'package:animeverse/features/anime/widgets/anime_list_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the anime list when the screen is first loaded
    final animeProvider = Provider.of<AnimeProvider>(context, listen: false);
    animeProvider.fetchAnimeList();
  }

  @override
  Widget build(BuildContext context) {
    final animeProvider = Provider.of<AnimeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Top Airing Anime')),
      body: animeProvider.isLoading
          ? const AnimeListLoader()
          : ListView.builder(
              itemCount: animeProvider.animeList.length,
              itemBuilder: (context, index) {
                return AnimeListItem(anime: animeProvider.animeList[index]);
              },
            ),
    );
  }
}
