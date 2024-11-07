import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animeverse/core/models/anime.dart';
import 'package:animeverse/core/models/movie.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class BookmarkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Add anime to bookmarks
  Future<void> addAnimeToBookmarks(Anime anime) async {
    if (currentUserId == null) {
      debugPrint('❌ [BookmarkService] Error: No user logged in');
      throw Exception('User must be logged in to add bookmarks');
    }

    try {
      // First check if the user document exists
      final userDoc = await _firestore.collection('users').doc(currentUserId).get();
      
      if (!userDoc.exists) {
        // Create the user document if it doesn't exist
        await _firestore.collection('users').doc(currentUserId).set({
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // Then add the bookmark
      await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('bookmarks')
          .doc(anime.id)
          .set({
        'id': anime.id,
        'title': anime.title,
        'image': anime.image,
        'type': 'anime',
        'addedAt': FieldValue.serverTimestamp(),
      });
      
      debugPrint('✅ [BookmarkService] Successfully added anime to bookmarks:');
      debugPrint('   📌 Title: ${anime.title}');
      debugPrint('   🆔 ID: ${anime.id}');
      debugPrint('   👤 User: $currentUserId');
      
    } catch (error, stackTrace) {
      debugPrint('❌ [BookmarkService] Error adding anime to bookmarks:');
      debugPrint('   📌 Auth Status: ${_auth.currentUser != null ? 'Logged In' : 'Not Logged In'}');
      debugPrint('   🆔 User ID: $currentUserId');
      debugPrint('   ❌ Error: $error');
      debugPrint('   📍 Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Add movie to bookmarks
  Future<void> addMovieToBookmarks(Movie movie) async {
    if (currentUserId == null) return;

    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('bookmarks')
        .doc(movie.id)
        .set({
      'id': movie.id,
      'title': movie.title,
      'image': movie.image,
      'type': 'movie',
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  // Remove from bookmarks
  Future<void> removeFromBookmarks(String id) async {
    if (currentUserId == null) return;

    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('bookmarks')
        .doc(id)
        .delete();
  }

  // Check if item is bookmarked
  Future<bool> isBookmarked(String id) async {
    final user = _auth.currentUser;
    debugPrint('🔍 [BookmarkService] Authentication Check:');
    debugPrint('   👤 Current User: ${user?.uid ?? 'Not logged in'}');
    debugPrint('   📧 Email: ${user?.email ?? 'No email'}');
    debugPrint('   ✅ Is Verified: ${user?.emailVerified ?? false}');

    if (currentUserId == null) {
      debugPrint('❌ [BookmarkService] Error: User not logged in');
      return false;
    }

    try {
      final docPath = 'users/$currentUserId/bookmarks/$id';
      debugPrint('🔍 [BookmarkService] Attempting to access document:');
      debugPrint('   📄 Path: $docPath');
      
      final doc = await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('bookmarks')
          .doc(id)
          .get();

      final exists = doc.exists;
      debugPrint('✅ [BookmarkService] Document ${exists ? 'found' : 'not found'}');
      return exists;
    } catch (error) {
      debugPrint('❌ [BookmarkService] Error checking bookmark:');
      debugPrint('   👤 User ID: $currentUserId');
      debugPrint('   🎯 Item ID: $id');
      debugPrint('   ❌ Error: $error');
      rethrow;
    }
  }

  // Get all bookmarks
  Stream<QuerySnapshot> getBookmarks() {
    if (currentUserId == null) {
      throw Exception('User not logged in');
    }

    return _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('bookmarks')
        .orderBy('addedAt', descending: true)
        .snapshots();
  }

  // Example function to load an image from a local file
  Widget loadImageFromFile(String filePath) {
    // Ensure the file path is valid
    Uri fileUri = Uri.file(filePath); // Create a valid file URI
    
    return Image.file(File(fileUri.toFilePath())); // Use Image.file to load the image
  }
} 