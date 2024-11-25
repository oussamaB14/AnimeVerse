import 'package:animeverse/app/shared/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: 'privacy policy'),
        body: SingleChildScrollView(
          child: Column(children: [
            ExpansionTile(
              title: Text(
                '1. Information We Collect',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : null,
                ),
              ),
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                      'When you use our app, we may collect the following types of information: a. Information You Provide: Account Information: When you sign up, we may collect your name, email address, and username. Feedback and Support: If you contact us for support or provide feedback, we may collect your contact details and the content of your message. b. Information We Collect Automatically:Device Information: Details about the device you use, such as device type, operating system, and unique device identifiers. Usage Data: Information about how you interact with the app, including pages viewed, search queries, and time spent in the app. c. Cookies and Tracking Technologies: We may use cookies or similar technologies to enhance your user experience. You can control these through your device settings.'),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                '2. How We Use Your Information',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : null,
                ),
              ),
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                      'We may use your information for the following purposes: To provide and improve the app functionality To personalize your experience, such as recommending anime or manga based on your preferences.To send important updates, such as app changes or new features. To provide customer support.To analyze usage patterns to improve the app’s performance and content.'),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                '3. Sharing Your Information',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : null,
                ),
              ),
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                      'We do not sell or share your personal information with third parties for marketing purposes However, we may share information in the following cases: With Service Providers: To help us operate and improve the app (e.g., analytics tools, hosting services). Legal Requirements: If required by law, regulation, or legal process.Business Transfers: In case of a merger, sale, or other transfer of assets. .'),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                '3. Sharing Your Information',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : null,
                ),
              ),
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                      'We do not sell or share your personal information with third parties for marketing purposes However, we may share information in the following cases: With Service Providers: To help us operate and improve the app (e.g., analytics tools, hosting services). Legal Requirements: If required by law, regulation, or legal process.Business Transfers: In case of a merger, sale, or other transfer of assets. .'),
                ),
              ],
            )
          ]),
        ));
  }
}
