import 'package:flutter/material.dart';
import 'package:movie_night/enums/collection_enum.dart';

void showSnackbar(BuildContext context, Collection collectionType, bool add) {
  IconData icon;
  String message;
  if(collectionType == Collection.favourites) {
    icon = add ? Icons.favorite : Icons.favorite_outline;
    message = add ? "Added to favourites." : "Removed from favourites.";
  } else if(collectionType == Collection.watchlist) {
    icon = add ? Icons.bookmark : Icons.bookmark_outline;
    message = add ? "Added to watchlist." : "Removed from watchlist.";
  } else {
    icon = Icons.history;
    message = add ? "Added to history." : "Removed from history.";
  }
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 5,),
          Text(message),
        ],
      )
  ));
}