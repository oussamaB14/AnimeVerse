class Movie {
  final String id;
  final String title;
  final String url;
  final String image;
  final String? releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.url,
    required this.image,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
      releaseDate: json['releaseDate'] as String?,
    );
  }
}
