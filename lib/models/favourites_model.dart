import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_night/utils/media_type_enum.dart';

class Favourite {
  String? documentId;
  final int mediaId;
  final MediaType mediaType;
  final DateTime timestamp;
  final String uid;

  Favourite({
    this.documentId,
    required this.mediaId,
    required this.mediaType,
    required this.timestamp,
    required this.uid,
  });

  factory Favourite.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options
  ) {
    final data = snapshot.data();
    return Favourite(
      documentId: snapshot.id,
      mediaId: data?["mediaId"],
      mediaType: MediaType.values.byName(data?["mediaType"]),
      timestamp: DateTime.fromMillisecondsSinceEpoch(data?["timestamp"]),
      uid: data?["userId"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "mediaId": mediaId,
      "mediaType": mediaType.name,
      "timestamp": timestamp.millisecondsSinceEpoch,
      "userId": uid,
    };
  }
}