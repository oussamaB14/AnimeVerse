import 'dart:convert';
import 'package:animeverse/core/models/anime.dart';
import 'package:flutter/material.dart';
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

  Future<List<Anime>> searchAnime(String query) async {
    if (query.isEmpty) return [];
    
    // Update the URL to match the correct endpoint structure
    final url = Uri.parse("$baseUrl/gogoanime/${Uri.encodeComponent(query)}");
    
    try {
      debugPrint('🔍 [AnimeApiService] Searching for: $query');
      debugPrint('🔗 [AnimeApiService] URL: $url');
      
      final response = await http.get(url);
      debugPrint('📡 [AnimeApiService] Response status: ${response.statusCode}');
      debugPrint('📦 [AnimeApiService] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> results = jsonResponse['results'] ?? [];
        
        debugPrint('✅ [AnimeApiService] Found ${results.length} results');
        
        if (results.isEmpty) {
          debugPrint('⚠️ [AnimeApiService] No results found');
          return [];
        }

        final animeList = results.map((animeJson) {
          try {
            return Anime.fromListingJson(animeJson);
          } catch (e) {
            debugPrint('❌ [AnimeApiService] Error parsing anime: $e');
            debugPrint('📄 [AnimeApiService] Problematic JSON: $animeJson');
            return null;
          }
        }).whereType<Anime>().toList();

        debugPrint('✅ [AnimeApiService] Successfully parsed ${animeList.length} anime');
        return animeList;
      } else {
        debugPrint('❌ [AnimeApiService] Search failed: ${response.statusCode}');
        debugPrint('❌ [AnimeApiService] Error body: ${response.body}');
        throw Exception('Failed to search anime');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ [AnimeApiService] Search error: $e');
      debugPrint('📍 [AnimeApiService] Stack trace: $stackTrace');
      throw Exception('Error searching anime: $e');
    }
  }

  Future<List<Map<String, String>>> fetchGenreList() async {
    final url = Uri.parse("$baseUrl/gogoanime/genre/list");
    
    try {
      debugPrint('🔍 [AnimeApiService] Fetching genre list');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> genres = json.decode(response.body);
        return genres.map((genre) => {
          'id': genre['id'] as String,
          'title': genre['title'] as String,
        }).toList();
      } else {
        throw Exception('Failed to load genre list');
      }
    } catch (e) {
      debugPrint('❌ [AnimeApiService] Error fetching genre list: $e');
      throw Exception('Error fetching genre list');
    }
  }

  Future<List<Anime>> searchAnimeWithFilters({
    required String query,
    List<String>? genres,
    String? sortBy,
    String? year,
  }) async {
    if (query.isEmpty && (genres == null || genres.isEmpty)) return [];
    
    try {
      debugPrint('🔍 [AnimeApiService] Searching with filters:');
      debugPrint('   📝 Query: $query');
      debugPrint('   🏷️ Genres: $genres');
      debugPrint('   📅 Year: $year');
      debugPrint('   🔄 Sort: $sortBy');

      // First get search results
      List<Anime> results = query.isNotEmpty ? await searchAnime(query) : [];
      
      // Apply filters
      if (genres != null && genres.isNotEmpty) {
        results = results.where((anime) {
          return genres.any((genre) => 
            anime.genres.map((g) => g.toLowerCase()).contains(genre.toLowerCase())
          );
        }).toList();
      }

      // Apply year filter
      if (year != null && year.isNotEmpty) {
        results = results.where((anime) => 
          anime.releaseDate?.contains(year) ?? false
        ).toList();
      }

      // Apply sorting
      if (sortBy != null) {
        switch (sortBy) {
          case 'Latest':
            results.sort((a, b) => (b.releaseDate ?? '').compareTo(a.releaseDate ?? ''));
            break;
          case 'Release Date':
            results.sort((a, b) => (a.releaseDate ?? '').compareTo(b.releaseDate ?? ''));
            break;
          // Add more sorting options as needed
        }
      }

      debugPrint('✅ [AnimeApiService] Found ${results.length} filtered results');
      return results;
    } catch (e) {
      debugPrint('❌ [AnimeApiService] Error searching with filters: $e');
      rethrow;
    }
  }
}
