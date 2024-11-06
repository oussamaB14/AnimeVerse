import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animeverse/core/models/movie.dart';

class MovieService {
  final String baseUrl = "https://consumet-api-rosy.vercel.app/anime";

  Future<List<Movie>> fetchMovies({int page = 1}) async {
    final url = Uri.parse("$baseUrl/gogoanime/movies?page=$page");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> movieJsonList = jsonResponse['results'];

        return movieJsonList
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      } else {
        print("Error: Received unexpected status code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        throw Exception("Failed to load movies: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching movies: $e");
      throw Exception("Failed to fetch movies");
    }
  }
}
