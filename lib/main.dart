import 'package:animeverse/app/app.dart';
import 'package:animeverse/app/firebase_options.dart';
import 'package:animeverse/features/anime/provider/AnimeProvider.dart';
import 'package:animeverse/features/auth/provider/AuthProvider.dart';
import 'package:animeverse/features/movies/providers/movieProvider.dart';
import 'package:animeverse/features/player/providers/video_provider.dart';
import 'package:animeverse/features/bookmarks/providers/bookmark_provider.dart';
import 'package:animeverse/features/anime/providers/search_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => AnimeProvider()),
    ChangeNotifierProvider(create: (_) => MovieProvider()),
    ChangeNotifierProvider(create: (_) => VideoProvider()),
    ChangeNotifierProvider(create: (_) => BookmarkProvider()),
    ChangeNotifierProvider(create: (_) => SearchProvider()),
  ], child: const MainApp()));
}
