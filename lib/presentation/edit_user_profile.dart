import 'package:animeverse/core/models/user.dart';
import 'package:animeverse/features/auth/provider/AuthProvider.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditUserProfileScreen extends StatefulWidget {
  const EditUserProfileScreen({super.key});

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final firebaseUser = authProvider.user;

    if (firebaseUser != null) {
      // Create a User object from the firebaseUser
      User user = User(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? 'No email',
        nom: firebaseUser.displayName?.split(' ').first ?? 'No first name',
        prenom: firebaseUser.displayName?.split(' ').last ?? 'No last name',
        userAvatar: firebaseUser.photoURL ??
            'https://avatars.githubusercontent.com/u/49993491?v=4',
      );

      final firstNameController = TextEditingController(
        text: user.nom,
      );
      final lastNameController = TextEditingController(
        text: user.prenom,
      );
      final emailController = TextEditingController(
        text: user.email,
      );

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: GoogleFonts.urbanist(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(user.userAvatar),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          // Handle photo update
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: GoogleFonts.urbanist(color: Colors.grey),
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.urbanist(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    user.nom = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: GoogleFonts.urbanist(color: Colors.grey),
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.urbanist(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    user.prenom = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              TextField(
                controller: emailController,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: GoogleFonts.urbanist(color: Colors.grey),
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.urbanist(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle update action
                    firebaseUser.updateDisplayName(
                        '${firstNameController.text} ${lastNameController.text}');
                    // Optionally update the photo URL
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary500,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: GoogleFonts.urbanist(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Center(child: Text('No user found'));
    }
  }
}
