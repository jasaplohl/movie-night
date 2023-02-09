import 'package:flutter/material.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/utils/media_type_enum.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/utils/show_sign_in_dialog.dart';
import 'package:provider/provider.dart';

class AddToFavouritesButton extends StatelessWidget {
  final int id;
  final MediaType mediaType;

  const AddToFavouritesButton({
    Key? key,
    required this.id,
    required this.mediaType,
  }) : super(key: key);

  void onFavouritesTap(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    if(authProvider.user != null) {
      _toggleFavourite(context, authProvider);
    } else {
      _signInPrompt(context);
    }
  }

  void _toggleFavourite(BuildContext context, AuthProvider authProvider) {
    try {
      authProvider.toggleFavourite(id, mediaType);
    } catch(err) {
      showErrorDialog(context, err.toString());
    }
  }

  void _signInPrompt(BuildContext context) {
    showSignInDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onFavouritesTap(context),
        icon: Consumer<AuthProvider>(
          builder: (context, AuthProvider provider, child) {
            if(provider.user != null) {
              if(provider.getFavourite(id, mediaType) != null) {
                return const Icon(
                  Icons.favorite,
                  color: Colors.red,
                );
              }
            }
            return child!;
          },
          child: const Icon(
            Icons.favorite_outline,
            color: Colors.red,
          ),
        )
    );
  }
}
