import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/utils/show_sign_in_dialog.dart';
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

  Future<void> onWatchListTap() async {
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
    return TextButton(
      onPressed: onWatchListTap,
      style: TextButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.5),
        shape: const CircleBorder(),
      ),
      // TODO: loading spinner
      child: Icon(Icons.bookmark_outline, color: Theme.of(context).primaryColorLight),
    );
  }
}
