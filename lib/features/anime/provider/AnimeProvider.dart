import 'package:flutter/material.dart';
import 'package:animeverse/features/anime/services/animeApiService.dart';
import 'package:animeverse/core/models/anime.dart';

class AnimeProvider with ChangeNotifier {
  final AnimeApiService _animeApiService = AnimeApiService();
  List<Anime> _animeList = [];
  List<Anime> _recentEpisodes = [];
  bool _isLoading = false;
  Anime? _animeDetails;
  Anime? _randomAnime;
  bool _isLoadingRandom = false;

  List<Anime> get animeList => _animeList;
  List<Anime> get recentEpisodes => _recentEpisodes;
  bool get isLoading => _isLoading;
  Anime? get animeDetails => _animeDetails;
  Anime? get randomAnime => _randomAnime;
  bool get isLoadingRandom => _isLoadingRandom;

  // Fetching anime list
  Future<void> fetchAnimeList() async {
    _isLoading = true;
    notifyListeners();

    try {
      _animeList = await _animeApiService.fetchTopAiringAnime();
    } catch (e) {
      print("Error fetching anime list: $e");
    }

    _isLoading = false;

    // Instead of calling notifyListeners directly here, delay the notification to avoid build issues
    Future.delayed(Duration(milliseconds: 50), () {
      notifyListeners(); // Notify listeners after the current build cycle
    });
  }

  // Fetch anime details using animeId
  Future<Anime?> fetchAnimeDetailsProvider(String animeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _animeDetails = await _animeApiService.fetchAnimeDetails(animeId);
      return _animeDetails;
    } catch (error) {
      print("Error fetching anime details: $error");
      _animeDetails = null;
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearAnimeDetails() {
    _animeDetails = null;
    notifyListeners();
  }

  Future<void> fetchRecentEpisodes() async {
    try {
      _recentEpisodes = await _animeApiService.fetchRecentEpisodes();
      notifyListeners();
    } catch (e) {
      print("Error fetching recent episodes: $e");
      _recentEpisodes = [];
      notifyListeners();
    }
  }

  Future<void> fetchRandomTopAiringAnime() async {
    _isLoadingRandom = true;
    notifyListeners();

    try {
      _randomAnime = await _animeApiService.fetchRandomTopAiringAnime();
    } catch (e) {
      print("Error fetching random anime: $e");
      _randomAnime = null;
    }

    _isLoadingRandom = false;
    notifyListeners();
  }
}
