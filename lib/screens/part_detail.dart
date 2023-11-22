import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'part_edit.dart';
import '../widgets/detail_action_buttons.dart';
import '../stores/parts.dart';
import '../widgets/vehicle_detail_body.dart';
import '../widgets/refresh_button.dart';

class PartDetailScreen extends ConsumerStatefulWidget {
  const PartDetailScreen({
    super.key,
    required this.partId
  });

  final int partId;

  @override
  ConsumerState<PartDetailScreen> createState() => _PartDetailScreenState();
}

class _PartDetailScreenState extends ConsumerState<PartDetailScreen> {
  final partSearchController = TextEditingController();

  Future<void> _delete() async {
    final partsRepository = ref.read(partsRepositoryProvider);

    try {
      await partsRepository.delete(widget.partId);

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
  }

  void _edit() {
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => PartEditScreen(partId: widget.partId),
        maintainState: false,
      )
    ).then((_) {
      if (!mounted) return;
      setState(() { });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final partsRepository = ref.read(partsRepositoryProvider);

    return FutureBuilder(
        future: partsRepository.get(widget.partId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final part = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: Text(part.name),
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          VehicleDetailBody(
                            name: part.name,
                            description: part.description,
                            note: part.note,
                          ),
                          const SizedBox(height: 16,),
                          DetailActionButtons(handleDelete: _delete, handleEdit: _edit)
                        ],
                      )
                  )
              )
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: RefreshButton(
                  onPressed: () {
                    setState(() { });
                  },
                )
              )
            );
          } else {
            return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                )
            );
          }
        }
    );
  }
}