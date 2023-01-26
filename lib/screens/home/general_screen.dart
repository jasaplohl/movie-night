import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/widgets/movie_row.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {

  List<Movie>? popularMovies;

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
      ],
    );
  }
}
