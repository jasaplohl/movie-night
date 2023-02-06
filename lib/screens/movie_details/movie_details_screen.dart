import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_details_model.dart';
import 'package:movie_night/screens/movie_details/widgets/collection_section.dart';
import 'package:movie_night/screens/movie_details/widgets/movie_details_header.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/widgets/credits_section.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/widgets/genre_row.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/recommendations_section.dart';
import 'package:movie_night/widgets/trailer.dart';

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
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieDetails == null ? "" : movieDetails!.title),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.remove_red_eye, color: Theme.of(context).primaryColorLight,)
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline, color: Colors.red,)
          )
        ],
      ),
      body: movieDetails == null ?
      const LoadingSpinner() :
      ListView(
        children: [
          MovieDetailsHeader(
            title: movieDetails!.title,
            releaseDate: movieDetails!.releaseDate,
            status: movieDetails!.status,
            voteAverage: movieDetails!.voteAverage,
            runtime: movieDetails!.runtime,
            originalLanguage: movieDetails!.originalLanguage,
            homePage: movieDetails!.homePage,
            voteCount: movieDetails!.voteCount,
          ),
          GenreRow(genres: movieDetails!.genres),
          if(movieDetails!.videos.isNotEmpty) Trailer(youtubeKey: getTrailerUrl(movieDetails!.videos)),
          if(movieDetails!.backdropPath != null) Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Image.network(getBackdropUrl(movieDetails!.backdropPath!)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(movieDetails!.tagline != null) Text(movieDetails!.tagline!, style: Theme.of(context).textTheme.headlineSmall),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(movieDetails!.overview ?? "No description available"),
                ),
              ],
            ),
          ),
          if(movieDetails!.collectionId != null) CollectionSection(collectionId: movieDetails!.collectionId!),
          if(movieDetails!.cast.isNotEmpty) CreditsSection(sectionTitle: "Cast", credits: movieDetails!.cast),
          if(movieDetails!.crew.isNotEmpty) CreditsSection(sectionTitle: "Crew", credits: movieDetails!.crew),
          if(movieDetails!.recommendations.isNotEmpty) RecommendationsSection(recommended: movieDetails!.recommendations),
        ],
      ),
    );
  }
}
