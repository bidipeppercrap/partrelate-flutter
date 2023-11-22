import 'package:flutter/material.dart';

class VehicleForm extends StatelessWidget {
  const VehicleForm({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.noteController
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    InputDecoration fieldDecoration(String title) {
      return InputDecoration(
        labelText: title,
        border: const OutlineInputBorder()
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          controller: nameController,
          decoration: fieldDecoration('Name'),
        ),
        const SizedBox(height: 16,),
        TextField(
          controller: descriptionController,
          decoration: fieldDecoration('Description'),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 5,
        ),
        const SizedBox(height: 16,),
        TextField(
          controller: noteController,
          decoration: fieldDecoration('Note'),
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 5,
        )
      ],
    );
  }
}