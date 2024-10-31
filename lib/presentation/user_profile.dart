import 'package:animeverse/core/models/user.dart';
import 'package:animeverse/features/auth/pages/signin.dart';
import 'package:animeverse/features/auth/provider/AuthProvider.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final firebaseUser = authProvider.user;

    if (firebaseUser != null) {
      // Create a User object from the firebaseUser
      User user = User(
        id: firebaseUser.uid,
        email: firebaseUser.email!, nom: firebaseUser.displayName!, prenom: '',
        userAvatar: firebaseUser.photoURL!,
        // You can add other fields here if you need them
      );

      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage(user.userAvatar), // Placeholder image
                      ),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.nom,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const HugeIcon(
                    icon: HugeIcons.strokeRoundedCrown,
                    color: AppColors.primary500,
                    size: 40,
                  ),
                  title: const Text(
                    'Join Premium!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Coming Soon'),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.green),
                  onTap: () {
                    // Handle the tap event
                  },
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedUser,
                  color: Colors.black,
                ),
                title: const Text('Edit Profile'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedNotification03,
                  color: Colors.black,
                ),
                title: const Text('Notifications'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Notifications page
                },
              ),
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedDownload03,
                  color: Colors.black,
                ),
                title: const Text('Downlaod'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Settings page
                },
              ),
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedSecurityValidation,
                  color: Colors.black,
                ),
                title: const Text('Security'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Settings page
                },
              ),
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedLanguageCircle,
                  color: Colors.black,
                ),
                title: const Text('Language'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Settings page
                },
              ),
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedMoon02,
                  color: Colors.black,
                ),
                title: const Text('Dark Mode'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Settings page
                },
              ),
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedHelpCircle,
                  color: Colors.black,
                ),
                title: const Text('Help Center'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Settings page
                },
              ),
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedHelpCircle,
                  color: Colors.black,
                ),
                title: const Text('Privcy Policy'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Settings page
                },
              ),
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedLogout03,
                  color: Colors.red,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                // trailing: const Icon(Icons.arrow_forward_ios,color: Colors.red,),
                onTap: () async {
                  final authProvider = context.read<AuthProvider>();
                  await authProvider.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
                },
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
