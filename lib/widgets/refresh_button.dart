import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    super.key,
    required this.onPressed
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed.call(),
      child: const Icon(Icons.refresh)
    );
  }
}