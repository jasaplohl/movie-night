import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/enums/collection_enum.dart';
import 'package:movie_night/models/saved_media_model.dart';
import 'package:movie_night/services/saved_media_service.dart';
import 'package:movie_night/utils/constants.dart';
import 'package:movie_night/enums/media_type_enum.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  List<SavedMedia> _favourites = [];
  List<SavedMedia> _watchlist = [];
  List<SavedMedia> _history = [];

  Future<void> setUser(User? user) async {
    _user = user;
    if(user == null) {
      _clearFavourites();
      _clearWatchlist();
      _clearHistory();
    } else {
      final List<Future<void>> futuresArray = [
        _setFavourites(user.uid),
        _setWatchlist(user.uid),
        _setHistory(user.uid),
      ];
      await Future.wait(futuresArray);
    }
    notifyListeners();
  }

  Future<void> _setFavourites(String uid) async {
    _favourites = await getSaved(uid, Collection.favourites);
  }

  Future<void> _setWatchlist(String uid) async {
    _watchlist = await getSaved(uid, Collection.watchlist);
  }

  Future<void> _setHistory(String uid) async {
    _history = await getSaved(uid, Collection.history);
  }

  void _clearFavourites() {
    _favourites.clear();
  }

  void _clearWatchlist() {
    _watchlist.clear();
  }

  void _clearHistory() {
    _history.clear();
  }

  User? get user {
    return _user;
  }

  SavedMedia? getFavouritesItem(int mediaId, MediaType mediaType) {
    return _favourites.firstWhereOrNull((SavedMedia e) => e.mediaId == mediaId && e.mediaType == mediaType);
  }

  SavedMedia? getWatchlistItem(int mediaId, MediaType mediaType) {
    return _watchlist.firstWhereOrNull((SavedMedia e) => e.mediaId == mediaId && e.mediaType == mediaType);
  }

  SavedMedia? getHistoryItem(int mediaId, MediaType mediaType) {
    return _history.firstWhereOrNull((SavedMedia e) => e.mediaId == mediaId && e.mediaType == mediaType);
  }

  List<SavedMedia> get favourites {
    return _favourites;
  }

  List<SavedMedia> get watchlist {
    return _watchlist;
  }

  List<SavedMedia> get history {
    return _history;
  }

  List<SavedMedia> get latestFavourites {
    final int start = _favourites.length < itemsPerPageLg ? 0 : _favourites.length - itemsPerPageLg;
    return _favourites
        .sortedBy((SavedMedia e) => e.timestamp)
        .toList()
        .sublist(start, _favourites.length);
  }

  List<SavedMedia> get favouriteMovies {
    return _favourites
        .where((SavedMedia e) => e.mediaType == MediaType.movie)
        .sortedBy((SavedMedia e) => e.timestamp)
        .reversed
        .toList();
  }

  List<SavedMedia> get favouriteTvShows {
    return _favourites
        .where((SavedMedia e) => e.mediaType == MediaType.tv)
        .sortedBy((SavedMedia e) => e.timestamp)
        .reversed
        .toList();
  }

  List<SavedMedia> get favouritePeople {
    return _favourites
        .where((SavedMedia e) => e.mediaType == MediaType.person)
        .sortedBy((SavedMedia e) => e.timestamp)
        .reversed
        .toList();
  }

  Future<void> toggleFavourite(int mediaId, MediaType mediaType) async {
    final SavedMedia? favourite = getFavouritesItem(mediaId, mediaType);
    if(favourite != null) {
      await removeFromSaved(favourite.documentId!, Collection.favourites);
      _favourites.removeWhere((e) => e.mediaId == mediaId && e.mediaType == mediaType);
    } else {
      final SavedMedia res = await addToSaved(_user!.uid, Collection.favourites, mediaId, mediaType);
      _favourites.add(res);
    }
    notifyListeners();
  }

  Future<void> toggleWatchlist(int mediaId, MediaType mediaType) async {
    final SavedMedia? watchlistItem = getWatchlistItem(mediaId, mediaType);
    if(watchlistItem != null) {
      await removeFromSaved(watchlistItem.documentId!, Collection.watchlist);
      _watchlist.removeWhere((e) => e.mediaId == mediaId && e.mediaType == mediaType);
    } else {
      final SavedMedia res = await addToSaved(_user!.uid, Collection.watchlist, mediaId, mediaType);
      _watchlist.add(res);
    }
    notifyListeners();
  }

  Future<void> toggleHistory(int mediaId, MediaType mediaType) async {
    final SavedMedia? historyItem = getHistoryItem(mediaId, mediaType);
    if(historyItem != null) {
      await removeFromSaved(historyItem.documentId!, Collection.history);
      _history.removeWhere((e) => e.mediaId == mediaId && e.mediaType == mediaType);
    } else {
      final SavedMedia res = await addToSaved(_user!.uid, Collection.history, mediaId, mediaType);
      _history.add(res);
    }
    notifyListeners();
  }
}