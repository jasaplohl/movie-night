import 'package:flutter/material.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/widgets/movie_card.dart';

class GenreScreen extends StatefulWidget {
  final Genre genre;
  const GenreScreen({Key? key, required this.genre}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  List<Movie>? movies;

  @override
  void initState() {
    getMoviesByGenre(widget.genre.id, 1, "popularity.desc").then((List<Movie> value) {
      print(value);
      setState(() {
        movies = value;
      });
    });
    super.initState();
  }

  List<Widget> getMovieCards() {
    List<Widget> movieCards = [];
    for (Movie element in movies!) {
      movieCards.add(MovieCard(movie: element));
    }
    return movieCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.genre.name)),
      body: movies != null
        ? ListView(
          children: [
            Wrap(
              direction: Axis.horizontal,
              children: getMovieCards(),
            ),
          ],
        )
        : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight),
        ),
      )
    );
  }
}
