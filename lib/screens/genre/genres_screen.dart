import 'package:flutter/material.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/screens/genre/genre_screen.dart';
import 'package:movie_night/utils/custom_search_delegate.dart';
import 'package:movie_night/services/genre_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/widgets/genre_row.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({Key? key}) : super(key: key);

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  List<Genre>? movieGenres;
  List<Genre>? tvGenres;

  @override
  void initState() {
    getMovieGenres().then((List<Genre> value) {
      setState(() {
        movieGenres = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });

    getTvShowGenres().then((List<Genre> value) {
      setState(() {
        tvGenres = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });

    super.initState();
  }

  void onGenreClick(Genre genre) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GenreScreen(genre: genre),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Genres"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search)
          ),
        ],
      ),
      body: ListView(
        children: [
          Text("Movie Genres", style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Theme.of(context).primaryColorLight)),
          GenreRow(genres: movieGenres),
          Text("TV Show Genres", style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Theme.of(context).primaryColorLight)),
          GenreRow(genres: tvGenres),
        ],
      ),
    );
  }
}
