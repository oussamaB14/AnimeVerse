import 'package:animeverse/core/models/user.dart';
import 'package:animeverse/features/auth/pages/signin.dart';
import 'package:animeverse/features/auth/provider/AuthProvider.dart';
import 'package:animeverse/presentation/download.dart';
import 'package:animeverse/presentation/edit_user_profile.dart';
import 'package:animeverse/presentation/notification.dart';
import 'package:animeverse/theme/AppColors.dart';
//import 'package:animeverse/theme/AppTextTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.labelMedium,
          ),
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
                title: Text(
                  'Edit Profile',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditUserProfileScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                  leading: const HugeIcon(
                    icon: HugeIcons.strokeRoundedNotification03,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Notifications',
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  }),
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedDownload03,
                  color: Colors.black,
                ),
                title: Text(
                  'Downlaod',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DownloadScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedSecurityValidation,
                  color: Colors.black,
                ),
                title: Text(
                  'Security',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                title: Text('Language',
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
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
                title: Text(
                  'Dark Mode',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                title: Text(
                  'Help Center',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                title: Text(
                  'Privcy Policy',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Settings page
                },
              ),
              // TO DO : ADD LOGOUT OPTION HERE IN  POP OUT CARD
              ListTile(
                leading: const HugeIcon(
                  icon: HugeIcons.strokeRoundedLogout03,
                  color: AppColors.othersRed,
                ),
                title: Text(
                  'Logout',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.othersRed,
                  ),
                ),
                // trailing: const Icon(Icons.arrow_forward_ios,color: Colors.red,),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 200,
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // const HugeIcon(
                              //   icon: HugeIcons.strokeRoundedSolidLine01,
                              //   color: AppColors.greyscale500,
                              // ),
                              const Divider(
                                  thickness: 2,
                                  indent: 160,
                                  endIndent: 160,
                                  color: AppColors.greyscale300),
                              Text(
                                'Logout',
                                style: GoogleFonts.urbanist(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.othersRed,
                                ),
                              ),
                              const Divider(
                                color: AppColors.greyscale300,
                              ),
                              Text(
                                'Are you sure you want to logout?',
                                style: GoogleFonts.urbanist(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.othersBlack,
                                ),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: const Size(120, 50),
                                      backgroundColor: AppColors.primary100,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                    ),
                                    child: Text('Cancel',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.urbanist(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary500)),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final authProvider =
                                          context.read<AuthProvider>();
                                      await authProvider.signOut();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignInScreen()));
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: const Size(120, 50),
                                      backgroundColor: AppColors.primary500,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                    ),
                                    child: Text('Yes, Logout',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.urbanist(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.othersWhite)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
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
