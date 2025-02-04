import 'package:flutter_test/flutter_test.dart';
import 'package:animeverse/core/models/manga.dart';

void main() {
  group('Manga Model Tests', () {
    test('should get Chapter instance from JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': 'ch1',
        'title': 'Chapter 1',
        'releaseDate': '2024-03-20'
      };

      // Act
      final chapter = Chapter.fromJson(json);

      // Assert
      expect(chapter.id, 'ch1');
      expect(chapter.title, 'Chapter 1');
      expect(chapter.releaseDate, '2024-03-20');
    });

    test('should get Manga instance with chapters from JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': 'm1',
        'title': 'Test Manga',
        'description': {'en': 'Test description'},
        'status': 'ongoing',
        'releaseDate': '2024',
        'image': 'https://test.com/image.jpg',
        'chapters': [
          {
            'id': 'ch1',
            'title': 'Chapter 1',
            'releaseDate': '2024-03-20'
          },
          {
            'id': 'ch2',
            'title': 'Chapter 2',
            'releaseDate': '2024-03-21'
          }
        ]
      };

      // Act
      final manga = Manga.fromJson(json);

      // Assert
      expect(manga.id, 'm1');
      expect(manga.title, 'Test Manga');
      expect(manga.description, 'Test description');
      expect(manga.chapters.length, 2);
      expect(manga.chapters.first.id, 'ch1');
      expect(manga.chapters.last.title, 'Chapter 2');
    });
  });
} 