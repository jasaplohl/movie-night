import 'package:flutter/material.dart';
import 'package:movie_night/models/favourites_model.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/utils/media_type_enum.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/utils/show_sign_in_dialog.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:provider/provider.dart';

class AddToFavouritesButton extends StatefulWidget {
  final int id;
  final MediaType mediaType;

  const AddToFavouritesButton({
    Key? key,
    required this.id,
    required this.mediaType,
  }) : super(key: key);

  @override
  State<AddToFavouritesButton> createState() => _AddToFavouritesButtonState();
}

class _AddToFavouritesButtonState extends State<AddToFavouritesButton> {

  bool loading = false;

  Future<void> onFavouritesTap(BuildContext context) async {
    setState(() {
      loading = true;
    });
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    if(authProvider.user != null) {
      await _toggleFavourite(context, authProvider);
    } else {
      _signInPrompt(context);
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> _toggleFavourite(BuildContext context, AuthProvider authProvider) async {
    try {
      await authProvider.toggleFavourite(widget.id, widget.mediaType);
    } catch(err) {
      showErrorDialog(context, err.toString());
    }
  }

  void _signInPrompt(BuildContext context) {
    showSignInDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    if(loading) {
      return const IconButton(
        onPressed: null,
        icon: LoadingSpinner(),
      );
    } else {
      return IconButton(
            onPressed: () => onFavouritesTap(context),
            icon: Consumer<AuthProvider>(
              builder: (context, AuthProvider provider, child) {
                if(provider.user != null) {
                  final Favourite? fav = provider.getFavourite(widget.id, widget.mediaType);
                  if(fav != null) {
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
}
