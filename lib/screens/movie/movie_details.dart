import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_details_model.dart';
import 'package:movie_night/services/common_services.dart';
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
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          children: [
            Text(movieDetails!.title, style: Theme.of(context).textTheme.headlineLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(formatDate(DateTime.parse(movieDetails!.releaseDate))),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Icon(Icons.star_rate_rounded, color: Theme.of(context).primaryColorLight),
                    ),
                    Text(movieDetails!.voteAverage.toString(), style: Theme.of(context).textTheme.headlineSmall,)
                  ],
                ),
              ],
            ),
            if(movieDetails!.runtime != null)Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: const Icon(Icons.timer_outlined),
                ),
                Text("${movieDetails!.runtime!.toString()} min"),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: const Icon(Icons.speaker_notes),
                ),
                Text(movieDetails!.originalLanguage.toUpperCase()),
              ],
            ),
            if(movieDetails!.backdropPath != null) Image.network(getBackdropUrl(movieDetails!.backdropPath!)),
            Text(movieDetails!.overview ?? "No description available")
          ],
        ),
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
