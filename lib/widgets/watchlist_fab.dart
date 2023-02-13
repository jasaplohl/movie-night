import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/saved_media_model.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/utils/show_sign_in_dialog.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:provider/provider.dart';

class WatchlistFab extends StatefulWidget {
  final int mediaId;
  final MediaType mediaType;

  const WatchlistFab({
    Key? key,
    required this.mediaId,
    required this.mediaType,
  }) : super(key: key);

  @override
  State<WatchlistFab> createState() => _WatchlistFabState();
}

class _WatchlistFabState extends State<WatchlistFab> {

  bool loading = false;

  Future<void> onWatchlistTap() async {
    setState(() {
      loading = true;
    });
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    if(authProvider.user != null) {
      try {
        await authProvider.toggleWatchlist(widget.mediaId, widget.mediaType);
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
    return FloatingActionButton(
      onPressed: onWatchlistTap,
      backgroundColor: Theme.of(context).primaryColorLight,
      elevation: 10,
      child: loading ?
      const SizedBox(
        width: 12,
        height: 12,
        child: LoadingSpinner(accentColor: true),
      ) :
      Consumer<AuthProvider>(
        builder: (context, AuthProvider provider, child) {
          if(provider.user != null) {
            // TODO: Make get item an async function to not block the thread
            final SavedMedia? watchlistItem = provider.getWatchlistItem(widget.mediaId, widget.mediaType);
            if(watchlistItem != null) {
              return const Icon(
                Icons.bookmark,
                color: Colors.black,
              );
            }
          }
          return child!;
        },
        child: const Icon(Icons.bookmark_outline, color: Colors.black),
      ),
    );
  }
}