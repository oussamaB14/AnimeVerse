import 'package:flutter/material.dart';
import 'package:animeverse/features/manga/services/mangaApiService.dart';

class MangaChapterReaderPage extends StatefulWidget {
  final String chapterId;

  const MangaChapterReaderPage({super.key, required this.chapterId});

  @override
  _MangaChapterReaderPageState createState() => _MangaChapterReaderPageState();
}

class _MangaChapterReaderPageState extends State<MangaChapterReaderPage> {
  late Future<Map<String, dynamic>> _chapterDetails;

  @override
  void initState() {
    super.initState();
    _chapterDetails = MangaApiService().fetchChapter(widget.chapterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Read Chapter')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _chapterDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No chapter data available'));
          }

          final chapterData = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                // Display chapter image
                Image.network(chapterData['img']),
                const SizedBox(height: 16),
                Text(
                  chapterData['headerForImage'] ?? 'Chapter Header',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Additional content can be added here
              ],
            ),
          );
        },
      ),
    );
  }
} 