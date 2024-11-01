import 'package:animeverse/presentation/home.dart';
import 'package:animeverse/presentation/new_release.dart';
import 'package:animeverse/presentation/user_profile.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  int _currentIndex = 0;

  // Define your pages here
  final List<Widget> _pages = [
    const HomeScreen(),
    const NewReleasesScreen(),
    const MyListScreen(),
    const DownloadsScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF06C149),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              color: AppColors.greyscale500,
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              color: AppColors.primary500,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedCalendar01,
              color: AppColors.greyscale500,
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedCalendar01,
              color: AppColors.primary500,
            ),
            label: 'Release Date',
          ),
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedBookmark01,
              color: AppColors.greyscale500,
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedBookmark01,
              color: AppColors.primary500,
            ),
            label: 'My List',
          ),
          BottomNavigationBarItem(
             icon: HugeIcon(
              icon: HugeIcons.strokeRoundedDownload03,
              color: AppColors.greyscale500,
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedDownload03,
              color: AppColors.primary500,
            ),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedUser,
              color: AppColors.greyscale500,
            ),
            activeIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedUser,
              color: AppColors.primary500,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Dummy pages for demonstration

class ReleaseDateScreen extends StatelessWidget {
  const ReleaseDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Release Date Page',
            style: GoogleFonts.urbanist(fontSize: 24)));
  }
}

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('My List Page', style: GoogleFonts.urbanist(fontSize: 24)));
  }
}

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            Text('Downloads Page', style: GoogleFonts.urbanist(fontSize: 24)));
  }
}
