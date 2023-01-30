import 'package:flutter/material.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/models/movies_res_model.dart';
import 'package:movie_night/services/genre_service.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/movie_card.dart';
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
  List<Movie>? movies;
  String sortBy = "popularity.desc";

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getMoviesByGenre(widget.genre.id, currentPage, sortBy).then((MovieRes value) {
      setState(() {
        totalPages = value.totalPages;
        totalResults = value.totalResults;
        movies = value.results;
      });
    });
    super.initState();
  }

  List<Widget> getMovieCards() {
    List<Widget> movieCards = [];
    for (Movie element in movies!) {
      movieCards.add(MovieCard(movie: element));
    }
    return movieCards;
  }

  void onPageChange(int pageNumber) {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    getMoviesByGenre(widget.genre.id, pageNumber, sortBy).then((MovieRes value) {
      setState(() {
        currentPage = pageNumber;
        movies = value.results;
      });
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
