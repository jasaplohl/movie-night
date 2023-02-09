import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_night/models/favourites_model.dart';
import 'package:movie_night/services/favourites_services.dart';
import 'package:movie_night/utils/media_type_enum.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  final Map<MediaType, Map<int, Favourite>> _favourites = {
    MediaType.movie: {},
    MediaType.tv: {},
    MediaType.person: {},
  };

  User? get user {
    return _user;
  }

  Favourite? getFavourite(int mediaId, MediaType mediaType) {
    return _favourites[mediaType]![mediaId];
  }

  Map<int, Favourite> get favouriteMovies {
    return _favourites[MediaType.movie]!;
  }

  Map<int, Favourite> get favouriteTvShows {
    return _favourites[MediaType.tv]!;
  }

  Map<int, Favourite> get favouritePeople {
    return _favourites[MediaType.person]!;
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
    final Favourite? favourite = _favourites[mediaType]?[mediaId];
    if(favourite != null) {
      await removeFromFavourites(favourite.documentId!);
      _favourites[mediaType]!.remove(mediaId);
    } else {
      final Favourite res = await addToFavourites(_user!.uid, mediaId, mediaType);
      _favourites[mediaType]![mediaId] = res;
    }
    notifyListeners();
  }

  Future<void> _setFavourites(String uid) async {
    _favourites[MediaType.movie] = await getFavouriteMovies(uid);
    _favourites[MediaType.tv] = await getFavouriteTvShows(uid);
    _favourites[MediaType.person] = await getFavouritePeople(uid);
  }

  void _clearFavourites() {
    _favourites[MediaType.movie] = {};
    _favourites[MediaType.tv] = {};
    _favourites[MediaType.person] = {};
  }
}