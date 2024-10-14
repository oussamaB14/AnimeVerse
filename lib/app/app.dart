import 'package:animeverse/features/auth/pages/signin.dart';
import 'package:animeverse/presentation/home.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: SignInScreen()));
  }
}