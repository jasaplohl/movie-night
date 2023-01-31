import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/models/media_res_model.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/services/tv_show_service.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/media_card.dart';

class SearchResultsMedia extends StatefulWidget {
  final MediaType mediaType;
  final String query;

  const SearchResultsMedia({
    Key? key,
    required this.mediaType,
    required this.query,
  }) : super(key: key);

  @override
  State<SearchResultsMedia> createState() => _SearchResultsMediaState();
}

class _SearchResultsMediaState extends State<SearchResultsMedia> {

  List<Media>? searchResult;

  @override
  void initState() {
    if(widget.mediaType == MediaType.movie) {
      getMovieSearchResults();
    } else {
      getTvShowsSearchResults();
    }
    super.initState();
  }

  void getMovieSearchResults() {
    searchMovies(widget.query, 1).then((MediaRes value) {
      setState(() {
        searchResult = value.results;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
  }

  void getTvShowsSearchResults() {
    searchTvShows(widget.query, 1).then((MediaRes value) {
      setState(() {
        searchResult = value.results;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
  }

  List<Widget> getMediaCards() {
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
          children: getMediaCards(),
        ),
      ],
    ) : const LoadingSpinner();
  }
}
