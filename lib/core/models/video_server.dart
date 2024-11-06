class VideoServer {
  final String name;
  final String url;

  VideoServer({
    required this.name,
    required this.url,
  });

  factory VideoServer.fromJson(Map<String, dynamic> json) {
    return VideoServer(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
} 