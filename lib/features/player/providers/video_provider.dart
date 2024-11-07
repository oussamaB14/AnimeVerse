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
  bool _disposed = false;

  List<VideoSource> get videoSources => _videoSources;
  VideoPlayerController? get videoPlayerController => _videoPlayerController;
  ChewieController? get chewieController => _chewieController;
  bool get isLoading => _isLoading;
  String? get selectedQuality => _selectedQuality;

  Future<void> initializeVideo(String episodeId) async {
    if (_disposed) return;
    
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
      debugPrint('Error initializing video: $e');
    }

    if (!_disposed) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _initializePlayer(String videoUrl) async {
    if (_disposed) return;

    // Dispose existing controllers
    await _disposeControllers();

    try {
      // Create and initialize video player controller
      _videoPlayerController = VideoPlayerController.network(videoUrl);
      await _videoPlayerController?.initialize();

      if (_disposed) return;

      // Create Chewie controller
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        placeholder: const Center(child: CircularProgressIndicator()),
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
      );

      if (!_disposed) {
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error initializing player: $e');
    }
  }

  Future<void> changeVideoQuality(String quality) async {
    if (_disposed) return;
    
    final selectedSource = _videoSources.firstWhere(
      (source) => source.quality == quality,
      orElse: () => _videoSources.first,
    );
    
    final currentPosition = _videoPlayerController?.value.position;
    await _initializePlayer(selectedSource.url);
    await _videoPlayerController?.seekTo(currentPosition ?? Duration.zero);
  }

  Future<void> _disposeControllers() async {
    _chewieController?.dispose();
    await _videoPlayerController?.dispose();
    _chewieController = null;
    _videoPlayerController = null;
  }

  @override
  void dispose() {
    _disposed = true;
    _disposeControllers();
    super.dispose();
  }
}
