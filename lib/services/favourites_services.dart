import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_night/models/favourites_model.dart';
import 'package:movie_night/utils/media_type_enum.dart';

final collection = FirebaseFirestore.instance.collection("favourites");

Future<Map<int, Favourite>> getFavouriteMovies(String uid) async {
  final QuerySnapshot<Favourite> res = await _getFavourites(uid, MediaType.movie);
  return snapshotToMap(res);
}

Future<Map<int, Favourite>> getFavouriteTvShows(String uid) async {
  final QuerySnapshot<Favourite> res = await _getFavourites(uid, MediaType.tv);
  return snapshotToMap(res);
}

Future<Map<int, Favourite>> getFavouritePeople(String uid) async {
  final QuerySnapshot<Favourite> res = await _getFavourites(uid, MediaType.person);
  return snapshotToMap(res);
}

Future<Favourite> addToFavourites(String uid, int mediaId, MediaType mediaType) async {
  Favourite favourite = Favourite(
      mediaId: mediaId,
      mediaType: mediaType,
      timestamp: DateTime.now(),
      uid: uid
  );

  final res = await collection.add(favourite.toFirestore());
  favourite.documentId = res.id;
  return favourite;
}

Future<void> removeFromFavourites(String documentId) async {
  await collection
      .doc(documentId)
      .delete();
}

Future<QuerySnapshot<Favourite>> _getFavourites(String uid, MediaType mediaType) async {
  final res = await collection
      .withConverter(
    fromFirestore: Favourite.fromFirestore,
    toFirestore: (Favourite value, options) => value.toFirestore(),
  )
      .where("userId", isEqualTo: uid)
      .where("mediaType", isEqualTo: mediaType.name)
      .get();

  return res;
}

Map<int, Favourite> snapshotToMap(QuerySnapshot<Favourite> res) {
  final Map<int, Favourite> favouritesMap = {};
  for (var e in res.docs) {
    final Favourite favourite = e.data();
    favouritesMap[favourite.mediaId] = favourite;
  }
  return favouritesMap;
}