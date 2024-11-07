import 'dart:convert';
import 'package:animeverse/core/models/manga.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MangaApiService {
  final String baseUrl = "https://consumet-api-rosy.vercel.app/manga/mangadex";

  Future<List<Manga>> fetchMangaList(String query) async {
    final url = Uri.parse("$baseUrl/$query");
    debugPrint('🔗 [MangaApiService] Fetching URL: $url');

    try {
      final response = await http.get(url);
      debugPrint('📡 [MangaApiService] Response status: ${response.statusCode}');
      debugPrint('📦 [MangaApiService] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> mangaJsonList = jsonResponse['results'];

        return mangaJsonList
            .map((mangaJson) => Manga.fromJson(mangaJson))
            .toList();
      } else {
        throw Exception("Failed to load manga list: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('❌ [MangaApiService] Error fetching manga list: $e');
      throw Exception("Error fetching manga list: $e");
    }
  }
}
