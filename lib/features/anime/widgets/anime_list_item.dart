import 'package:flutter/material.dart';

class AnimeListItem extends StatefulWidget {
  const AnimeListItem({super.key});

  @override
  State<AnimeListItem> createState() => _AnimeListItemState();
}

bool _isAdded = false;

class _AnimeListItemState extends State<AnimeListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://storage.googleapis.com/fc-freepik-pro-rev1-eu-static/ai-styles-landings/anime/characters-and-scenes.jpg?h=1280',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '4.5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Attack on Titan',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Action | Adventure | Fantasy,Action | Adventure | Fantasy',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '2022 |Japan ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isAdded = !_isAdded;
                      });
                    },
                    child: Chip(
                      label: Text(
                        'My List',
                        style: TextStyle(
                          color: _isAdded ? Colors.green : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor:
                          _isAdded ? Colors.transparent : Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                        side: _isAdded
                            ? const BorderSide(color: Colors.green)
                            : const BorderSide(color: Colors.green),
                      ),
                      avatar: Icon(
                        _isAdded ? Icons.done : Icons.add,
                        color: _isAdded ? Colors.green : Colors.white,
                        size: 16,
                      ),
                      visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
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
