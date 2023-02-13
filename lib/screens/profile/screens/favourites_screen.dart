import 'package:flutter/material.dart';
import 'package:movie_night/models/saved_media_model.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/services/media_service.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/media_card.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {

  String title = "Favourites";
  List<Media>? media;

  @override
  void didChangeDependencies() {
    setMedia();
    super.didChangeDependencies();
  }

  Future<void> setMedia({MediaType? mediaType}) async {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

    String newTitle;
    final List<SavedMedia> favourites;
    if(mediaType == null) {
      newTitle = "Favourites";
      favourites = authProvider.favourites;
    } else if(mediaType == MediaType.movie) {
      newTitle = "Favourite Movies";
      favourites = authProvider.favouriteMovies;
    } else if(mediaType == MediaType.tv) {
      newTitle = "Favourite TV Shows";
      favourites = authProvider.favouriteTvShows;
    } else {
      newTitle = "Favourite People";
      favourites = authProvider.favouritePeople;
    }

    try {
      final List<Media> res = await getMediaFromSaved(favourites);
      setState(() {
        title = newTitle;
        media = res;
      });
    } catch(err) {
      showErrorDialog(context, err.toString());
    }
  }

  // TODO: Pagination
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$title ${media == null ? '' : '(${media!.length})'}"),),
      body: media == null ?
      const LoadingSpinner() :
      ListView(
        children: [
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: [
              ActionChip(
                label: const Text("All"),
                onPressed: () => setMedia(),
              ),
              const SizedBox(width: 5,),
              ActionChip(
                label: const Text("Movies"),
                onPressed: () => setMedia(mediaType: MediaType.movie),
              ),
              const SizedBox(width: 5,),
              ActionChip(
                label: const Text("TV Shows"),
                onPressed: () => setMedia(mediaType: MediaType.tv),
              ),
              const SizedBox(width: 5,),
              ActionChip(
                label: const Text("People"),
                onPressed: () => setMedia(mediaType: MediaType.person),
              ),
            ],
          ),
          Wrap(
            direction: Axis.horizontal,
            children: [
              for (final Media element in media!) MediaCard(key: UniqueKey(), media: element),
            ],
          ),
        ],
      ),
    );
  }
}
