import 'package:flutter/material.dart';
import 'package:animeverse/core/models/anime.dart';
import 'package:animeverse/core/models/movie.dart';
import 'package:animeverse/features/bookmarks/services/bookmark_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookmarkProvider with ChangeNotifier {
  final BookmarkService _bookmarkService = BookmarkService();
  
  Future<void> toggleAnimeBookmark(Anime anime, {BuildContext? context}) async {
    try {
      final isCurrentlyBookmarked = await _bookmarkService.isBookmarked(anime.id);
      
      if (isCurrentlyBookmarked) {
        await _bookmarkService.removeFromBookmarks(anime.id);
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Removed ${anime.title} from bookmarks'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        await _bookmarkService.addAnimeToBookmarks(anime);
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added ${anime.title} to bookmarks'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
      notifyListeners();
    } catch (error) {
      debugPrint('❌ [BookmarkProvider] Error toggling bookmark: $error');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error updating bookmarks. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> toggleMovieBookmark(Movie movie, {BuildContext? context}) async {
    try {
      final isCurrentlyBookmarked = await _bookmarkService.isBookmarked(movie.id);
      
      if (isCurrentlyBookmarked) {
        await _bookmarkService.removeFromBookmarks(movie.id);
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Removed ${movie.title} from bookmarks'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        await _bookmarkService.addMovieToBookmarks(movie);
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added ${movie.title} to bookmarks'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
      notifyListeners();
    } catch (error) {
      debugPrint('❌ [BookmarkProvider] Error toggling bookmark: $error');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error updating bookmarks. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<bool> isBookmarked(String id) async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      debugPrint('❌ [BookmarkProvider] User not authenticated');
      return false;
    }
    
    try {
      return await _bookmarkService.isBookmarked(id);
    } catch (error) {
      debugPrint('❌ [BookmarkProvider] Error checking bookmark status: $error');
      return false;
    }
  }

  Stream get bookmarksStream => _bookmarkService.getBookmarks();
} 