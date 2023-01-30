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
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width/2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => onMoviePress(context),
                child: movie.posterPath != null
                  ? Image.network(
                      getImageUrl(movie.posterPath!),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 300
                  )
                  : Image.asset("lib/assets/images/default_img.webp"),
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
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      );
  }
}
