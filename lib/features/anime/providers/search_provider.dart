import 'package:flutter/material.dart';
import 'package:animeverse/core/models/anime.dart';
import 'package:animeverse/features/anime/services/animeApiService.dart';

class SearchProvider with ChangeNotifier {
  final AnimeApiService _animeApiService = AnimeApiService();
  List<Anime> _searchResults = [];
  bool _isLoading = false;
  String _lastQuery = '';
  String? _error;
  
  // Filter state
  List<String> _selectedGenres = [];
  String? _selectedYear;
  String? _selectedSort;
  List<Map<String, String>>? _availableGenres;
  
  List<Anime> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get lastQuery => _lastQuery;
  String? get error => _error;
  List<String> get selectedGenres => _selectedGenres;
  String? get selectedYear => _selectedYear;
  String? get selectedSort => _selectedSort;
  List<Map<String, String>>? get availableGenres => _availableGenres;

  Future<void> loadGenres() async {
    try {
      _availableGenres = await _animeApiService.fetchGenreList();
      notifyListeners();
    } catch (e) {
      debugPrint('❌ [SearchProvider] Error loading genres: $e');
    }
  }

  void updateFilters({
    List<String>? genres,
    String? year,
    String? sort,
  }) {
    if (genres != null) _selectedGenres = genres;
    if (year != null) _selectedYear = year;
    if (sort != null) _selectedSort = sort;
    
    // Reapply search with new filters
    if (_lastQuery.isNotEmpty) {
      searchAnime(_lastQuery);
    }
  }

  void clearFilters() {
    _selectedGenres = [];
    _selectedYear = null;
    _selectedSort = null;
    notifyListeners();
    
    // Reapply search without filters
    if (_lastQuery.isNotEmpty) {
      searchAnime(_lastQuery);
    }
  }

  Future<void> searchAnime(String query) async {
    if (query == _lastQuery && 
        _searchResults.isNotEmpty && 
        _selectedGenres.isEmpty && 
        _selectedYear == null && 
        _selectedSort == null) return;
        
    _lastQuery = query;
    _error = null;
    
    if (query.isEmpty && _selectedGenres.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      _searchResults = await _animeApiService.searchAnimeWithFilters(
        query: query,
        genres: _selectedGenres,
        year: _selectedYear,
        sortBy: _selectedSort,
      );
      
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