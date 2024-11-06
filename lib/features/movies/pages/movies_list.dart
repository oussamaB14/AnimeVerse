import 'package:animeverse/features/anime/widgets/anime_list_loader.dart';
import 'package:animeverse/features/movies/providers/movieProvider.dart';
import 'package:animeverse/features/movies/widgets/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch movies when the screen loads
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.isLoading) {
            return const AnimeListLoader(); // Reusing the anime list loader
          }

          if (movieProvider.movies.isEmpty) {
            return const Center(
              child: Text('No movies available'),
            );
          }

          return ListView.builder(
            itemCount: movieProvider.movies.length,
            itemBuilder: (context, index) {
              final movie = movieProvider.movies[index];
              return MovieItem(movie: movie);
            },
          );
        },
      ),
    );
  }
}
