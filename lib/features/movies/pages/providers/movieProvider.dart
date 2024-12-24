import 'package:flutter/material.dart';
import 'package:animeverse/core/models/movie.dart';
import 'package:animeverse/features/movies/services/movieService.dart';

class MovieProvider with ChangeNotifier {
  final MovieService _movieService = MovieService();
  List<Movie> _movies = [];
  bool _isLoading = false;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      _movies = await _movieService.fetchMovies();
    } catch (e) {
      print("Error fetching movies: $e");
      _movies = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
