import 'package:animeverse/core/models/episode.dart';

class Anime {
  final String id;
  final String title;
  final String url;
  final String image;
  final String? releaseDate; // Nullable
  final String? description; // Nullable
  final List<String> genres;
  final String subOrDub;
  final String? type; // Nullable
  final String status;
  final String? otherName; // Nullable
  final int totalEpisodes;
  final List<Episode> episodes;
  final int? episodeNumber;
  final String? episodeId;

  Anime({
    required this.id,
    required this.title,
    required this.url,
    required this.image,
    this.releaseDate,
    this.description,
    required this.genres,
    required this.subOrDub,
    this.type,
    required this.status,
    this.otherName,
    required this.totalEpisodes,
    required this.episodes,
    this.episodeNumber,
    this.episodeId,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
      releaseDate: json['releaseDate'] as String?,
      description: json['description'] as String?,
      genres: List<String>.from(json['genres']),
      subOrDub: json['subOrDub'] as String,
      type: json['type'] as String?,
      status: json['status'] as String,
      otherName: json['otherName'] as String?,
      totalEpisodes: json['totalEpisodes'] as int,
      episodes: (json['episodes'] as List)
          .map((episode) => Episode.fromJson(episode))
          .toList(),
    );
  }
  // Factory for the anime listing (with only basic fields)
  factory Anime.fromListingJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
      releaseDate: json['releaseDate'] as String?,
      description: null, // Optional, not provided in listing
      genres: [], // Empty genres, not provided in listing
      subOrDub:
          "sub", // Default value for listing (you can adjust this logic as needed)
      type: null, // Not provided in listing
      status: "ongoing", // Default value, adjust as needed
      otherName: null, // Not provided in listing
      totalEpisodes: 0, // Default value, adjust as needed
      episodes: [], // Empty episodes for listing
    );
  }
  // Factory constructor for recent episodes
  factory Anime.fromRecentEpisodeJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
      releaseDate: null, // Not provided in recent episodes
      description: null,
      genres: [], // Not provided in recent episodes
      subOrDub: "sub", // Default value
      type: null,
      status: "ongoing", // Default value
      otherName: null,
      totalEpisodes: 0,
      episodes: [], // We'll handle episodes differently for recent releases
      episodeNumber: json['episodeNumber'] as int, // New field for recent episodes
      episodeId: json['episodeId'] as String, // New field for recent episodes
    );
  }
}
