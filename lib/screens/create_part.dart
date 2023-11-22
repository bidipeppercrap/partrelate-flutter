import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stores/parts.dart';
import '../types/part.dart';
import '../widgets/vehicle_form.dart';

class CreatePartScreen extends ConsumerStatefulWidget {
  const CreatePartScreen ({super.key});

  @override
  ConsumerState<CreatePartScreen> createState() => _CreatePartScreenState();
}

class _CreatePartScreenState extends ConsumerState<CreatePartScreen> {
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
      partsRepository.add(part);

      nameController.clear();
      descriptionController.clear();
      noteController.clear();

      const snackBar = SnackBar(content: Text('Created!'), backgroundColor: Colors.green,);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Part'),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                VehicleForm(
                    nameController: nameController,
                    descriptionController: descriptionController,
                    noteController: noteController
                ),
                const SizedBox(height: 16,),
                ElevatedButton(onPressed: _submit, child: const Text('Submit'))
              ]
          )
      ),
    );
  }
}