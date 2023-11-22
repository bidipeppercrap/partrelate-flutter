import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'part_list.dart';
import 'refresh_button.dart';
import '../stores/parts.dart';
import '../types/part.dart';

class PartSelectionDialog extends ConsumerStatefulWidget {
  const PartSelectionDialog({super.key});

  @override
  ConsumerState<PartSelectionDialog> createState() => _PartSelectionDialogState();
}

class _PartSelectionDialogState extends ConsumerState<PartSelectionDialog> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  void _selectPart(Part part) {
    Navigator.pop(context, part);
  }

  void _refreshParts() {
    debugPrint('test');
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    labelText: 'Search'
                ),
              ),
            ),
            PartListWrapper(
              keywords: searchController.text,
              onTapHandler: _selectPart,
              onRefreshPressed: _refreshParts,
            )
          ],
        ),
      )
    );
  }
}

class PartListWrapper extends ConsumerWidget {
  const PartListWrapper({
    super.key,
    required this.keywords,
    required this.onRefreshPressed,
    required this.onTapHandler
  });

  final String keywords;
  final Function() onRefreshPressed;
  final Function(Part) onTapHandler;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partsRepository = ref.read(partsRepositoryProvider);

    return FutureBuilder(
        future: partsRepository.fetch(keywords),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final parts = snapshot.data!.data;

            return PartList(
              parts: parts,
              onTapHandler: (part) => onTapHandler.call(part),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: RefreshButton(
                  onPressed: () => onRefreshPressed.call()
                )
            );
          } else {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
        }
    );
  }
}