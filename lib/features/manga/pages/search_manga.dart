import 'package:flutter/material.dart';
import 'package:animeverse/features/manga/services/mangaApiService.dart';
import 'package:animeverse/core/models/manga.dart';
import 'package:animeverse/features/manga/widgets/manga_list_item.dart';

class SearchMangaPage extends StatefulWidget {
  const SearchMangaPage({super.key});

  @override
  _SearchMangaPageState createState() => _SearchMangaPageState();
}

class _SearchMangaPageState extends State<SearchMangaPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Manga> _searchResults = [];
  bool _isLoading = false;

  void _searchManga() async {
    setState(() {
      _isLoading = true;
      _searchResults.clear();
    });

    try {
      final results = await MangaApiService().fetchMangaList(_searchController.text);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      // Handle error (e.g., show a snackbar)
      print('Error searching manga: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Manga'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _searchManga,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search for manga',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _searchManga(),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return MangaListItem(manga: _searchResults[index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
} 