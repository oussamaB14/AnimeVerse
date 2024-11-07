import 'package:animeverse/features/player/providers/video_provider.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String episodeId;
  final String title;

  const VideoPlayerScreen({
    super.key,
    required this.episodeId,
    required this.title,
  });

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VideoProvider>().initializeVideo(widget.episodeId);
    });
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
    context.read<VideoProvider>().dispose();
    super.dispose();
  }

  ChewieController _createChewieController(VideoProvider provider) {
    return ChewieController(
      videoPlayerController: provider.videoPlayerController!,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      showControls: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      customControls: const CupertinoControls(
        backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
        iconColor: Colors.white,
      ),
      // Customize the player theme
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.primary500,
        handleColor: AppColors.primary500,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.grey[300]!,
      ),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
      // Add additional options
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      placeholder: Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: GoogleFonts.urbanist(color: Colors.white),
        ),
        actions: [
          Consumer<VideoProvider>(
            builder: (context, provider, child) {
              if (provider.videoSources.isEmpty) return const SizedBox();
              
              return Row(
                children: [
                  // Quality selector
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onSelected: (quality) {
                      provider.changeQuality(quality);
                    },
                    itemBuilder: (BuildContext context) {
                      return provider.videoSources.map((source) {
                        return PopupMenuItem<String>(
                          value: source.quality,
                          child: Text(
                            source.quality,
                            style: TextStyle(
                              color: source.quality == provider.selectedQuality
                                  ? AppColors.primary500
                                  : Colors.black,
                              fontWeight: source.quality == provider.selectedQuality
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<VideoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary500,
              ),
            );
          }

          if (provider.chewieController == null) {
            return const Center(
              child: Text(
                'Failed to load video',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return SafeArea(
            child: Center(
              child: Chewie(
                controller: _createChewieController(provider),
              ),
            ),
          );
        },
      ),
    );
  }
} 