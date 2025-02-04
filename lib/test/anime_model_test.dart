import 'package:flutter_test/flutter_test.dart';
import 'package:animeverse/core/models/anime.dart';
import 'package:animeverse/core/models/episode.dart';

void main() {
  group('Anime Model Tests', () {
    test('should get Anime instance from JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': '1',
        'title': 'Test Anime',
        'url': 'https://test.com/anime',
        'image': 'https://test.com/image.jpg',
        'releaseDate': '2024',
        'description': 'Test description',
        'genres': ['Action', 'Adventure'],
        'subOrDub': 'sub',
        'type': 'TV',
        'status': 'Ongoing',
        'otherName': 'Test Name',
        'totalEpisodes': 12,
        'episodes': [
          {
            'id': 'ep1',
            'number': 1,
            'url': 'https://test.com/ep1'
          }
        ]
      };

      // Act
      final anime = Anime.fromJson(json);

      // Assert
      expect(anime.id, '1');
      expect(anime.title, 'Test Anime');
      expect(anime.genres.length, 2);
      expect(anime.episodes.length, 1);
      expect(anime.episodes.first.id, 'ep1');
    });

    test('should get Anime instance from listing JSON with minimal data', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': '1',
        'title': 'Test Anime',
        'url': 'https://test.com/anime',
        'image': 'https://test.com/image.jpg',
      };

      // Act
      final anime = Anime.fromListingJson(json);

      // Assert
      expect(anime.id, '1');
      expect(anime.title, 'Test Anime');
      expect(anime.genres, isEmpty);
      expect(anime.episodes, isEmpty);
      expect(anime.type, isNull);
    });
  });
} 