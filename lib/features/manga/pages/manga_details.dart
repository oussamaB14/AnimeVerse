import 'package:animeverse/features/manga/pages/manga_chapters.dart';
import 'package:flutter/material.dart';
import 'package:animeverse/core/models/manga.dart';
import 'package:animeverse/features/manga/services/mangaApiService.dart';

class MangaDetailsPage extends StatefulWidget {
  final String mangaId;

  const MangaDetailsPage({super.key, required this.mangaId});

  @override
  _MangaDetailsPageState createState() => _MangaDetailsPageState();
}

class _MangaDetailsPageState extends State<MangaDetailsPage> {
  late Future<Manga> _mangaDetails;

  @override
  void initState() {
    super.initState();
    _mangaDetails = MangaApiService().fetchMangaDetails(widget.mangaId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manga Details')),
      body: FutureBuilder<Manga>(
        future: _mangaDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final manga = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(manga.image),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        manga.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(manga.description ?? 'No description available'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to reading chapters
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MangaChaptersPage(mangaId: manga.id),
                            ),
                          );
                        },
                        child: const Text('Read Chapters'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 