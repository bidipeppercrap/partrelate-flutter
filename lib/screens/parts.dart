import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_part.dart';
import 'part_detail.dart';
import '../widgets/floating_create_button.dart';
import '../widgets/refresh_button.dart';
import '../stores/parts.dart';
import '../widgets/floating_search_bar.dart';
import '../widgets/part_list.dart';
import '../widgets/pagination.dart';
import '../widgets/padbox.dart';
import '../types/part.dart';

class PartsScreen extends ConsumerStatefulWidget {
  const PartsScreen({
    super.key,
  });

  final String title = 'Parts';

  @override
  ConsumerState<PartsScreen> createState() => _PartsScreenState();
}

class _PartsScreenState extends ConsumerState<PartsScreen> {
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

  void _partDetail(Part part) {
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => PartDetailScreen(partId: part.id!),
        maintainState: false
      )
    ).then((_) {
      if (!mounted) return;
      setState(() { });
    });
  }

  void createPart() {
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => const CreatePartScreen(),
        maintainState: false,
      ),
    ).then((_) {
      if (!mounted) return;
      setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {
    final partsRepository = ref.read(partsRepositoryProvider);
    final parts = partsRepository.fetch(searchText, currentPage);

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        FutureBuilder(
          future: parts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const PadBox(title: ''),
                    const PadBox(title: 'Start of Parts'),
                    PartList(parts: snapshot.data!.data, onTapHandler: _partDetail,),
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: Pagination(
                          totalPages: snapshot.data!.totalPages,
                          currentPage: currentPage,
                          handleNext: handleNext,
                          handlePrev: handlePrev,
                        )
                    ),
                    const PadBox(title: 'End of Parts'),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: RefreshButton(
                    onPressed: () {
                      setState(() { });
                    },
                  )
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: FloatingSearchBar(searchController: searchController,),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingCreateButton(
            onTapHandler: createPart,
          )
        ),
      ],
    );
  }
}