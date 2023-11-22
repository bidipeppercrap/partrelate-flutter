import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stores/parts.dart';
import '../types/part.dart';
import '../widgets/vehicle_form.dart';
import '../widgets/refresh_button.dart';

class PartEditScreen extends ConsumerStatefulWidget {
  const PartEditScreen ({
    super.key,
    required this.partId
  });

  final int partId;

  @override
  ConsumerState<PartEditScreen> createState() => _PartEditScreenState();
}

class _PartEditScreenState extends ConsumerState<PartEditScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final noteController = TextEditingController();

  Future<void> _submit() async {
    final partsRepository = ref.read(partsRepositoryProvider);

    final part = Part(
      name: nameController.text,
      description: descriptionController.text,
      note: noteController.text
    );

    try {
      partsRepository.update(part, widget.partId);

      nameController.clear();
      descriptionController.clear();
      noteController.clear();

      const snackBar = SnackBar(content: Text('Updated!'), backgroundColor: Colors.green,);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
      return;
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    noteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final partsRepository = ref.read(partsRepositoryProvider);

    return FutureBuilder(
        future: partsRepository.get(widget.partId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final part = snapshot.data!;

            nameController.text = part.name;
            descriptionController.text = part.description ?? '';
            noteController.text = part.note ?? '';

            return PartEditScreenScaffold(
              part: part,
              nameController: nameController,
              descriptionController: descriptionController,
              noteController: noteController,
              onSubmitHandler: _submit,
            );
          } else if (snapshot.hasError) {
            return Scaffold(
                body: Center(
                  child: RefreshButton(
                    onPressed: () {
                      setState(() { });
                    },
                  ),
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

class PartEditScreenScaffold extends StatelessWidget {
  const PartEditScreenScaffold({
    super.key,
    required this.part,
    required this.nameController,
    required this.descriptionController,
    required this.noteController,
    required this.onSubmitHandler
  });

  final Part part;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController noteController;
  final Function() onSubmitHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Part'),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Editing: ${part.name}'),
                const SizedBox(height: 16,),
                VehicleForm(
                    nameController: nameController,
                    descriptionController: descriptionController,
                    noteController: noteController
                ),
                const SizedBox(height: 16,),
                Row(children: [Expanded(child: ElevatedButton(onPressed: onSubmitHandler, child: const Text('Submit')))])
              ]
          )
      ),
    );
  }
}