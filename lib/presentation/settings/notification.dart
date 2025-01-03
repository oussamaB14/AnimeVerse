import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'General Notification',
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
                title: Text(
                  'New Arrival',
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
                title: Text(
                  'New Service Available',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing:  Transform.scale(
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
                title: Text(
                  'New Release Movie',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing:  Transform.scale(
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
                title: Text(
                  'App Update',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing:  Transform.scale(
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
            ],
          ),
        ));
  }
}
