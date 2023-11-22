import 'package:flutter/material.dart';

class DetailActionButtons extends StatelessWidget {
  const DetailActionButtons({
    super.key,
    required this.handleDelete,
    required this.handleEdit
  });

  final Function() handleDelete;
  final Function() handleEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: () => handleEdit.call(),
              child: const Icon(Icons.edit)
          ),
        ),
        const SizedBox(width: 8,),
        ElevatedButton(
          onPressed: () => handleDelete.call(),
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)
          ),
          child: const Icon(Icons.delete, color: Colors.white,),
        )
      ],
    );
  }
}