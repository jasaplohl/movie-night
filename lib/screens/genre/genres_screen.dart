import 'package:flutter/material.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/screens/genre/genre_screen.dart';
import 'package:movie_night/services/genre_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/widgets/genre_row.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({Key? key}) : super(key: key);

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

// TODO: Show license page
// showLicensePage(context: context);

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
      showErrorDialog(context, err);
    });

    getTvShowGenres().then((List<Genre> value) {
      showErrorDialog(context, "err");
      setState(() {
        tvGenres = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err);
    });

    super.initState();
  }

  void onGenreClick(Genre genre) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GenreScreen(genre: genre),));
  }

  List<Widget> getMovieGenreChips() {
    List<Widget> chips = [];

    for (Genre genre in movieGenres!) {
      chips.add(Chip(
        label: Text(genre.name),
      ));
    }

    // return TextButton(
    //   key: ValueKey(movieGenres![index].id),
    //   onPressed: () => onGenreClick(movieGenres![index]),
    //   style: TextButton.styleFrom(foregroundColor: Theme.of(context).primaryColorLight),
    //   child: Text(movieGenres![index].name),
    // );
    return chips;
  }

  List<Widget> getTvGenreChips() {
    List<Widget> chips = [];
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Genres")),
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
