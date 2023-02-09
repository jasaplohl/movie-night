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

  void onFavouritesTap(BuildContext context) {
    toggleFavourite(id, mediaType, context);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onFavouritesTap(context),
        icon: const Icon(Icons.favorite_outline, color: Colors.red,)
    );
  }
}
