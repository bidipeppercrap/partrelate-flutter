import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stores/vehicles.dart';
import '../types/vehicle.dart';
import '../widgets/vehicle_form.dart';
import '../widgets/refresh_button.dart';

class VehicleEditScreen extends ConsumerStatefulWidget {
  const VehicleEditScreen ({
    super.key,
    required this.vehicleId
  });

  final int vehicleId;

  @override
  ConsumerState<VehicleEditScreen> createState() => _VehicleEditScreenState();
}

class _VehicleEditScreenState extends ConsumerState<VehicleEditScreen> {
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
      vehiclesRepository.update(vehicle, widget.vehicleId);

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
    final vehiclesRepository = ref.read(vehiclesRepositoryProvider);

    return FutureBuilder(
        future: vehiclesRepository.get(widget.vehicleId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final vehicle = snapshot.data!;

            nameController.text = vehicle.name;
            descriptionController.text = vehicle.description ?? '';
            noteController.text = vehicle.note ?? '';

            return VehicleEditScreenScaffold(
              vehicle: vehicle,
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

class VehicleEditScreenScaffold extends StatelessWidget {
  const VehicleEditScreenScaffold({
    super.key,
    required this.vehicle,
    required this.nameController,
    required this.descriptionController,
    required this.noteController,
    required this.onSubmitHandler
  });

  final Vehicle vehicle;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController noteController;
  final Function() onSubmitHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Vehicle'),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Editing: ${vehicle.name}'),
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