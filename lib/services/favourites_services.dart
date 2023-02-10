import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_night/models/favourites_model.dart';
import 'package:movie_night/utils/media_type_enum.dart';

final collection = FirebaseFirestore.instance.collection("favourites");

Future<List<Favourite>> getFavourites(String uid) async {
  final QuerySnapshot<Favourite> res = await _getFavouritesFromFirestore(uid);
  return res.docs.map((e) => e.data()).toList();
}

Map<int, Favourite> snapshotToMap(QuerySnapshot<Favourite> res) {
  final Map<int, Favourite> favouritesMap = {};
  for (var e in res.docs) {
    final Favourite favourite = e.data();
    favouritesMap[favourite.mediaId] = favourite;
  }
  return favouritesMap;
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

Future<QuerySnapshot<Favourite>> _getFavouritesFromFirestore(String uid) async {
  final res = await collection
    .withConverter(
      fromFirestore: Favourite.fromFirestore,
      toFirestore: (Favourite value, options) => value.toFirestore(),
    )
    .where("userId", isEqualTo: uid)
    .get();

  return res;
}