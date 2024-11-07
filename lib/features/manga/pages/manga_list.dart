import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animeverse/features/manga/provider/MangaProvider.dart';
import 'package:animeverse/features/manga/widgets/manga_list_item.dart';
import 'package:animeverse/features/manga/pages/search_manga.dart';

class MangaListScreen extends StatelessWidget {
  const MangaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mangaProvider = Provider.of<MangaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manga List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchMangaPage()),
              );
            },
          ),
        ],
      ),
      body: mangaProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: mangaProvider.mangaList.length,
              itemBuilder: (context, index) {
                return MangaListItem(manga: mangaProvider.mangaList[index]);
              },
            ),
    );
  }
} 