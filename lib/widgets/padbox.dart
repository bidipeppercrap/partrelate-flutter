import 'package:flutter/material.dart';

class PadBox extends StatelessWidget {
  const PadBox({
    super.key,
    required this.title
});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 128,
        child: Center(
            child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                )
            )
        )
    );
  }
}