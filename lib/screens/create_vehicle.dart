import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/vehicle_form.dart';
import '../types/vehicle.dart';
import '../stores/vehicles.dart';

class CreateVehicleScreen extends ConsumerStatefulWidget {
  const CreateVehicleScreen({super.key});

  @override
  ConsumerState<CreateVehicleScreen> createState() => _CreateVehicleScreenState();
}

class _CreateVehicleScreenState extends ConsumerState<CreateVehicleScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final noteController = TextEditingController();

  Future<void> _submit() async {
    final vehiclesRepository = ref.read(vehiclesRepositoryProvider);

    final vehicle = Vehicle(
      name: nameController.text,
      description: descriptionController.text,
      note: noteController.text
    );

    try {
      vehiclesRepository.add(vehicle);

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
        title: const Text('Create Vehicle'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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