import 'package:animeverse/core/models/user.dart';
import 'package:animeverse/features/auth/pages/signin.dart';
import 'package:animeverse/features/auth/provider/AuthProvider.dart';
import 'package:animeverse/presentation/download.dart';
import 'package:animeverse/presentation/edit_user_profile.dart';
import 'package:animeverse/presentation/help_center_page.dart';
import 'package:animeverse/presentation/language_page.dart';
import 'package:animeverse/presentation/notification.dart';
import 'package:animeverse/presentation/privacy_policy_page.dart';
import 'package:animeverse/presentation/security_page.dart';
import 'package:animeverse/presentation/themeSwitcher.dart';
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
            style: GoogleFonts.urbanist(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkDark3,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              user.userAvatar), // Placeholder image
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
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.green),
                    onTap: () {
                      // Handle the tap event
                    },
                  ),
                ),
                const SizedBox(height: 20),
                buildListTile(
                    context: context,
                    icon: HugeIcons.strokeRoundedUser,
                    title: 'Edit Profile',
                    destination: const EditUserProfileScreen()),
                buildListTile(
                  context: context,
                  icon: HugeIcons.strokeRoundedNotification03,
                  title: 'Notifications',
                  destination: const NotificationScreen(),
                ),
                buildListTile(
                  context: context,
                  icon: HugeIcons.strokeRoundedDownload03,
                  title: 'Downlaod',
                  destination: const DownloadScreen(),
                ),
                buildListTile(
                  context: context,
                  icon: HugeIcons.strokeRoundedSecurityValidation,
                  title: 'Security',
                  destination: const SecurityPage(),
                ),
                buildListTile(
                  context: context,
                  icon: HugeIcons.strokeRoundedLanguageCircle,
                  title: 'Language',
                  destination: const LanguagePage(),
                ),
                buildListTile(
                  context: context,
                  icon: HugeIcons.strokeRoundedMoon02,
                  title: 'Theme',
                  destination: const ThemeswitcherScreen(),
                ),
                buildListTile(
                    icon: HugeIcons.strokeRoundedHelpCircle,
                    title: 'Help Center',
                    destination: const HelpCenterPage(),
                    context: context),
                buildListTile(
                  icon: HugeIcons.strokeRoundedHelpCircle,
                  title: 'Privcy Policy',
                  destination: const PrivacyPolicy(),
                  context: context,
                ),
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
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : AppColors.darkDark1,
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
        ),
      );
    } else {
      return const Center(child: Text('No user found'));
    }
  }
}

Widget buildListTile({
  required IconData icon,
  required String title,
  required Widget destination,
  required BuildContext context,
}) {
  return ListTile(
    leading: HugeIcon(
      icon: icon,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : AppColors.darkDark1,
    ),
    title: Text(
      title,
      style: GoogleFonts.urbanist(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => destination,
        ),
      );
    },
  );
}
