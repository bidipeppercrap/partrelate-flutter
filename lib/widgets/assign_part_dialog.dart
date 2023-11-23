import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'assign_part_body.dart';
import '../types/part_to_vehicle_part.dart';
import '../types/vehicle_part.dart';
import '../types/part.dart';
import '../stores/parts_to_vehicle_parts.dart';

class AssignPartDialog extends ConsumerStatefulWidget {
  const AssignPartDialog({
    super.key,
    required this.onCreated,
    required this.vehiclePart
  });

  final VehiclePart vehiclePart;
  final Function() onCreated;

  @override
  ConsumerState<AssignPartDialog> createState() => _AssignPartDialogState();
}

class _AssignPartDialogState extends ConsumerState<AssignPartDialog> {
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    quantityController.dispose();

    super.dispose();
  }

  void handleSubmit(Part? part) {
    final repository = ref.read(partsToVehiclePartsRepositoryProvider);

    if (part == null) return;

    final data = PartToVehiclePart(
      partId: part.id!,
      vehiclePartId: widget.vehiclePart.id!,
      description: descriptionController.text,
      quantity: quantityController.text
    );

    try {
      repository.add(data);

      widget.onCreated.call();

      Navigator.pop(context);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AssignPartBody(
          vehiclePartName: widget.vehiclePart.name,
          onSubmit: handleSubmit,
          descriptionController: descriptionController,
          quantityController: quantityController,
        )
      ),
    );
  }
}