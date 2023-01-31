import 'package:flutter/material.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/widgets/media_row.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  List<Media>? trendingDaily;
  List<Media>? trendingWeekly;
  List<Media>? popular;
  List<Media>? topRated;

  @override
  void initState() {
    getTrendingMoviesDaily().then((List<Media> value) {
      setState(() {
        trendingDaily = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err);
    });

    getTrendingMoviesWeekly().then((List<Media> value) {
      setState(() {
        trendingWeekly = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err);
    });

    getPopularMovies().then((List<Media> value) {
      setState(() {
        popular = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err);
    });

    getTopRatedMovies().then((List<Media> value) {
      setState(() {
        topRated = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MediaRow(
            title: "Trending today",
            media: trendingDaily
        ),
        MediaRow(
            title: "Trending this week",
            media: trendingWeekly
        ),
        MediaRow(
            title: "Popular",
            media: popular
        ),
        MediaRow(
            title: "Top Rated",
            media: topRated
        ),
      ],
    );
  }
}

