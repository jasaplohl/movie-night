import 'package:flutter/material.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/screens/genre/genre_screen.dart';
import 'package:movie_night/services/movie_service.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({Key? key}) : super(key: key);

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  List<Genre>? movieGenres;

  @override
  void initState() {
    getMovieGenres().then((List<Genre> value) {
      setState(() {
        movieGenres = value;
      });
    });
    super.initState();
  }

  void onGenreClick(Genre genre) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GenreScreen(genre: genre),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Genres")),
      body: movieGenres != null
        ? ListView.builder(
            itemCount: movieGenres!.length,
            itemBuilder: (context, index) {
              return TextButton(
                key: ValueKey(movieGenres![index].id),
                onPressed: () => onGenreClick(movieGenres![index]),
                style: TextButton.styleFrom(foregroundColor: Theme.of(context).primaryColorLight),
                child: Text(movieGenres![index].name),
              );
            },
          )
          : Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight),
            ),
          )
    );
  }
}
