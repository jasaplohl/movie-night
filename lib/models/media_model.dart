import 'package:movie_night/utils/media_type_enum.dart';

class Media {
  final int id;
  final String title;
  final num? voteAverage;
  final String? posterPath;
  final String? knownForDepartment;
  final MediaType type;

  Media({
    required this.id,
    required this.title,
    required this.voteAverage, // Only for movies and TV shows
    required this.posterPath,
    required this.knownForDepartment, // Only for people
    required this.type,
  });

  factory Media.fromMovieJson(dynamic json) {
    return Media(
        id: json["id"],
        title: json["title"],
        voteAverage: json["vote_average"],
        posterPath: json["poster_path"],
        knownForDepartment: null,
        type: MediaType.movie
    );
  }

  factory Media.fromTVJson(dynamic json) {
    return Media(
      id: json["id"],
      title: json["name"],
      voteAverage: json["vote_average"],
      posterPath: json["poster_path"],
      knownForDepartment: null,
      type: MediaType.tv,
    );
  }

  factory Media.fromPersonJson(dynamic json) {
    return Media(
      id: json["id"],
      title: json["name"],
      voteAverage: null,
      posterPath: json["profile_path"],
      knownForDepartment: json["known_for_department"],
      type: MediaType.person,
    );
  }
}