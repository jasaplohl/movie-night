import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';

class MovieDetails extends StatelessWidget {
  static const String routeName = "movie";

  final Movie movie;
  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text(movie.title, style: Theme.of(context).textTheme.headlineMedium),
          Text(movie.overview)
        ],
      ),
    );
  }
}
