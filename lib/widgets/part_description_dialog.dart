import 'package:flutter/material.dart';

class PartDescriptionDialog extends StatelessWidget {
  const PartDescriptionDialog({
    super.key,
    required this.description
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    void close() {
      return Navigator.pop(context);
    }

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16,),
            Text(description),
            const SizedBox(height: 16,),
            TextButton(
              onPressed: close,
              child: const Text('Close'),
            )
          ],
        )
      )
    );
  }
}