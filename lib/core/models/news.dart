class NewsPreview {
  final String intro;
  final String full;

  NewsPreview({
    required this.intro,
    required this.full,
  });

  factory NewsPreview.fromJson(Map<String, dynamic> json) {
    return NewsPreview(
      intro: json['intro'] as String? ?? '',
      full: json['full'] as String? ?? '',
    );
  }
}

class AnimeNews {
  final String title;
  final String id;
  final String uploadedAt;
  final List<String> topics;
  final NewsPreview preview;
  final String thumbnail;
  final String thumbnailHash;
  final String url;

  AnimeNews({
    required this.title,
    required this.id,
    required this.uploadedAt,
    required this.topics,
    required this.preview,
    required this.thumbnail,
    required this.thumbnailHash,
    required this.url,
  });

  factory AnimeNews.fromJson(Map<String, dynamic> json) {
    return AnimeNews(
      title: json['title'] as String,
      id: json['id'] as String,
      uploadedAt: json['uploadedAt'] as String,
      topics: (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
      preview: NewsPreview.fromJson(json['preview'] as Map<String, dynamic>),
      thumbnail: json['thumbnail'] as String,
      thumbnailHash: json['thumbnailHash'] as String,
      url: json['url'] as String,
    );
  }
} 