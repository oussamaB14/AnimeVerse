class Chapter {
  final String id;
  final String title;
  final String? releaseDate;

  Chapter({
    required this.id,
    required this.title,
    this.releaseDate,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'] as String,
      title: json['title'] as String,
      releaseDate: json['releaseDate'] as String?,
    );
  }
}

class Manga {
  final String id;
  final String title;
  final String? description;
  final String status;
  final String? releaseDate;
  final String image;
  final List<Chapter> chapters; // New field for chapters

  Manga({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.releaseDate,
    required this.image,
    required this.chapters, // Initialize chapters
  });

  factory Manga.fromJson(Map<String, dynamic> json) {
  var chapterList = json['chapters'] as List<dynamic>? ?? [];
  List<Chapter> chapters = chapterList.map((chapterJson) => Chapter.fromJson(chapterJson)).toList();

  return Manga(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] is Map<String, dynamic> ? json['description']['en'] as String? : null,
    status: json['status'] as String,
    releaseDate: json['releaseDate']?.toString(),
    image: json['image'] as String,
    chapters: chapters,
  );
}

}