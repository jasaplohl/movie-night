import 'package:flutter/material.dart';
import 'package:movie_night/enums/collection_enum.dart';

class SuccessSnackBar extends StatelessWidget {
  final Collection collectionType;

  const SuccessSnackBar({
    Key? key,
    required this.collectionType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String message;
    if(collectionType == Collection.favourites) {
      icon = Icons.favorite;
      message = "Added to favourites";
    } else if(collectionType == Collection.watchlist) {
      icon = Icons.bookmark;
      message = "Added to watchlist";
    } else {
      icon = Icons.history;
      message = "Added to history";
    }
    return SnackBar(
      content: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5,),
          Text(message),
        ],
      )
    );
  }
}
