import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'assign_part_body.dart';
import '../types/part_to_vehicle_part.dart';
import '../types/vehicle_part.dart';
import '../types/part.dart';
import '../stores/parts_to_vehicle_parts.dart';

class EditAssignedPartDialog extends ConsumerStatefulWidget {
  const EditAssignedPartDialog({
    super.key,
    required this.onUpdated,
    required this.vehiclePart,
    required this.data
  });

  final PartToVehiclePart data;
  final VehiclePart vehiclePart;
  final Function() onUpdated;

  @override
  ConsumerState<EditAssignedPartDialog> createState() => _EditAssignedPartDialogState();
}

class _EditAssignedPartDialogState extends ConsumerState<EditAssignedPartDialog> {
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    descriptionController.text = widget.data.description ?? '';
    quantityController.text = widget.data.quantity ?? '';
  }

  @override
  void dispose() {
    descriptionController.dispose();
    quantityController.dispose();

    super.dispose();
  }

  Future<void> handleSubmit(Part? part) async {
    final repository = ref.read(partsToVehiclePartsRepositoryProvider);

    if (part == null) return;

    final data = PartToVehiclePart(
        partId: part.id!,
        vehiclePartId: widget.vehiclePart.id!,
        description: descriptionController.text,
        quantity: quantityController.text
    );

    try {
      repository.update(data, widget.data.id!);

      widget.onUpdated.call();

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
            selectedPart: widget.data.part,
            vehiclePartName: widget.vehiclePart.name,
            onSubmit: handleSubmit,
            descriptionController: descriptionController,
            quantityController: quantityController,
          )
      ),
    );
  }
}