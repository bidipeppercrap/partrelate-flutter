// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  const Pagination({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.handlePrev,
    required this.handleNext
  });

  final int totalPages;
  final int currentPage;

  final Function() handlePrev;
  final Function() handleNext;

  Function()? generateHandler(String type) {
    if (type == 'next' && currentPage >= totalPages) return null;
    if (type == 'prev' && currentPage <= 1) return null;

    if (type == 'next') return () => handleNext.call();
    if (type == 'prev') return () => handlePrev.call();

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: generateHandler('prev'),
                child: const Icon(Icons.arrow_back)
              )
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: ElevatedButton(
                onPressed: generateHandler('next'),
                child: const Icon(Icons.arrow_forward)
              )
            )
          ]
        )
      )
    );
  }
}