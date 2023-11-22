import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stores/vehicle_parts.dart';
import '../types/vehicle_part.dart';
import '../widgets/vehicle_form.dart';
import '../widgets/refresh_button.dart';

class VehiclePartEditScreen extends ConsumerStatefulWidget {
  const VehiclePartEditScreen ({
    super.key,
    required this.vehiclePart
  });

  final VehiclePart vehiclePart;

  @override
  ConsumerState<VehiclePartEditScreen> createState() => _VehicleEditScreenState();
}

class _VehicleEditScreenState extends ConsumerState<VehiclePartEditScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final noteController = TextEditingController();

  Future<void> _submit() async {
    final repository = ref.read(vehiclePartsRepositoryProvider);

    final vehiclePart = VehiclePart(
      name: nameController.text,
      description: descriptionController.text,
      note: noteController.text,
      vehicleId: widget.vehiclePart.vehicleId
    );

    try {
      repository.update(vehiclePart, widget.vehiclePart.id!);

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
    final repository = ref.read(vehiclePartsRepositoryProvider);

    return FutureBuilder(
        future: repository.get(widget.vehiclePart.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final vehiclePart = snapshot.data!;

            nameController.text = vehiclePart.name;
            descriptionController.text = vehiclePart.description ?? '';
            noteController.text = vehiclePart.note ?? '';

            return VehiclePartEditScreenScaffold(
              vehiclePart: vehiclePart,
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

class VehiclePartEditScreenScaffold extends StatelessWidget {
  const VehiclePartEditScreenScaffold({
    super.key,
    required this.vehiclePart,
    required this.nameController,
    required this.descriptionController,
    required this.noteController,
    required this.onSubmitHandler
  });

  final VehiclePart vehiclePart;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController noteController;
  final Function() onSubmitHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Vehicle Part'),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Editing: ${vehiclePart.name}'),
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