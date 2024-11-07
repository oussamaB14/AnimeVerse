import 'package:animeverse/features/player/providers/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';
import 'package:provider/provider.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String episodeId;
  final String title;

  const VideoPlayerScreen({
    Key? key,
    required this.episodeId,
    required this.title,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoProvider _videoProvider;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoProvider = context.read<VideoProvider>();
    
    // Set landscape orientation when entering video player
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Initialize video player
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      await _videoProvider.initializeVideo(widget.episodeId);
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint("Error initializing video: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading video: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    // Reset to portrait orientation when leaving video player
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    _videoProvider.cleanupControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _videoProvider.cleanupControllers();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              await _videoProvider.cleanupControllers();
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: Consumer<VideoProvider>(
          builder: (context, videoProvider, child) {
            if (videoProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!_isInitialized || videoProvider.chewieController == null) {
              return const Center(child: Text('Loading video...'));
            }

            return Column(
              children: [
                Expanded(
                  child: Chewie(
                    controller: videoProvider.chewieController!,
                  ),
                ),
                // Quality selector
                if (videoProvider.videoSources.length > 1)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: videoProvider.selectedQuality,
                      dropdownColor: Colors.black87,
                      style: const TextStyle(color: Colors.white),
                      items: videoProvider.videoSources.map((source) {
                        return DropdownMenuItem<String>(
                          value: source.quality,
                          child: Text(source.quality),
                        );
                      }).toList(),
                      onChanged: (newQuality) {
                        if (newQuality != null) {
                          videoProvider.changeVideoQuality(newQuality);
                        }
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
