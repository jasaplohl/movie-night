import 'package:flutter/material.dart';
import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/screens/movie_details/movie_details.dart';
import 'package:movie_night/services/movie_service.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  void onMoviePress(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movieId: movie.id),));
  }

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
              GestureDetector(
                onTap: () => onMoviePress(context),
                child: Image.network(
                    getImageUrl(movie.posterPath!),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 300
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(movie.voteAverage.toString()),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border, color: Colors.red),
                  )
                ],
              ),
              Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      );
  }
}
