import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/widgets/movie_row.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  List<Movie>? popularMovies;
  List<Movie>? topRatedMovies;
  List<Movie>? upcomingMovies;

  @override
  void initState() {
    getPopularMovies().then((List<Movie> value) {
      setState(() {
        popularMovies = value;
      });
    }).catchError((err) {
      // TODO: display error messages
      print(err);
    });

    getTopRatedMovies().then((List<Movie> value) {
      setState(() {
        topRatedMovies = value;
      });
    }).catchError((err) {
      // TODO: display error messages
      print(err);
    });

    getUpcomingMovies().then((List<Movie> value) {
      setState(() {
        upcomingMovies = value;
      });
    }).catchError((err) {
      // TODO: display error messages
      print(err);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MovieRow(
            title: "Popular",
            movies: popularMovies
        ),
        MovieRow(
            title: "Top Rated",
            movies: topRatedMovies
        ),
        MovieRow(
            title: "Upcoming",
            movies: upcomingMovies
        ),
      ],
    );
  }
}

