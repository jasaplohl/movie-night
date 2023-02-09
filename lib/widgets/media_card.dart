import 'package:flutter/material.dart';
import 'package:movie_night/utils/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/screens/movie_details/movie_details_screen.dart';
import 'package:movie_night/screens/person_details/person_details_screen.dart';
import 'package:movie_night/screens/tv_show_details/tv_show_details_screen.dart';
import 'package:movie_night/services/common_services.dart';

class MediaCard extends StatelessWidget {
  final Media media;
  const MediaCard({required Key key, required this.media}) : super(key: key);

  void onMediaPress(BuildContext context) {
    if(media.type == MediaType.movie) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movieId: media.id),));
    } else if(media.type == MediaType.tv) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => TvShowDetailsScreen(tvShowId: media.id),));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PersonDetailsScreen(personId: media.id),));
    }
  }

  void onWatchListTap() {
    print("Adding to watchlist");
  }

  void onFavouritesTap() {
    print("Adding to favourites");
  }

  @override
  Widget build(BuildContext context) {
    final String placeholderImage = media.type == MediaType.person ? "lib/assets/images/default_avatar.webp" : "lib/assets/images/default_img.webp";
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
              child: Stack(
                children: [
                  media.posterPath != null ? FadeInImage.assetNetwork(
                    image: getImageUrl(media.posterPath!),
                    placeholder: placeholderImage,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 300,
                  ) : Image.asset(
                    placeholderImage,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 300,
                  ),
                  if(media.type != MediaType.person) Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: onWatchListTap,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          shape: const CircleBorder(),
                        ),
                        child: Icon(Icons.bookmark_outline, color: Theme.of(context).primaryColorLight),
                      )
                    ],
                  ),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: media.voteAverage == null ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(media.voteAverage != null) Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(media.voteAverage.toString()),
                    ],
                  ),
                  IconButton(
                      onPressed: onFavouritesTap,
                      icon: const Icon(Icons.favorite_outline, color: Colors.red,)
                  ),
                ],
              ),
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
