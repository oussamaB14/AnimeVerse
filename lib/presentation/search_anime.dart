library;

import 'dart:async';
import 'package:animeverse/features/anime/providers/search_provider.dart';
import 'package:animeverse/features/anime/widgets/anime_list_item.dart';
import 'package:animeverse/features/anime/widgets/anime_list_loader.dart';
import 'package:animeverse/presentation/filter.dart';
import 'package:animeverse/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class SearchAnimeScreen extends StatefulWidget {
  const SearchAnimeScreen({super.key});

  @override
  State<SearchAnimeScreen> createState() => _SearchAnimeScreenState();
}

class _SearchAnimeScreenState extends State<SearchAnimeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchProvider>().searchAnime(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                autofocus: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.greyscale100,
                  hintText: 'Search anime...',
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
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            context.read<SearchProvider>().clearSearch();
                          },
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
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
      ),
      body: Consumer<SearchProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const AnimeListLoader();
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(provider.error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.searchAnime(provider.lastQuery);
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          if (provider.searchResults.isEmpty) {
            if (provider.lastQuery.isEmpty) {
              return const Center(
                child: Text('Start typing to search anime...'),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('No results found for "${provider.lastQuery}"'),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.searchResults.length,
            itemBuilder: (context, index) {
              return AnimeListItem(
                anime: provider.searchResults[index],
              );
            },
          );
        },
      ),
    );
  }
}
