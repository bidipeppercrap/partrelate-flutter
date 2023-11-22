import 'package:flutter/material.dart';

class VehiclePartDetailBody extends StatelessWidget {
  const VehiclePartDetailBody({
    super.key,
    required this.description,
    required this.note
  });

  final String? description;
  final String? note;

  BoxDecoration infoDecoration(Color? backgroundColor, Color? outlineColor) {
    return BoxDecoration(
        border: Border.all(width: 3, color: outlineColor ?? Colors.transparent),
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        color: backgroundColor
    );
  }

  List<Widget> childrenBuilder(String? description, String? note) {
    List<Widget> children = [];

    if (description != null && description.isNotEmpty
    || note != null && note.isNotEmpty) {
      children.add(const SizedBox(height: 16,));
    }

    if (description != null && description.isNotEmpty) {
      children.add(Container(
        padding: const EdgeInsets.all(6),
        decoration: infoDecoration(Colors.grey[200], Colors.black26),
        width: double.infinity,
        child: Text(
          description,
          style: const TextStyle(
            color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 12
          )
        ),
      ));
    }

    if (description != null && description.isNotEmpty
        && note != null && note.isNotEmpty) {
      children.add(const SizedBox(height: 16,));
    }

    if (note != null && note.isNotEmpty) {
      children.add(Container(
        padding: const EdgeInsets.all(6),
        decoration: infoDecoration(Colors.yellow[600], Colors.black26),
        width: double.infinity,
        child: Text(
          note,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 12
          )
        ),
      ));
    }

    if (description != null && description.isNotEmpty
        || note != null && note.isNotEmpty) {
      children.add(const SizedBox(height: 16,));
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: childrenBuilder(description, note)
    );
  }
}