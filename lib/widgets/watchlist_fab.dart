import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/utils/show_sign_in_dialog.dart';
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

  Future<void> onWatchlistTap() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onWatchlistTap,
      backgroundColor: Theme.of(context).primaryColorLight,
      elevation: 10,
      child: const Icon(Icons.bookmark_outline, color: Colors.black),
    );
  }
}