import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';

class Collection {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final List<Media>? parts;

  Collection({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.parts,
  });

  factory Collection.fromJson(dynamic json) {
    return Collection(
        id: json["id"],
        name: json["name"],
        posterPath: json["poster_path"],
        overview: json["overview"],
        backdropPath: json["backdrop_path"],
        parts: (json["parts"] as List<dynamic>).map((dynamic movie) => Media.fromJson(movie, MediaType.movie)).toList(),
    );
  }
}