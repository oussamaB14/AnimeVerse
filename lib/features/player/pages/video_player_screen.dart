import 'package:animeverse/features/player/providers/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  void initState() {
    super.initState();
    // Set landscape orientation when entering video player
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // Hide status bar and navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Initialize video player
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    final videoProvider = context.read<VideoProvider>();
    await videoProvider.initializeVideo(widget.episodeId);

    // Rebuild widget once the controller is initialized
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // Reset to portrait orientation when leaving video player
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Show status bar and navigation bar
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoProvider = context.watch<VideoProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: GoogleFonts.urbanist(color: Colors.white),
        ),
      ),
      body: videoProvider.chewieController != null
          ? Column(
              children: [
                Expanded(
                  child: Chewie(
                    controller: videoProvider.chewieController!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (videoProvider.chewieController!.isPlaying) {
                        videoProvider.chewieController!.pause();
                      } else {
                        videoProvider.chewieController!.play();
                      }
                    },
                    child: Text(
                      videoProvider.chewieController!.isPlaying ? 'Pause' : 'Play',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()), // Show loading indicator while initializing
    );
  }
}
