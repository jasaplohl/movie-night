import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/models/saved_media_model.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/services/media_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/media_card.dart';
import 'package:provider/provider.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {

  String title = "Watchlist";
  List<Media>? media;

  @override
  void didChangeDependencies() {
    setMedia();
    super.didChangeDependencies();
  }

  Future<void> setMedia({MediaType? mediaType}) async {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

    String newTitle;
    final List<SavedMedia> watchlistItems;
    if(mediaType == null) {
      newTitle = "Watchlist";
      watchlistItems = authProvider.watchlist;
    } else if(mediaType == MediaType.movie) {
      newTitle = "Watchlist Movies";
      watchlistItems = authProvider.watchlistMovies;
    } else {
      newTitle = "Watchlist TV Shows";
      watchlistItems = authProvider.watchlistTvShows;
    }

    try {
      final List<Media> res = await getMediaFromSaved(watchlistItems);
      setState(() {
        title = newTitle;
        media = res;
      });
    } catch(err) {
      showErrorDialog(context, err.toString());
    }
  }

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
