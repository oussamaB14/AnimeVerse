import 'package:flutter/material.dart';
import 'package:animeverse/core/models/anime.dart';
import 'package:animeverse/features/anime/services/animeApiService.dart';

class SearchProvider with ChangeNotifier {
  final AnimeApiService _animeApiService = AnimeApiService();
  List<Anime> _searchResults = [];
  bool _isLoading = false;
  String _lastQuery = '';
  String? _error;
  
  List<Anime> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get lastQuery => _lastQuery;
  String? get error => _error;

  Future<void> searchAnime(String query) async {
    if (query == _lastQuery) return;
    _lastQuery = query;
    _error = null;
    
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      debugPrint('🔍 [SearchProvider] Starting search for: $query');
      _searchResults = await _animeApiService.searchAnime(query);
      debugPrint('✅ [SearchProvider] Search completed with ${_searchResults.length} results');
      
    } catch (e) {
      debugPrint('❌ [SearchProvider] Search error: $e');
      _searchResults = [];
      _error = 'Failed to search anime. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults = [];
    _lastQuery = '';
    _error = null;
    notifyListeners();
  }
} 