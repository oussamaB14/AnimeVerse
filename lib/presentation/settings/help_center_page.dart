import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Example'),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            unselectedLabelColor: Colors.grey.shade400,
            dividerColor: Colors.grey.shade400,
            tabs: [
              Tab(
                child: Text(
                  'FAQ',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Contact Us',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Content for Section 1

            // Content for Section 2
            Center(
              child: Column(children: [
                ExpansionTile(
                  title: Text('Is AnimeVerse free to use?'),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Yes, AnimeVerse is free to use. Some premium features, such as exclusive content or ad-free experience, '
                        'may require a subscription.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('How can I watch anime on AnimeVerse?'),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Simply browse the anime catalog, select the title you want to watch, and press the play button. '
                        'You can also search for specific titles using the search bar.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('Can I download anime to watch offline?'),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Currently, downloading anime for offline viewing is available only for premium users. '
                        'This feature ensures you can enjoy your favorite anime even without an internet connection.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('How can I report an issue or give feedback?'),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'You can report issues or share feedback through the "Contact Us" option in the app. '
                        'Alternatively, email us at support@animeverse.com.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('Does AnimeVerse support subtitles?'),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Yes, AnimeVerse supports multiple languages for subtitles. You can choose your preferred language '
                        'while watching any anime.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('Is there a community feature in AnimeVerse?'),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'AnimeVerse includes community features such as user reviews, discussion forums, and recommendation sharing. '
                        'Connect with fellow anime fans and share your favorite shows!',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              ]),
            ),
            Center(
              child: Column(
                children: [
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.all(16.0),
                    child: ListTile(
                      leading: HugeIcon(
                          icon: HugeIcons.strokeRoundedCall,
                          color: AppColors.primary500),
                      title: Text(
                        'Customer Support',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.all(16.0),
                    child: ListTile(
                      leading: HugeIcon(
                          icon: HugeIcons.strokeRoundedWhatsapp,
                          color: AppColors.primary500),
                      title: Text(
                        'Whatsapp',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.all(16.0),
                    child: ListTile(
                      leading: HugeIcon(
                          icon: HugeIcons.strokeRoundedInternet,
                          color: AppColors.primary500),
                      title: Text(
                        'Website',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.all(16.0),
                    child: ListTile(
                      leading: HugeIcon(
                          icon: HugeIcons.strokeRoundedFacebook02,
                          color: AppColors.primary500),
                      title: Text(
                        'Facebook',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.all(16.0),
                    child: ListTile(
                      leading: HugeIcon(
                          icon: HugeIcons.strokeRoundedInstagram,
                          color: AppColors.primary500),
                      title: Text(
                        'Instagram',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
