import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/screens/movie_details/movie_details.dart';
import 'package:movie_night/services/movie_service.dart';

class MediaCard extends StatelessWidget {
  final Media media;
  const MediaCard({required Key key, required this.media}) : super(key: key);

  void onMediaPress(BuildContext context) {
    if(media.type == MediaType.movie) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movieId: media.id),));
    } else {
      print("Navigating to a TV show details page!");
    }
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
              onTap: () => onMediaPress(context),
              child: media.posterPath != null ? Image.network(
                  getImageUrl(media.posterPath!),
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
                    Text(media.voteAverage.toString()),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border, color: Colors.red),
                )
              ],
            ),
            Text(
              media.title,
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
