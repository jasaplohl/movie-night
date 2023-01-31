import 'package:flutter/material.dart';
import 'package:movie_night/models/tv_show_model.dart';
import 'package:movie_night/services/movie_service.dart';

class TvShowCard extends StatelessWidget {
  final TvShow tvShow;
  const TvShowCard({required Key key, required this.tvShow}) : super(key: key);

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
              onTap: () => {},
              child: tvShow.posterPath != null ? Image.network(
                  getImageUrl(tvShow.posterPath!),
                  fit: BoxFit.cover,
                  width: 200,
                  height: 300
              ) : Image.asset(
                "lib/assets/images/default_img.webp",
                fit: BoxFit.cover,
                width: 200,
                height: 300,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    Text(tvShow.voteAverage.toString()),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border, color: Colors.red),
                )
              ],
            ),
            Text(
              tvShow.name,
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
