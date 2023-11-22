import 'package:flutter/material.dart';

class VehicleDetailBody extends StatelessWidget {
  const VehicleDetailBody({
    super.key,
    required this.name,
    required this.description,
    required this.note
  });

  final String name;
  final String? description;
  final String? note;

  BoxDecoration infoDecoration(Color backgroundColor, Color outlineColor) {
    return BoxDecoration(
        border: Border.all(width: 2, color: outlineColor),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: backgroundColor
    );
  }

  List<Widget> childrenGenerator(String? description, String? note) {
    List<Widget> children = [];

    if (description != null && description.isNotEmpty) {
      children.add(const SizedBox(height: 16,));
      children.add(Container(
        padding: const EdgeInsets.all(16),
        decoration: infoDecoration(Colors.black12, Colors.grey),
        width: double.infinity,
        child: Text(description),
      ));
    }

    if (note != null && note.isNotEmpty) {
      children.add(const SizedBox(height: 16,));
      children.add(Container(
        padding: const EdgeInsets.all(16),
        decoration: infoDecoration(Colors.yellowAccent, Colors.yellow),
        width: double.infinity,
        child: Text(note, style: const TextStyle(fontWeight: FontWeight.bold),),
      ));
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(name),
        ...childrenGenerator(description, note)
      ],
    );
  }
}