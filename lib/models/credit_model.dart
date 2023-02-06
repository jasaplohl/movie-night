import 'package:movie_night/enums/media_type_enum.dart';

class Credit {
  final String? title; // Or name
  final String? posterPath;
  final MediaType mediaType;
  final int mediaId;
  final num? voteAverage;
  final String? character;
  final String? job;

  Credit({
    required this.title,
    required this.posterPath,
    required this.mediaType,
    required this.mediaId,
    required this.voteAverage,
    required this.character,
    required this.job,
  });

  factory Credit.fromJson(dynamic json) {
    String typeString = json["media_type"];
    MediaType type;
    if(typeString == "movie") {
      type = MediaType.movie;
    } else if(typeString == "tv") {
      type = MediaType.tv;
    } else {
      throw Exception("Invalid media type. $typeString");
    }

    return Credit(
      mediaId: json["id"],
      title: type == MediaType.movie ? json["title"]: json["name"],
      posterPath: json["poster_path"],
      voteAverage: json["vote_average"],
      mediaType: type,
      character: json["character"],
      job: json["job"],
    );
  }

  factory Credit.fromPersonJson(dynamic json) {
    return Credit(
      title: json["name"],
      mediaId: json["id"],
      mediaType: MediaType.person,
      character: json["character"],
      voteAverage: null,
      posterPath: json["profile_path"],
      job: json["job"],
    );
  }
}