import 'package:movie_night/enums/media_type_enum.dart';

class Media {
  final int id;
  final String title;
  final num voteAverage;
  final String? posterPath;
  final MediaType type;

  Media({
    required this.id,
    required this.title,
    required this.voteAverage,
    required this.posterPath,
    required this.type,
  });

  factory Media.fromJson(dynamic json, MediaType mediaType) {
    return Media(
        id: json["id"],
        // movie - title, tv show - name
        title: json["title"] ?? json["name"],
        voteAverage: json["vote_average"],
        posterPath: json["poster_path"],
        type: mediaType
    );
  }
}