import 'package:flutter/material.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/models/media_res_model.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/media_card.dart';

class SearchResultsMovies extends StatefulWidget {
  final String query;
  const SearchResultsMovies({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchResultsMovies> createState() => _SearchResultsMoviesState();
}

class _SearchResultsMoviesState extends State<SearchResultsMovies> {

  List<Media>? searchResult;

  @override
  void initState() {
    searchMovies(widget.query, 1).then((MediaRes value) {
      setState(() {
        searchResult = value.results;
      });
    }).catchError((err) {
      showErrorDialog(context, err);
    });
    super.initState();
  }

  List<Widget> getMovieCards() {
    List<Widget> movieCards = [];
    for (Media element in searchResult!) {
      movieCards.add(MediaCard(key: ValueKey(element.id), media: element));
    }
    return movieCards;
  }

  @override
  Widget build(BuildContext context) {
    return searchResult != null ?
    ListView(
      children: [
        Wrap(
          direction: Axis.horizontal,
          children: getMovieCards(),
        ),
      ],
    ) : const LoadingSpinner();
  }
}
