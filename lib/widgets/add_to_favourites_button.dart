import 'package:flutter/material.dart';
import 'package:movie_night/services/favourites_services.dart';
import 'package:movie_night/utils/media_type_enum.dart';

class AddToFavouritesButton extends StatelessWidget {
  final int id;
  final MediaType mediaType;

  const AddToFavouritesButton({
    Key? key,
    required this.id,
    required this.mediaType,
  }) : super(key: key);

  void onFavouritesTap() {
    toggleFavourite(id, mediaType);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onFavouritesTap,
        icon: const Icon(Icons.favorite_outline, color: Colors.red,)
    );
  }
}
