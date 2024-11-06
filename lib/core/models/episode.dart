class Episode {
  final String id;
  final int number;
  final String url;

  Episode({
    required this.id,
    required this.number,
    required this.url,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] as String,
      number: json['number'] as int,
      url: json['url'] as String,
    );
  }
}
