import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const HugeIcon(
              icon: HugeIcons.strokeRoundedWifi02,
              color: AppColors.othersBlack,
            ),
            title: Text(
              'Wi-Fi Only',
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: isOn, // Replace with your boolean state
                  onChanged: (value) {
                    // Handle state change
                    setState(() {
                      isOn = value;
                    });
                  },
                  activeTrackColor: const Color(0xFF06C149),
                  activeColor: Colors.white,
                  inactiveTrackColor: AppColors.greyscale200,
                  inactiveThumbColor: Colors.white,
                )),
          ),
          ListTile(
            leading: const HugeIcon(
              icon: HugeIcons.strokeRoundedDownload03,
              color: AppColors.othersBlack,
            ),
            title: Text(
              'Smart Downloads',
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              color: AppColors.othersBlack,
            ),
          ),
          ListTile(
            leading: const HugeIcon(
              icon: HugeIcons.strokeRoundedVideo02,
              color: AppColors.othersBlack,
            ),
            title: Text(
              'Video Quality',
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              color: AppColors.othersBlack,
            ),
          ),
          ListTile(
            leading: const HugeIcon(
              icon: HugeIcons.strokeRoundedMic01,
              color: AppColors.othersBlack,
            ),
            title: Text(
              'Audio Quality',
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              color: AppColors.othersBlack,
            ),
          ),
          ListTile(
            leading: const HugeIcon(
              icon: HugeIcons.strokeRoundedDelete01,
              color: AppColors.othersBlack,
            ),
            title: Text(
              'Delete All Downloads',
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const HugeIcon(
              icon: HugeIcons.strokeRoundedDelete01,
              color: AppColors.othersBlack,
            ),
            title: Text(
              'Delete Cache',
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
