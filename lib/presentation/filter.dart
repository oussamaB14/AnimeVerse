import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animeverse/features/anime/providers/search_provider.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final Set<String> _selectedGenres = {};
  String? _selectedYear;
  String? _selectedSort;

  final List<String> _sortOptions = ['Latest', 'Release Date', 'Popularity'];
  final List<String> _years = List.generate(
    10,
    (index) => (DateTime.now().year - index).toString(),
  );

  @override
  void initState() {
    super.initState();
    final provider = context.read<SearchProvider>();
    _selectedGenres.addAll(provider.selectedGenres);
    _selectedYear = provider.selectedYear;
    _selectedSort = provider.selectedSort;
    
    if (provider.availableGenres == null) {
      provider.loadGenres();
    }
  }

  Widget _buildSortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort By',
          style: GoogleFonts.urbanist(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkDark2,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _sortOptions.map((sort) => 
            ChoiceChip(
              label: Text(sort),
              selected: _selectedSort == sort,
              onSelected: (selected) {
                setState(() {
                  _selectedSort = selected ? sort : null;
                });
              },
              selectedColor: AppColors.primary500,
              labelStyle: GoogleFonts.urbanist(
                color: _selectedSort == sort ? Colors.white : AppColors.darkDark3,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: _selectedSort == sort ? Colors.transparent : AppColors.primary300,
                ),
              ),
            ),
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildGenreSection(List<Map<String, String>> genres) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genres',
          style: GoogleFonts.urbanist(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkDark2,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: genres.map((genre) {
            final isSelected = _selectedGenres.contains(genre['id']);
            return FilterChip(
              label: Text(genre['title']!),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedGenres.add(genre['id']!);
                  } else {
                    _selectedGenres.remove(genre['id']!);
                  }
                });
              },
              selectedColor: AppColors.primary500,
              labelStyle: GoogleFonts.urbanist(
                color: isSelected ? Colors.white : AppColors.darkDark3,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: isSelected ? Colors.transparent : AppColors.primary300,
                ),
              ),
              showCheckmark: false,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildYearSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Release Year',
          style: GoogleFonts.urbanist(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkDark2,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _years.map((year) => 
            ChoiceChip(
              label: Text(year),
              selected: _selectedYear == year,
              onSelected: (selected) {
                setState(() {
                  _selectedYear = selected ? year : null;
                });
              },
              selectedColor: AppColors.primary500,
              labelStyle: GoogleFonts.urbanist(
                color: _selectedYear == year ? Colors.white : AppColors.darkDark3,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: _selectedYear == year ? Colors.transparent : AppColors.primary300,
                ),
              ),
            ),
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: _resetFilters,
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary100,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
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
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _applyFilters,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary500,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'Apply',
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _applyFilters() {
    context.read<SearchProvider>().updateFilters(
      genres: _selectedGenres.toList(),
      year: _selectedYear,
      sort: _selectedSort,
    );
    Navigator.pop(context);
  }

  void _resetFilters() {
    setState(() {
      _selectedGenres.clear();
      _selectedYear = null;
      _selectedSort = null;
    });
    context.read<SearchProvider>().clearFilters();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sort & Filter',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkDark2,
          ),
        ),
      ),
      body: Consumer<SearchProvider>(
        builder: (context, provider, child) {
          if (provider.availableGenres == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSortSection(),
                const SizedBox(height: 24),
                _buildGenreSection(provider.availableGenres!),
                const SizedBox(height: 24),
                _buildYearSection(),
                const SizedBox(height: 32),
                _buildActionButtons(),
              ],
            ),
          );
        },
      ),
    );
  }
}
