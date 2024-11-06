import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animeverse/core/models/video_source.dart';
import 'package:animeverse/core/models/video_server.dart';

class VideoService {
  final String baseUrl = "https://consumet-api-rosy.vercel.app/anime/animepahe";

  Future<List<VideoSource>> fetchVideoSources(String episodeId) async {
    try {
      final url = Uri.parse('$baseUrl/watch/$episodeId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        // AnimePahe returns quality options differently
        final Map<String, dynamic> sources = data['sources'];
        List<VideoSource> videoSources = [];
        
        sources.forEach((quality, sourceData) {
          if (sourceData is Map<String, dynamic> && sourceData.containsKey('url')) {
            videoSources.add(
              VideoSource(
                url: sourceData['url'] as String,
                quality: quality,
                isM3U8: false,
              ),
            );
          }
        });
        
        return videoSources;
      } else {
        print("Error response: ${response.body}");
        throw Exception('Failed to load video sources');
      }
    } catch (e) {
      print('Error fetching video sources: $e');
      throw Exception('Failed to fetch video sources');
    }
  }
} 