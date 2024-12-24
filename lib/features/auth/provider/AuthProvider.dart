import 'package:animeverse/app/routes/app_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get user => _user;

  AuthProvider() {
    _auth.setLanguageCode('en');
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print('Error during sign in: $e');
    }
  }

  Future<void> signUpWithEmail(String email, String password, String firstName, String lastName) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      
      // Update the user's display name
      await userCredential.user?.updateDisplayName('$firstName $lastName');
    } catch (e) {
      print('Error during sign up: $e');
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential).then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AppWrapper()),
        );
      });
    } catch (e) {
      print('Error during Google sign-in: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    
  }

  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }
}
