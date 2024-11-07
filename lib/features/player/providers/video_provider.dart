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

  List<VideoSource> get videoSources => _videoSources;
  VideoPlayerController? get videoPlayerController => _videoPlayerController;
  ChewieController? get chewieController => _chewieController;
  bool get isLoading => _isLoading;
  String? get selectedQuality => _selectedQuality;

  Future<void> initializeVideo(String episodeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch video sources
      _videoSources = await _videoService.fetchVideoSources(episodeId);

      if (_videoSources.isNotEmpty) {
        // Select the highest quality by default
        _selectedQuality = _videoSources.first.quality;
        await _initializePlayer(_videoSources.first.url);
      } else {
        throw Exception("No video sources available");
      }
    } catch (e) {
      print('Error initializing video: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _initializePlayer(String videoUrl) async {
    // Dispose existing controllers
    dispose();

    try {
      // Create and initialize video player controller
      _videoPlayerController = VideoPlayerController.network(videoUrl);
      await _videoPlayerController?.initialize();

      // Create Chewie controller
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        // Customize the controls as needed
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
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
    super.dispose();
  }
}
