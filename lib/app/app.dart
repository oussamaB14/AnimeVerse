import 'package:animeverse/app/routes/app_splashScreen.dart';
import 'package:animeverse/features/auth/pages/signin.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: SplashScreen()));
  }
}
