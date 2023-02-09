import 'package:flutter/material.dart';
import 'package:movie_night/services/watchlist_service.dart';
import 'package:movie_night/utils/media_type_enum.dart';

class WatchlistFab extends StatelessWidget {
  final int id;
  final MediaType mediaType;

  const WatchlistFab({
    Key? key,
    required this.id,
    required this.mediaType,
  }) : super(key: key);

  void onWatchlistTap(BuildContext context) {
    addToWatchList(id, mediaType, context);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onWatchlistTap(context),
      backgroundColor: Theme.of(context).primaryColorLight,
      elevation: 10,
      child: const Icon(Icons.bookmark_outline, color: Colors.black),
    );
  }
}
