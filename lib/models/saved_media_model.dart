import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_night/enums/media_type_enum.dart';

class SavedMedia {
  String? documentId;
  final int mediaId;
  final MediaType mediaType;
  final DateTime timestamp;
  final String uid;

  SavedMedia({
    this.documentId,
    required this.mediaId,
    required this.mediaType,
    required this.timestamp,
    required this.uid,
  });

  factory SavedMedia.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options
  ) {
    final data = snapshot.data();
    return SavedMedia(
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