import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final String? imagePath;
  const CustomChip({Key? key, required this.label, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: imagePath != null ? Image.network(
        imagePath!,
        fit: BoxFit.cover,
      ) : null,
      label: Text(label),
      elevation: 15,
    );
  }
}
