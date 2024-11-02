import 'package:animeverse/presentation/home.dart';
import 'package:animeverse/presentation/new_release.dart';
import 'package:animeverse/presentation/user_profile.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unicons/unicons.dart';

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
            icon: Icon(Iconsax.home_1),
            activeIcon: Icon(Iconsax.home5),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: HeroIcon(
              HeroIcons.calendarDays,
              style: HeroIconStyle.outline,
            ),
            activeIcon: HeroIcon(
              HeroIcons.calendarDays,
              style: HeroIconStyle.solid,
            ),
            label: 'Release Date',
          ),
          BottomNavigationBarItem(
            icon: HeroIcon(
              HeroIcons.bookmark,
              style: HeroIconStyle.outline,
            ),
            activeIcon: HeroIcon(
              HeroIcons.bookmark,
              style: HeroIconStyle.solid,
            ),
            label: 'My List',
          ),
          BottomNavigationBarItem(
            icon: HeroIcon(
              HeroIcons.inboxArrowDown,
              style: HeroIconStyle.outline,
            ),
            activeIcon: HeroIcon(
              HeroIcons.inboxArrowDown,
              style: HeroIconStyle.solid,
            ),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: HeroIcon(
              HeroIcons.user,
              style: HeroIconStyle.outline,
            ),
            activeIcon: HeroIcon(
              HeroIcons.user,
              style: HeroIconStyle.solid,
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
