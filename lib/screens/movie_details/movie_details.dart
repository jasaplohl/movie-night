import 'package:flutter/material.dart';
import 'package:movie_night/models/collection_model.dart';
import 'package:movie_night/models/movie_details_model.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/widgets/genre_row.dart';
import 'package:movie_night/widgets/movie_row.dart';

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
      print(err);
    });
    super.initState();
  }

  Future<void> getCollectionDetails(int collectionId) async {
    getCollection(collectionId).then((Collection value) {
      setState(() {
        collection = value;
      });
    }).catchError((err) {
      print(err);
    });
  }

  Widget getCollectionSection() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: const Divider(thickness: 3,),
        ),
        Text(collection!.name, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(collection!.overview, textAlign: TextAlign.center),
        ),
        MovieRow(
            movies: collection!.parts!,
        )
      ],
    );
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
            GenreRow(genres: movieDetails!.genres),
            if(movieDetails!.backdropPath != null)
              Container(
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
              icon: const Icon(Icons.favorite_outline, color: Colors.red,)
          )
        ],
      ),
      body: getBody(),
    );
  }
}
