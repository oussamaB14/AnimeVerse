import 'package:animeverse/features/anime/widgets/anime_list_item.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';

class AnimeDetailsScreen extends StatefulWidget {
  const AnimeDetailsScreen({super.key});

  @override
  State<AnimeDetailsScreen> createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://storage.googleapis.com/fc-freepik-pro-rev1-eu-static/ai-styles-landings/anime/characters-and-scenes.jpg?h=1280',
                    ),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _animeTitleRow('Demon slayer (kimitsu no yabi shou)'),
                  _animeDetailsInfoRow(
                      rate: '9.2',
                      year: '2022',
                      age: '13',
                      country: 'Japan',
                      subtitle: 'subtitle'),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedPlayCircle02,
                            size: 20,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Play',
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.othersWhite,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 300,
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                          'Download',
                                          style: GoogleFonts.urbanist(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkDark3,
                                          ),
                                        ),
                                        const Divider(
                                          color: AppColors.greyscale300,
                                        ),
                                        // _episodesListTitle(
                                        //     ["Season 1", "Season 2"]),
                                        _downloadQualityListTitle(
                                            ["720p", "480p", "360p"]),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              style: TextButton.styleFrom(
                                                minimumSize:
                                                    const Size(120, 50),
                                                backgroundColor:
                                                    AppColors.primary100,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                              ),
                                              child: Text('Cancel',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.urbanist(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .primary500)),
                                            ),
                                            TextButton(
                                              onPressed: () async {},
                                              style: TextButton.styleFrom(
                                                minimumSize:
                                                    const Size(120, 50),
                                                backgroundColor:
                                                    AppColors.primary500,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                              ),
                                              child: Text('Download',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.urbanist(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .othersWhite)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedDownload02,
                            size: 20,
                            color: Colors.green,
                          ),
                          label: Text(
                            'Download',
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary500,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              side: const BorderSide(color: Colors.green)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Action | Comedy | Shounen | Josei |Fun ",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  _episodesListTitle(["Season 1", "Season 2"]),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 8.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AnimeDetailsScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: const DecorationImage(
                                          image: AssetImage("assets/icon.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary500,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Episode ${index + 1}",
                                        style: GoogleFonts.urbanist(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: HugeIcon(
                                          icon: HugeIcons
                                              .strokeRoundedPlayCircle02,
                                          color: AppColors.othersWhite),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "More Like This",
                      style: GoogleFonts.urbanist(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkDark3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _animeTitleRow(String animeTitle) {
  final bookmarked = ValueNotifier<bool>(false);

  return Row(
    children: [
      Text(
        animeTitle.length > 20
            ? '${animeTitle.substring(0, 20)}...'
            : animeTitle,
        style: GoogleFonts.urbanist(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.darkDark3,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      const Spacer(),
      IconButton(
        onPressed: () {
          bookmarked.value = !bookmarked.value;
        },
        icon: ValueListenableBuilder<bool>(
          valueListenable: bookmarked,
          builder: (context, value, child) {
            return HeroIcon(
              HeroIcons.bookmark,
              color: AppColors.primary500,
              style: value ? HeroIconStyle.solid : HeroIconStyle.outline,
            );
          },
        ),
      ),
    ],
  );
}

Widget _animeDetailsInfoRow({
  required String rate,
  required String year,
  required String age,
  required String country,
  required String subtitle,
}) {
  return Row(
    children: [
      const HugeIcon(
          icon: HugeIcons.strokeRoundedStar, color: AppColors.primary500),
      const SizedBox(width: 8),
      Text(
        rate,
        style: GoogleFonts.urbanist(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primary500,
        ),
      ),
      const SizedBox(width: 8),
      const HugeIcon(
          icon: HugeIcons.strokeRoundedArrowRight01,
          color: AppColors.primary500),
      const SizedBox(width: 8),
      Text(
        year,
        style: GoogleFonts.urbanist(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.darkDark3,
        ),
      ),
      const SizedBox(width: 8),
      _chipLabel('$age+'),
      const SizedBox(width: 8),
      _chipLabel(country),
      const SizedBox(width: 8),
      _chipLabel(subtitle)
    ],
  );
}

Widget _chipLabel(String label) {
  return Chip(
    label: Text(
      label,
      style: GoogleFonts.urbanist(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primary500,
      ),
    ),
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: AppColors.primary500), // Added green border
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0,
    padding: const EdgeInsets.symmetric(
        horizontal: 4, vertical: 0.5), // Reduced padding
    visualDensity: const VisualDensity(vertical: -4),
  );
}

Widget _episodesListTitle(List<String> seasons) {
  return ListTile(
      title: Text(
        'Episodes',
        style: GoogleFonts.urbanist(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.darkDark3,
        ),
      ),
      trailing: DropdownButton<String>(
        value: seasons.first,
        onChanged: (String? newValue) {
          // setState(() {
          //   _selectedSeason = newValue!;
          // });
        },
        items: seasons.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary500,
              ),
            ),
          );
        }).toList(),
        icon: const Icon(
          Iconsax.arrow_down_1,
          color: AppColors.primary500,
        ),
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(10),
      ));
}

Widget _downloadQualityListTitle(List<String> qualities) {
  return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        'Download Quality',
        style: GoogleFonts.urbanist(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.darkDark3,
        ),
      ),
      trailing: DropdownButton<String>(
        value: qualities.first,
        onChanged: (String? newValue) {
          // setState(() {
          //   _selectedQuality = newValue!;
          // });
        },
        items: qualities.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary500,
              ),
            ),
          );
        }).toList(),
        icon: const Icon(
          Iconsax.arrow_down_1,
          color: AppColors.primary500,
        ),
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(10),
      ));
}


Future<void> _showDownloadProgressDialog(
    BuildContext context, String episodeName, int progress) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Downloading $episodeName'),
        content: Row(
          children: [
            CircularProgressIndicator(
              value: progress / 100,
            ),
            const SizedBox(width: 16),
            Text('$progress%')
          ],
        ),
      );
    },
  );
}
