import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/models/favourites_model.dart';
import 'package:movie_night/services/favourites_services.dart';
import 'package:movie_night/utils/constants.dart';
import 'package:movie_night/utils/media_type_enum.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  List<Favourite> _favourites = [];

  User? get user {
    return _user;
  }

  Favourite? getFavourite(int mediaId, MediaType mediaType) {
    return _favourites.firstWhereOrNull((Favourite e) => e.mediaId == mediaId && e.mediaType == mediaType);
  }

  List<Favourite> get favourites {
    return _favourites;
  }

  List<Favourite> get latestFavourites {
    final int start = _favourites.length < itemsPerPageLg ? 0 : _favourites.length - itemsPerPageLg;
    return _favourites.sublist(start, _favourites.length);
  }

  List<Favourite> get favouriteMovies {
    return _favourites.where((Favourite e) => e.mediaType == MediaType.movie).toList();
  }

  List<Favourite> get favouriteTvShows {
    return _favourites.where((Favourite e) => e.mediaType == MediaType.tv).toList();
  }

  List<Favourite> get favouritePeople {
    return _favourites.where((Favourite e) => e.mediaType == MediaType.person).toList();
  }

  int get favouriteMoviesLength {
    return favouriteMovies.length;
  }

  int get favouriteTvShowsLength {
    return favouriteTvShows.length;
  }

  int get favouritePeopleLength {
    return favouritePeople.length;
  }

  Future<void> setUser(User? user) async {
    _user = user;
    if(user == null) {
      _clearFavourites();
    } else {
      await _setFavourites(user.uid);
    }
    notifyListeners();
  }

  Future<void> toggleFavourite(int mediaId, MediaType mediaType) async {
    final Favourite? favourite = getFavourite(mediaId, mediaType);
    if(favourite != null) {
      await removeFromFavourites(favourite.documentId!);
      _favourites.removeWhere((e) => e.mediaId == mediaId && e.mediaType == mediaType);
    } else {
      final Favourite res = await addToFavourites(_user!.uid, mediaId, mediaType);
      _favourites.add(res);
    }
    notifyListeners();
  }

  Future<void> _setFavourites(String uid) async {
    _favourites = await getFavourites(uid);
  }

  void _clearFavourites() {
    _favourites = [];
  }
}