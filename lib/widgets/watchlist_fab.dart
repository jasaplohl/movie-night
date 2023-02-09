import 'package:flutter/material.dart';

class WatchlistFab extends StatelessWidget {
  const WatchlistFab({Key? key}) : super(key: key);

  void addToWatchlist() {
    print("Adding to watchlist");
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: addToWatchlist,
      backgroundColor: Theme.of(context).primaryColorLight,
      elevation: 10,
      child: const Icon(Icons.bookmark_outline, color: Colors.black),
    );
  }
}
