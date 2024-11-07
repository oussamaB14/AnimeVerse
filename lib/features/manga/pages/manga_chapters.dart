import 'package:animeverse/features/manga/pages/manga_chapter_reader.dart';
import 'package:flutter/material.dart';
import 'package:animeverse/features/manga/services/mangaApiService.dart';

class MangaChaptersPage extends StatelessWidget {
  final String mangaId;

  const MangaChaptersPage({super.key, required this.mangaId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manga Chapters')),
      body: FutureBuilder<List<String>>(
        future: MangaApiService().fetchMangaChapters(mangaId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chapters available'));
          }

          final chapters = snapshot.data!;
          return ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (context, index) {
              final chapterId = chapters[index];
              return ListTile(
                title: Text('Chapter ${index + 1}'),
                onTap: () {
                  // Navigate to chapter reading
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MangaChapterReaderPage(chapterId: chapterId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
} 