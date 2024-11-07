import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animeverse/core/models/manga.dart';
import 'package:animeverse/features/manga/services/mangaApiService.dart';

class MangaProvider with ChangeNotifier {
  final MangaApiService _mangaApiService = MangaApiService();
  List<Manga> _mangaList = [];
  bool _isLoading = false;

  List<Manga> get mangaList => _mangaList;
  bool get isLoading => _isLoading;

  final List<String> queries = ["demon", "life", "sport"];

  Future<void> fetchMangaList() async {
    _isLoading = true;
    notifyListeners();

    try {
      final random = Random();
      final query = queries[random.nextInt(queries.length)];
      debugPrint('🔍 [MangaProvider] Fetching manga list with query: $query');

      _mangaList = await _mangaApiService.fetchMangaList(query);
      debugPrint('✅ [MangaProvider] Successfully fetched ${_mangaList.length} manga items');
    } catch (e) {
      debugPrint('❌ [MangaProvider] Error fetching manga list: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
