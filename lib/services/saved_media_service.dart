import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_night/enums/collection_enum.dart';
import 'package:movie_night/models/saved_media_model.dart';
import 'package:movie_night/enums/media_type_enum.dart';

final Map<Collection, CollectionReference> collections = {
  Collection.favourites: FirebaseFirestore.instance.collection("favourites"),
  Collection.watchlist: FirebaseFirestore.instance.collection("watchlist"),
  Collection.history: FirebaseFirestore.instance.collection("history"),
};

Future<List<SavedMedia>> getSaved(String uid, Collection collection) async {
  final QuerySnapshot<SavedMedia> res = await _getSavedFromFirestore(uid, collection);
  return res.docs.map((e) => e.data()).toList();
}

Future<SavedMedia> addToSaved(String uid, Collection collection, int mediaId, MediaType mediaType) async {
  SavedMedia favourite = SavedMedia(
      mediaId: mediaId,
      mediaType: mediaType,
      timestamp: DateTime.now(),
      uid: uid
  );

  final res = await collections[collection]!.add(favourite.toFirestore());
  favourite.documentId = res.id;
  return favourite;
}

Future<void> removeFromSaved(String documentId, Collection collection) async {
  await collections[collection]!
    .doc(documentId)
    .delete();
}

// Gets data from the specified collection
Future<QuerySnapshot<SavedMedia>> _getSavedFromFirestore(String uid, Collection collection) async {
  final res = await collections[collection]!
    .withConverter(
      fromFirestore: SavedMedia.fromFirestore,
      toFirestore: (SavedMedia value, options) => value.toFirestore(),
    )
    .where("userId", isEqualTo: uid)
    .get();

  return res;
}