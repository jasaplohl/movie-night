import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/widgets/movie_row.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {

  List<Movie>? popularMovies;
  List<Movie>? popularTvShows;

  @override
  void initState() {
    getPopularMovies().then((List<Movie> value) {
      setState(() {
        popularMovies = value;
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
          MovieRow(
              title: "Movies",
              movies: popularMovies
          ),
          MovieRow(
              title: "TV Shows",
              movies: popularTvShows
          ),
          MovieRow(
              title: "People",
              movies: popularTvShows
          ),
        ],
    );
  }
}
