import 'package:flutter/material.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/services/tv_show_service.dart';
import 'package:movie_night/widgets/media_row.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({Key? key}) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {

  List<Media>? popularMovies;
  List<Media>? popularTvShows;
  List<Media>? popularActors;

  @override
  void initState() {
    getPopularMovies().then((List<Media> value) {
      setState(() {
        popularMovies = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });

    getPopularTvShows().then((List<Media> value) {
      setState(() {
        popularTvShows = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          MediaRow(
              title: "Movies",
              media: popularMovies
          ),
          MediaRow(
              title: "TV Shows",
              media: popularTvShows
          ),
          MediaRow(
              title: "People",
              media: popularActors
          ),
        ],
    );
  }
}
