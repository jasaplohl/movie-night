import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/models/tv_show_model.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/movie_card.dart';

class MovieRow extends StatelessWidget {
  final String? title;
  final List<Movie>? movies;

  const MovieRow({Key? key, this.title, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title != null) Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(title!, style: Theme.of(context).textTheme.headlineSmall),
        ),
        movies == null ? const LoadingSpinner() : SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: movies!.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return MovieCard(key: ValueKey(movies![index].id), movie: movies![index]);
            },
          ),
        )
      ],
    );
  }
}
