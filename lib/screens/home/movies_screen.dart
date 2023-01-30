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

  List<Movie>? trendingDaily;
  List<Movie>? trendingWeekly;
  List<Movie>? popular;
  List<Movie>? topRated;

  @override
  void initState() {
    getTrendingMoviesDaily().then((List<Movie> value) {
      setState(() {
        trendingDaily = value;
      });
    }).catchError((err) {
      print(err);
    });

    getTrendingMoviesWeekly().then((List<Movie> value) {
      setState(() {
        trendingWeekly = value;
      });
    }).catchError((err) {
      print(err);
    });

    getPopularMovies().then((List<Movie> value) {
      setState(() {
        popular = value;
      });
    }).catchError((err) {
      print(err);
    });

    getTopRatedMovies().then((List<Movie> value) {
      setState(() {
        topRated = value;
      });
    }).catchError((err) {
      print(err);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MovieRow(
            title: "Trending today",
            movies: trendingDaily
        ),
        MovieRow(
            title: "Trending this week",
            movies: trendingWeekly
        ),
        MovieRow(
            title: "Popular",
            movies: popular
        ),
        MovieRow(
            title: "Top Rated",
            movies: topRated
        ),
      ],
    );
  }
}

