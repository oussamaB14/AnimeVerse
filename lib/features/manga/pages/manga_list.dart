import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animeverse/features/manga/provider/MangaProvider.dart';
import 'package:animeverse/features/manga/widgets/manga_list_item.dart';

class MangaListScreen extends StatelessWidget {
  const MangaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mangaProvider = Provider.of<MangaProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Manga List')),
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