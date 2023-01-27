import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_details_model.dart';
import 'package:movie_night/services/movie_service.dart';

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
    getMovieDetails(widget.movieId).then((MovieDetails value) {
      setState(() {
        movieDetails = value;
      });
    }).catchError((err) {
      print(err);
    });
    super.initState();
  }

  Widget getBody() {
    if(movieDetails == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight),
        ),
      );
    } else {
      print(movieDetails!.videos);
      return ListView(
        children: [
          Text(movieDetails!.title, style: Theme.of(context).textTheme.headlineLarge),
          Row(
            children: [
              Icon(Icons.star, color: Theme.of(context).primaryColorLight),
              Text(movieDetails!.voteAverage.toString(), style: Theme.of(context).textTheme.headlineSmall,)
            ],
          ),
          if(movieDetails!.videos != null && movieDetails!.videos!.isNotEmpty) Text(movieDetails!.videos![0].toString()),
          if(movieDetails!.backdropPath != null) Image.network(getBackdropUrl(movieDetails!.backdropPath!)),
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
