import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/screens/movie_details/movie_details_screen.dart';
import 'package:movie_night/screens/person_details/person_details_screen.dart';
import 'package:movie_night/screens/tv_show_details/tv_show_details_screen.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/widgets/add_to_favourites_button.dart';
import 'package:movie_night/widgets/watchlist_button.dart';
import 'package:provider/provider.dart';

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
                  if(media.type != MediaType.person) Positioned(
                    top: 5,
                    right: 0,
                    child: WatchlistButton(
                      mediaId: media.id,
                      mediaType: media.type
                    ),
                  ),
                  Consumer<AuthProvider>(
                    builder: (context, AuthProvider provider, child) {
                      if(provider.user != null && provider.getHistoryItem(media.id, media.type) != null) {
                        return const Positioned(
                          bottom: 5,
                          right: 5,
                          child: Badge(
                            label: Text("Watched"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
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
                  AddToFavouritesButton(
                    id: media.id,
                    mediaType: media.type,
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
            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
