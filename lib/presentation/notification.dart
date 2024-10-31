import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
                    onChanged: (value) {
                      setState(() {
                        value = !value;
                      });
                    },
                    activeColor: Colors.green,
                    thumbColor: WidgetStateProperty.all(Colors.white),
                    inactiveTrackColor: Colors.grey.shade400,
                    value: true,
                  ),
                ),
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
                    onChanged: (value) {
                      setState(() {
                        value = !value;
                      });
                    },
                    activeColor: Colors.green,
                    thumbColor: WidgetStateProperty.all(Colors.white),
                    inactiveTrackColor: Colors.grey.shade400,
                    value: true,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'New Service Available',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    onChanged: (value) {
                      setState(() {
                        value = !value;
                      });
                    },
                    activeColor: Colors.green,
                    thumbColor: WidgetStateProperty.all(Colors.white),
                    inactiveTrackColor: Colors.grey.shade400,
                    value: true,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'New Release Movie',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    onChanged: (value) {
                      setState(() {
                        value = !value;
                      });
                    },
                    activeColor: Colors.green,
                    thumbColor: WidgetStateProperty.all(Colors.white),
                    inactiveTrackColor: Colors.grey.shade400,
                    value: true,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'App Update',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    onChanged: (value) {
                      setState(() {
                        value = !value;
                      });
                    },
                    activeColor: Colors.green,
                    thumbColor: WidgetStateProperty.all(Colors.white),
                    inactiveTrackColor: Colors.grey.shade400,
                    value: true,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
