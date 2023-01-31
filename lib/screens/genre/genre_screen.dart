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
  List<Media>? movies;
  String sortBy = "popularity.desc";

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    if(widget.genre.type == MediaType.movie) {
      getMovies();
    } else {
      getTVShows();
    }
    super.initState();
  }

  void getMovies() {
    print("Getting movies by genre");
    getMoviesByGenre(widget.genre.id, currentPage, sortBy).then((MediaRes value) {
      setState(() {
        totalPages = value.totalPages;
        totalResults = value.totalResults;
        movies = value.results;
      });
    }).catchError((err) {
      showErrorDialog(context, err);
    });
  }

  void getTVShows() {
    print("Getting TV Shows by genre");
  }

  List<Widget> getMovieCards() {
    List<Widget> movieCards = [];
    for (Media element in movies!) {
      movieCards.add(MediaCard(key: ValueKey(element.id), media: element));
    }
    return movieCards;
  }

  void onPageChange(int pageNumber) {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    getMoviesByGenre(widget.genre.id, pageNumber, sortBy).then((MediaRes value) {
      setState(() {
        currentPage = pageNumber;
        movies = value.results;
      });
    }).catchError((err) {
      showErrorDialog(context, err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.genre.name)),
      body: movies != null
        ? ListView(
          controller: scrollController,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text("Page $currentPage of $totalPages ($totalResults results).", textAlign: TextAlign.center),
            ),
            Wrap(
              direction: Axis.horizontal,
              children: getMovieCards(),
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
