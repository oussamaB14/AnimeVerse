import 'package:animeverse/app/routes/app_splashScreen.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(),
      //darkTheme: ThemeData.dark(useMaterial3: true).copyWith(),
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
