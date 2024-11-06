class VideoSource {
  final String url;
  final String quality;
  final bool isM3U8;

  VideoSource({
    required this.url,
    required this.quality,
    this.isM3U8 = false,
  });

  factory VideoSource.fromJson(Map<String, dynamic> json) {
    return VideoSource(
      url: json['url'] as String,
      quality: json['quality'] as String,
      isM3U8: json['isM3U8'] as bool? ?? false,
    );
  }
} 