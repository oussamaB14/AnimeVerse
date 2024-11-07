class Manga {
  final String id;
  final String title;
  final String? description;
  final String status;
  final String? releaseDate;
  final String image;

  Manga({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.releaseDate,
    required this.image,
  });

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String,
      releaseDate: json['releaseDate']?.toString(),
      image: json['image'] as String,
    );
  }
}
