import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/services/movie_service.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shadowColor: Theme.of(context).primaryColorLight,
        child: SizedBox(
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                  getImageUrl(movie.posterPath!),
                  fit: BoxFit.cover,
                  width: 200,
                  height: 300
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  Text(movie.voteAverage.toString()),
                ],
              ),
              Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border, color: Colors.red),
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
}
