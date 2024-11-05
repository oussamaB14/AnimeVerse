import 'package:animeverse/app/routes/app_wrapper.dart';
import 'package:animeverse/features/auth/pages/signin.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // Add a small delay
    firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;

    // User is signed in
    if (user != null) {
      // User is signed in
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AppWrapper()),
      );
    } else {
       Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.green.shade300,
                Colors.green.shade500,
              ],
            ),
          ),
          child: Image.asset('assets/icon.png'), // Splash screen image
        ),
      ),
    );
  }
}
