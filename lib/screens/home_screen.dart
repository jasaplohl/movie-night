import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Movie>? movies;

  @override
  void initState() {
    getPopularMovies(page: 1).then((List<Movie> value) {
      setState(() {
        movies = value;
      });
    }).catchError((err) {
      // TODO: display error messages
      print(err);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: movies == null
        ? const Center(
          child: Text("Movie list"),
        )
        : SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: movies!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MovieCard(movie: movies![index]);
              },
            ),
        ),
    );
  }
}

