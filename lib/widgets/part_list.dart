import 'package:flutter/material.dart';

import '../types/part.dart';
import 'padbox.dart';

class PartList extends StatelessWidget {
  const PartList({
    super.key,
    required this.parts,
    required this.onTapHandler,
  });

  final List<Part> parts;
  final Function(Part) onTapHandler;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: parts.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const PadBox(title: 'Start of Parts');
        }

        if (index == parts.length + 1) {
          return const PadBox(title: 'End of Parts');
        }

        Part part = parts[index - 1];

        return ListTile(
          title: Text(part.name),
          onTap: () => onTapHandler.call(part)
        );
      },
    );
  }
}
