import 'package:animeverse/features/player/providers/video_provider.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VideoProvider>().initializeVideo(widget.episodeId);
    });
  }

  @override
  void dispose() {
    context.read<VideoProvider>().dispose();
    super.dispose();
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
              
              return PopupMenuButton<String>(
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
              );
            },
          ),
        ],
      ),
      body: Consumer<VideoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.chewieController == null) {
            return const Center(
              child: Text(
                'Failed to load video',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return Center(
            child: Chewie(controller: provider.chewieController!),
          );
        },
      ),
    );
  }
} 