import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sort & Filter ',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkDark2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FilterSection(
                title: 'Sort',
                options: [
                  'Popularity',
                  'Rating',
                  'A-Z',
                  'Release Date',
                ],
              ),
              const _FilterSection(
                title: 'Category',
                options: [
                  'Action',
                  'Comedy',
                  'Drama',
                  'Fantasy',
                  'Horror',
                  'Mystery',
                  'Romance',
                  'Science Fiction',
                  'Thriller',
                ],
              ),
              const _FilterSection(
                title: 'Region',
                options: [
                  'Japan',
                  'China',
                  'Korea',
                  'United States',
                  'Europe',
                ],
              ),
              const _FilterSection(
                title: 'Genre',
                options: [
                  'Adventure',
                  'Fantasy',
                  'Mystery',
                  'Romance',
                  'Science Fiction',
                  'Thriller',
                  'Horror',
                  'Comedy',
                ],
              ),
              _FilterSection(
                title: 'Release Year',
                options: List.generate(
                  5,
                  (index) => (DateTime.now().year - index).toString(),
                ),
              ),
              SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary100,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                          ),
                          child: Text(
                            'Reset',
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary500,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                          ),
                          child: Text(
                            'Apply',
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.othersWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.title,
    required this.options,
    super.key,
  });

  final String title;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            title,
            style: GoogleFonts.urbanist(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkDark2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              options.map((option) => _FilterChip(option: option)).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.option,
    super.key,
  });

  final String option;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        option,
        style: GoogleFonts.urbanist(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      selected: false,
      // selectedLabelStyle: GoogleFonts.urbanist(
      //   fontSize: 14,
      //   fontWeight: FontWeight.bold,
      //   color: Colors.white,
      // ),
      onSelected: (_) {},
      selectedColor: AppColors.primary300,
      labelStyle: GoogleFonts.urbanist(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.darkDark3,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.primary300),
      ),
    );
  }
}
