import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 5,
        shadowColor: Theme.of(context).primaryColorLight,
        child: Text(movie.title),
      ),
    );
  }
}
