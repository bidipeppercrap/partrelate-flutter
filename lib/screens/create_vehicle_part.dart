import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stores/vehicle_parts.dart';
import '../types/vehicle_part.dart';
import '../types/vehicle.dart';
import '../widgets/vehicle_form.dart';

class CreateVehiclePartScreen extends ConsumerStatefulWidget {
  const CreateVehiclePartScreen({
    super.key,
    required this.vehicle
  });

  final Vehicle vehicle;

  @override
  ConsumerState<CreateVehiclePartScreen> createState() => _CreateVehiclePartScreenState();
}

class _CreateVehiclePartScreenState extends ConsumerState<CreateVehiclePartScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final noteController = TextEditingController();

  Future<void> _submit() async {
    if (widget.vehicle.id == null) {
      const snackBar = SnackBar(content: Text('Vehicle Id is required!'), backgroundColor: Colors.red,);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    final int vehicleId = widget.vehicle.id!;

    final vehiclePart = VehiclePart(
      vehicleId: vehicleId,
      name: nameController.text,
      description: descriptionController.text,
      note: noteController.text
    );

    final vehiclePartsRepository = ref.read(vehiclePartsRepositoryProvider);

    try {
      vehiclePartsRepository.add(vehiclePart);

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
        title: Text('Part for ${widget.vehicle.name}'),
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