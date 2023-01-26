import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/widgets/movie_card.dart';

class MovieRow extends StatelessWidget {
  String title;
  List<Movie>? movies;

  MovieRow({Key? key, required this.title, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(
          height: 250,
          child: movies == null ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight),
            ),
          ) :
          ListView.builder(
            itemCount: movies!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return MovieCard(movie: movies![index]);
            },
          ),
        )
      ],
    );
  }
}
