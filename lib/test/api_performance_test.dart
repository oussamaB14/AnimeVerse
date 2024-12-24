import 'package:flutter_test/flutter_test.dart';
import 'package:animeverse/features/anime/services/animeApiService.dart';

void main() {
  group('API Performance Tests', () {
    final animeApiService = AnimeApiService();

    test('should fetch anime list within acceptable time', () async {
      // Arrange

      const timeout = Duration(seconds: 15);

      // Act & Assert

      await expectLater(
        animeApiService.fetchTopAiringAnime().timeout(timeout),
        completes,
      );
    });

    test('should fetch anime details within acceptable time', () async {
      // Arrange
      const timeout = Duration(seconds: 9);
      const testAnimeId = 'dandadan';
      // Act & Assert
      await expectLater(
        animeApiService.fetchAnimeDetails(testAnimeId).timeout(timeout),
        completes,
      );
    });

    test('search response time should be under threshold', () async {
      // Arrange
      const searchQuery = 'Naruto';
      final stopwatch = Stopwatch()..start();

      // Act
      await animeApiService.searchAnime(searchQuery);
      stopwatch.stop();

      // Assert
      expect(
          stopwatch.elapsedMilliseconds, lessThan(9000), // 2 seconds threshold
          reason: 'Search operation took longer than expected');
    });
  });
}

