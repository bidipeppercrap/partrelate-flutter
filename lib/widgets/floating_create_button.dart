import 'package:flutter/material.dart';

class FloatingCreateButton extends StatelessWidget {
  const FloatingCreateButton({
    super.key,
    required this.onTapHandler
  });

  final void Function() onTapHandler;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: () => onTapHandler.call(),
      child: const Icon(Icons.add, color: Colors.white,),
    );
  }
}