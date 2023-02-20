import 'package:flutter/material.dart';
import 'package:movie_night/models/saved_media_model.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/enums/media_type_enum.dart';
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

  Future<void> onFavouritesTap() async {
    setState(() {
      loading = true;
    });
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    if(authProvider.user != null) {
      try {
        await authProvider.toggleFavourite(widget.id, widget.mediaType, context);
      } catch(err) {
        showErrorDialog(context, err.toString());
      }
    } else {
      showSignInDialog(context);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(loading) {
      return const IconButton(
        onPressed: null,
        icon: SizedBox(
          width: 12,
          height: 12,
          child: LoadingSpinner(),
        ),
      );
    } else {
      return IconButton(
        onPressed: onFavouritesTap,
        icon: Consumer<AuthProvider>(
          builder: (context, AuthProvider provider, child) {
            if(provider.user != null) {
              // TODO: Make get item an async function to not block the thread
              final SavedMedia? fav = provider.getFavouritesItem(widget.id, widget.mediaType);
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
