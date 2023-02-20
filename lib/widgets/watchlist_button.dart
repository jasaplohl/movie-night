import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/saved_media_model.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/utils/show_sign_in_dialog.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:provider/provider.dart';

class WatchlistButton extends StatefulWidget {
  final int mediaId;
  final MediaType mediaType;

  const WatchlistButton({
    Key? key,
    required this.mediaId,
    required this.mediaType,
  }) : super(key: key);

  @override
  State<WatchlistButton> createState() => _WatchlistButtonState();
}

class _WatchlistButtonState extends State<WatchlistButton> {

  bool loading = false;

  Future<void> onWatchListTap() async {
    setState(() {
      loading = true;
    });
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    if(authProvider.user != null) {
      try {
        await authProvider.toggleWatchlist(widget.mediaId, widget.mediaType, context);
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
    return TextButton(
      onPressed: onWatchListTap,
      style: TextButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.5),
        shape: const CircleBorder(),
      ),
      child: loading ?
      const SizedBox(
        width: 12,
        height: 12,
        child: LoadingSpinner(),
      ) :
      Consumer<AuthProvider>(
        builder: (context, AuthProvider provider, child) {
          if(provider.user != null) {
            // TODO: Make get item an async function to not block the thread
            final SavedMedia? watchListItem = provider.getWatchlistItem(widget.mediaId, widget.mediaType);
            if(watchListItem != null) {
              return Icon(
                Icons.bookmark,
                color: Theme.of(context).primaryColorLight,
              );
            }
          }
          return child!;
        },
        child: Icon(
          Icons.bookmark_outline,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }
}
