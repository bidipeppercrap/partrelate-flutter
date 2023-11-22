import 'package:flutter/material.dart';

import 'part_selection_dialog.dart';
import '../types/part.dart';

class AssignPartBody extends StatefulWidget {
  const AssignPartBody({
    super.key,
    required this.vehiclePartName,
    required this.descriptionController,
    required this.onSubmit,
    required this.quantityController,
    this.selectedPart
  });

  final String vehiclePartName;
  final Function(Part?) onSubmit;
  final TextEditingController descriptionController;
  final TextEditingController quantityController;
  final Part? selectedPart;

  @override
  State<AssignPartBody> createState() => _AssignPartBodyState();
}

class _AssignPartBodyState extends State<AssignPartBody> {
  Part? selectedPart;

  @override
  void initState() {
    super.initState();

    selectedPart = widget.selectedPart;
  }

  void cancel(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> showPartSelection(BuildContext context) async {
    selectedPart = await showDialog(
        context: context,
        builder: (BuildContext context) => const PartSelectionDialog()
    );

    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    String selectedPartName = selectedPart != null ? selectedPart!.name : 'Select Part';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.vehiclePartName),
        const SizedBox(height: 16,),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => showPartSelection(context),
                child: Text(selectedPartName),
              ),
            )
          ],
        ),
        const SizedBox(height: 16,),
        TextField(
          controller: widget.descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
          ),
        ),
        const SizedBox(height: 16,),
        TextField(
          controller: widget.quantityController,
          decoration: const InputDecoration(
            labelText: 'Quantity',
          ),
        ),
        const SizedBox(height: 16,),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => widget.onSubmit.call(selectedPart),
                child: const Text('Submit'),
              ),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: ElevatedButton(
                onPressed: () => cancel.call(context),
                child: const Text('Cancel'),
              ),
            )
          ],
        )
      ],
    );
  }
}