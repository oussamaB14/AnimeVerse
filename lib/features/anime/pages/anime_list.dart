import 'package:animeverse/app/shared/app_bar.dart';
import 'package:animeverse/features/anime/widgets/anime_list_item.dart';
import 'package:flutter/material.dart';


class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: const MyAppBar(title: 'Top Hits Anime'),

      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of items
        itemBuilder: (context, index) {
          return const AnimeListItem();
        },
      ),
    );
  }
}
