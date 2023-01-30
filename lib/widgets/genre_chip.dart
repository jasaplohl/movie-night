import 'package:flutter/material.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/screens/genre/genre_screen.dart';

class GenreChip extends StatelessWidget {
  final Genre genre;
  const GenreChip({Key? key, required this.genre}) : super(key: key);

  void onGenreClick(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GenreScreen(genre: genre),));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onGenreClick(context),
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
