import 'package:flutter/material.dart';
import 'package:animeverse/core/models/video_source.dart';
import 'package:animeverse/features/player/services/video_service.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoProvider with ChangeNotifier {
  final VideoService _videoService = VideoService();
  List<VideoSource> _videoSources = [];
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = false;
  String? _selectedQuality;
  String? _currentEpisodeId;

  List<VideoSource> get videoSources => _videoSources;
  VideoPlayerController? get videoPlayerController => _videoPlayerController;
  ChewieController? get chewieController => _chewieController;
  bool get isLoading => _isLoading;
  String? get selectedQuality => _selectedQuality;

  Future<void> initializeVideo(String episodeId) async {
    _isLoading = true;
    _currentEpisodeId = episodeId;
    notifyListeners();

    try {
      // Fetch video sources
      _videoSources = await _videoService.fetchVideoSources(episodeId);

      if (_videoSources.isNotEmpty) {
        // Select the highest quality by default
        _selectedQuality = _videoSources.first.quality;
        await _initializePlayer(_videoSources.first.url);
      }
    } catch (e) {
      print('Error initializing video: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> changeQuality(String quality) async {
    final newSource = _videoSources.firstWhere((source) => source.quality == quality);
    _selectedQuality = quality;

    // Store current position
    final position = await _videoPlayerController?.position;

    // Initialize new player with selected quality
    await _initializePlayer(newSource.url);

    // Seek to previous position
    if (position != null) {
      await _videoPlayerController?.seekTo(position);
    }

    notifyListeners();
  }

  Future<void> _initializePlayer(String videoUrl) async {
    // Dispose existing controllers
    dispose();

    try {
      // Create and initialize video player controller
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await _videoPlayerController?.initialize();

      // Create chewie controller
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              'Error: $errorMessage',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        placeholder: Container(
          color: Colors.black,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    } catch (e) {
      print('Error initializing player: $e');
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    _videoPlayerController = null;
    _chewieController = null;
  }
}
