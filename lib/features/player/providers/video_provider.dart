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
      await cleanupControllers();
      
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

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _initializePlayer(String videoUrl) async {
    try {
      // Create and initialize video player controller
      _videoPlayerController = VideoPlayerController.network(videoUrl);
      await _videoPlayerController?.initialize();

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

      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing player: $e');
    }
  }

  Future<void> changeVideoQuality(String quality) async {
    final selectedSource = _videoSources.firstWhere(
      (source) => source.quality == quality,
      orElse: () => _videoSources.first,
    );
    
    final currentPosition = _videoPlayerController?.value.position;
    await _initializePlayer(selectedSource.url);
    await _videoPlayerController?.seekTo(currentPosition ?? Duration.zero);
  }

  Future<void> cleanupControllers() async {
     _chewieController?.dispose();
    await _videoPlayerController?.dispose();
    _chewieController = null;
    _videoPlayerController = null;
  }

  @override
  void dispose() {
    cleanupControllers();
    _videoSources = [];
    _selectedQuality = null;
    super.dispose();
  }
}
