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
      debugPrint(
          '📡 [MangaApiService] Response status: ${response.statusCode}');
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

  Future<Manga> fetchMangaDetails(String id) async {
    final url = Uri.parse("$baseUrl/info/$id");
    debugPrint('🔗 [MangaApiService] Fetching manga details URL: $url');

    try {
      final response = await http.get(url);
      debugPrint(
          '📡 [MangaApiService] Response status: ${response.statusCode}');
      debugPrint('📦 [MangaApiService] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Manga.fromJson(jsonResponse);
      } else {
        throw Exception("Failed to load manga details: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('❌ [MangaApiService] Error fetching manga details: $e');
      throw Exception("Error fetching manga details: $e");
    }
  }

  Future<List<String>> fetchMangaChapters(String mangaId) async {
    final url = Uri.parse("$baseUrl/info/$mangaId");
    debugPrint('🔗 [MangaApiService] Fetching chapters URL: $url');

    try {
      final response = await http.get(url);
      debugPrint(
          '📡 [MangaApiService] Response status: ${response.statusCode}');
      debugPrint('📦 [MangaApiService] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> chaptersJsonList = jsonResponse['chapters'];

        return chaptersJsonList
            .map((chapter) => chapter['id'] as String)
            .toList();
      } else {
        throw Exception("Failed to load chapters: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('❌ [MangaApiService] Error fetching chapters: $e');
      throw Exception("Error fetching chapters: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchChapter(String chapterId) async {
    final url = Uri.parse(
        "https://consumet-api-rosy.vercel.app/manga/mangadex/read/$chapterId");
    debugPrint('🔗 [MangaApiService] Fetching chapter URL: $url');

    try {
        final response = await http.get(url);
        debugPrint('📡 [MangaApiService] Response status: ${response.statusCode}');
        debugPrint('📦 [MangaApiService] Response body: ${response.body}');

        if (response.statusCode == 200) {
            return List<Map<String, dynamic>>.from(json.decode(response.body));
        } else {
            throw Exception("Failed to load chapter: ${response.statusCode}");
        }
    } catch (e) {
        debugPrint('❌ [MangaApiService] Error fetching chapter: $e');
        throw Exception("Error fetching chapter: $e");
    }
  }
}
