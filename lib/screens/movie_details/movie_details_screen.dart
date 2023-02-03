import 'package:flutter/material.dart';
import 'package:movie_night/models/collection_model.dart';
import 'package:movie_night/models/movie_details_model.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/services/show_error_dialog.dart';
import 'package:movie_night/widgets/divider_margin.dart';
import 'package:movie_night/widgets/genre_row.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/media_row.dart';
import 'package:movie_night/widgets/trailer.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  MovieDetails? movieDetails;
  Collection? collection;

  @override
  void initState() {
    getMovieDetails(widget.movieId).then((MovieDetails value) {
      setState(() {
        movieDetails = value;
        if(value.belongsToCollection != null) {
          getCollectionDetails(value.belongsToCollection["id"]);
        }
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  Future<void> getCollectionDetails(int collectionId) async {
    getCollection(collectionId).then((Collection value) {
      setState(() {
        collection = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
  }

  Widget getCollectionSection() {
    return Column(
      children: [
        const DividerMargin(),
        Text(collection!.name, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(collection!.overview, textAlign: TextAlign.center),
        ),
        MediaRow(
            media: collection!.parts,
        )
      ],
    );
  }

  Widget getBody() {
    if(movieDetails == null) {
      return const LoadingSpinner();
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
                movieDetails!.releaseDate != null ? Text("${formatDateString(movieDetails!.releaseDate!)} (${movieDetails!.status})")
                : Text(movieDetails!.status),
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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(movieDetails!.runtime != null) Row(
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
                )
              ],
            ),
            if(movieDetails!.homePage != null) ElevatedButton(
              onPressed: () => goToUrl(movieDetails!.homePage!, context),
              child: const Text("Home page"),
            ),
            GenreRow(genres: movieDetails!.genres),
            if(movieDetails!.videos != null && movieDetails!.videos!.isNotEmpty) Trailer(youtubeKey: getTrailerUrl(movieDetails!.videos!)),
            if(movieDetails!.backdropPath != null) Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Image.network(getBackdropUrl(movieDetails!.backdropPath!)),
            ),
            if(movieDetails!.tagline != null) Text(movieDetails!.tagline!, style: Theme.of(context).textTheme.headlineSmall),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(movieDetails!.overview ?? "No description available"),
            ),
            if(movieDetails!.belongsToCollection != null && collection != null) getCollectionSection(),
          ],
        ),
      );
    }
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
      body: getBody(),
    );
  }
}
