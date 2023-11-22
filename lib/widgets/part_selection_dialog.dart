import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'part_list.dart';
import 'refresh_button.dart';
import 'pagination.dart';
import '../stores/parts.dart';
import '../types/part.dart';

class PartSelectionDialog extends ConsumerStatefulWidget {
  const PartSelectionDialog({super.key});

  @override
  ConsumerState<PartSelectionDialog> createState() => _PartSelectionDialogState();
}

class _PartSelectionDialogState extends ConsumerState<PartSelectionDialog> {
  final searchController = TextEditingController();
  String searchText = '';
  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    searchController.addListener(handleSearchChange);
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  void handleSearchChange() {
    setState(() {
      searchText = searchController.text;
      currentPage = 1;
    });
  }

  void handleNext() {
    setState(() {
      currentPage++;
      searchText = searchController.text;
    });
  }

  void handlePrev() {
    setState(() {
      currentPage--;
      searchText = searchController.text;
    });
  }

  void _selectPart(Part part) {
    Navigator.pop(context, part);
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
              keywords: searchText,
              onTapHandler: _selectPart,
              onRefreshPressed: handleSearchChange,
              handlePrev: handlePrev,
              handleNext: handleNext,
              currentPage: currentPage,
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
    required this.onTapHandler,
    required this.currentPage,
    required this.handleNext,
    required this.handlePrev
  });

  final String keywords;
  final int currentPage;
  final Function() onRefreshPressed;
  final Function() handleNext;
  final Function() handlePrev;
  final Function(Part) onTapHandler;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partsRepository = ref.read(partsRepositoryProvider);
    final parts = partsRepository.fetch(keywords, currentPage);

    return FutureBuilder(
        future: parts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final parts = snapshot.data!.data;

            return SingleChildScrollView(
              child: Column(
                children: [
                  PartList(parts: parts, onTapHandler: (part) => onTapHandler.call(part),),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Pagination(
                        totalPages: snapshot.data!.totalPages,
                        currentPage: currentPage,
                        handleNext: handleNext,
                        handlePrev: handlePrev,
                      )
                  ),
                ],
              ),
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