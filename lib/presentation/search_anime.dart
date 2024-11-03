/// ***********  ✨ Codeium Command 🌟  ************
library;

import 'package:animeverse/presentation/filter.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SearchAnimeScreen extends StatefulWidget {
  const SearchAnimeScreen({super.key});

  @override
  State<SearchAnimeScreen> createState() => _SearchAnimeScreenState();
}

class _SearchAnimeScreenState extends State<SearchAnimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      titleSpacing: 8,
      title: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.greyscale100,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.primary500),
                ),
                prefixIcon: const Icon(
                  HugeIcons.strokeRoundedSearch01,
                  color: AppColors.primary500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const SizedBox(width: 2),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FilterScreen(),
                  ),
                );
              },
              icon: const Icon(
                HugeIcons.strokeRoundedFilterHorizontal,
                color: AppColors.primary500,
              ),
            ),
          )
        ],
      ),
      automaticallyImplyLeading: false,
    ));
  }
}

/******  7b4971b6-b585-4cfc-b769-1e6afe963500  *******/