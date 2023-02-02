import 'package:flutter/material.dart';

class RatingChip extends StatelessWidget {
  final num rating;
  const RatingChip({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(Icons.star_rate_rounded, color: Theme.of(context).primaryColorLight),
      label: Text(rating.toStringAsFixed(1)),
    );
  }
}
