import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/models/movies_res_model.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/widgets/movie_card.dart';

class SearchResults extends StatefulWidget {
  final String query;
  const SearchResults({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {

  List<Movie>? searchResult;

  @override
  void initState() {
    searchMovies(widget.query, 1).then((MovieRes value) {
      setState(() {
        searchResult = value.results;
      });
    });
    super.initState();
  }

  List<Widget> getMovieCards() {
    List<Widget> movieCards = [];
    for (Movie element in searchResult!) {
      movieCards.add(MovieCard(movie: element));
    }
    return movieCards;
  }


  // TODO: Split to movies/TV shows/actors
  @override
  Widget build(BuildContext context) {
    return searchResult != null
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
    );
  }
}
