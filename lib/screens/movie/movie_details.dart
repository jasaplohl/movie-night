import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_details_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  MovieDetails? movieDetails;

  @override
  void initState() {
    super.initState();
  }

  Widget getBody() {
    if(movieDetails == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(
        children: [
          Text(movieDetails!.title, style: Theme.of(context).textTheme.headlineMedium),
          Text(movieDetails!.overview ?? "No description available")
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: getBody(),
    );
  }
}
