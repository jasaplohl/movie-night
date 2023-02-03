import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/models/media_res_model.dart';
import 'package:movie_night/services/genre_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/media_card.dart';
import 'package:movie_night/widgets/pagination.dart';

class GenreScreen extends StatefulWidget {
  final Genre genre;
  const GenreScreen({Key? key, required this.genre}) : super(key: key);

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  int currentPage = 1;
  int totalPages = 1;
  int totalResults = 0;
  List<Media>? media;
  String sortBy = "popularity.desc";

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _setMedia(currentPage);

    super.initState();
  }

  void _setMedia(int page) {
    if(widget.genre.type == MediaType.movie) {
      _getMovies(page);
    } else if(widget.genre.type == MediaType.tv) {
      _getTVShows(page);
    }
  }

  void _getMovies(int page) {
    getMoviesByGenre(widget.genre.id, page, sortBy).then((MediaRes value) {
      setState(() {
        currentPage = page;
        totalPages = value.totalPages;
        totalResults = value.totalResults;
        media = value.results;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
  }

  void _getTVShows(int page) {
    getTvShowsByGenre(widget.genre.id, page, sortBy).then((MediaRes value) {
      setState(() {
        currentPage = page;
        totalPages = value.totalPages;
        totalResults = value.totalResults;
        media = value.results;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
  }

  void onPageChange(int pageNumber) {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

    _setMedia(pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.genre.name} ${widget.genre.type == MediaType.movie ? "Movies" : "TV Shows"}")),
      body: media != null
        ? ListView(
          controller: scrollController,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text("Page $currentPage of $totalPages ($totalResults results).", textAlign: TextAlign.center),
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                for (final Media element in media!) MediaCard(key: ValueKey(element.id), media: element),
              ],
            ),
            Pagination(
              currentPage: currentPage,
              totalPages: totalPages,
              onPageChange: onPageChange,
            )
          ],
        )
        : const LoadingSpinner(),
    );
  }
}
