import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class ReleaseCalanderScreen extends StatefulWidget {
  const ReleaseCalanderScreen({super.key});

  @override
  State<ReleaseCalanderScreen> createState() => _ReleaseCalanderScreenState();
}

class _ReleaseCalanderScreenState extends State<ReleaseCalanderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Release calendar ',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkDark2,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                color: AppColors.darkDark2,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                //`selectedDate` the new date selected.
              },
              activeColor: AppColors.primary500,
              headerProps: const EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                dateFormatter: DateFormatter.fullDateDayAsStrMY(),
              ),
              dayProps: EasyDayProps(
                activeDayStyle: const DayStyle(
                    borderRadius: 32.0,
                    dayStrStyle: TextStyle(color: Colors.white),
                    dayNumStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    monthStrStyle: TextStyle(color: Colors.white)),
                inactiveDayStyle: DayStyle(
                  borderRadius: 32.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: AppColors.greyscale400,
                    ),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
              timeLineProps: const EasyTimeLineProps(
                hPadding: 16.0, // padding from left and right
                separatorPadding: 16.0, // padding between days
              ),
            ),
           const SizedBox(height: 45),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/no-release-date.png',
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "Sorry, there's no release schedule on this date",
                    style: GoogleFonts.urbanist(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkDark3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
