import 'package:flutter/material.dart';

class SearchBarWithFilters extends StatefulWidget {
  const SearchBarWithFilters({super.key});

  @override
  State<SearchBarWithFilters> createState() => _SearchBarWithFiltersState();
}

class _SearchBarWithFiltersState extends State<SearchBarWithFilters> {
  bool _showFilters = false;

  final List<String> filters = [
    'Photos',
    'Videos',
    'Links',
    'Audio',
    'Documents',
    'Polls',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // final primaryColor = theme.colorScheme.primary;
    // final backgroundColor = theme.scaffoldBackgroundColor;
    final cardColor = isDark ? Colors.grey[800] : Colors.grey[200];
    final chipTextColor = isDark ? Colors.white : Colors.deepPurple;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _showFilters = !_showFilters;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.search, color: theme.iconTheme.color),
                const SizedBox(width: 10),
                Text(
                  'Search...',
                  style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                ),
              ],
            ),
          ),
        ),
        if (_showFilters) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: filters.map((filter) {
              return Chip(
                label: Text(filter),
                backgroundColor: theme.cardColor,
                labelStyle: TextStyle(color: chipTextColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 1,
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
