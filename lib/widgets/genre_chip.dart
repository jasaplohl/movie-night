import 'package:flutter/material.dart';
import 'package:movie_night/models/genre_model.dart';

class GenreChip extends StatelessWidget {
  final Genre genre;
  const GenreChip({Key? key, required this.genre}) : super(key: key);

  void onGenreClick() {
    // TODO: redirect to genre page
    print("${genre.id} -> ${genre.name}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onGenreClick,
      child: Container(
          key: ValueKey(genre.id),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Chip(
            label: Text(genre.name),
            elevation: 15,
          )
      ),
    );
  }
}
