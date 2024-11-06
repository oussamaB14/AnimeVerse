import 'dart:convert';
import 'package:animeverse/core/models/anime.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class AnimeApiService {
  final String baseUrl = "https://consumet-api-rosy.vercel.app/anime";

  Future<List<Anime>> fetchTopAiringAnime({int page = 1}) async {
    final url = Uri.parse("$baseUrl/gogoanime/popular?page=$page");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> animeJsonList = jsonResponse['results'];

        return animeJsonList
            .map((animeJson) => Anime.fromListingJson(animeJson))
            .toList();
      } else {
        // Log the full response body for debugging
        print("Error: Received unexpected status code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        throw Exception(
            "Failed to load top airing anime: ${response.statusCode}");
      }
    } catch (e) {
      // Log the error
      print("Error fetching top airing anime: $e");
      throw Exception("Failed to fetch top airing anime");
    }
  }

  Future<Anime> fetchAnimeDetails(String animeId) async {
    final url = Uri.parse(
        "$baseUrl/gogoanime/info/$animeId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Return the Anime object with detailed information
        return Anime.fromJson(jsonResponse);
      } else {
        // If the server returns an error, throw an exception
        throw Exception('Failed to load anime details');
      }
    } catch (e) {
      // Catch any errors and rethrow as exceptions
      throw Exception('Error fetching anime details: $e');
    }
  }

  Future<List<Anime>> fetchRecentEpisodes({int page = 1}) async {
    final url = Uri.parse("$baseUrl/gogoanime/recent-episodes?page=$page");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> animeJsonList = jsonResponse['results'];

        return animeJsonList.map((animeJson) {
          // Convert the episode data to match our Anime model
          return Anime.fromRecentEpisodeJson(animeJson);
        }).toList();
      } else {
        print("Error: Received unexpected status code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        throw Exception("Failed to load recent episodes: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching recent episodes: $e");
      throw Exception("Failed to fetch recent episodes");
    }
  }

  Future<Anime?> fetchRandomTopAiringAnime() async {
    try {
      final url = Uri.parse("$baseUrl/gogoanime/top-airing");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> results = jsonResponse['results'];
        
        if (results.isNotEmpty) {
          // Generate a random index
          final random = Random();
          final randomIndex = random.nextInt(results.length);
          
          // Convert the random anime to Anime object
          return Anime.fromListingJson(results[randomIndex]);
        }
      }
      return null;
    } catch (e) {
      print("Error fetching random top airing anime: $e");
      return null;
    }
  }
}