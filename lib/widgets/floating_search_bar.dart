import 'package:flutter/material.dart';

class FloatingSearchBar extends StatelessWidget {
  const FloatingSearchBar({
    super.key,
    required this.searchController
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            icon: Icon(Icons.search),
            labelText: 'Search',
          ),
        ),
      )
    );
  }
}