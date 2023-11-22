import 'package:flutter/material.dart';

import '../types/part.dart';

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
      itemCount: parts.length,
      itemBuilder: (context, index) {
        Part part = parts[index];

        return ListTile(
          title: Text(part.name),
          onTap: () => onTapHandler.call(part)
        );
      },
    );
  }
}
