import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animeverse/core/models/video_source.dart';

class VideoService {
  final String baseUrl = "https://consumet-api-rosy.vercel.app/anime/gogoanime";

  Future<List<VideoSource>> fetchVideoSources(String episodeId) async {
    try {
      final url = Uri.parse('$baseUrl/watch/$episodeId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> sources = data['sources'];

        List<VideoSource> videoSources = [];
        for (var source in sources) {
          if (source is Map<String, dynamic> && source.containsKey('url')) {
            videoSources.add(
              VideoSource(
                url: source['url'] as String,
                quality: source['quality'] as String, // Assuming quality is provided
                isM3U8: false,
              ),
            );
          }
        }
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