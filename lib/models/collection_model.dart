import 'package:movie_night/models/movie_model.dart';
import 'package:movie_night/services/common_services.dart';

class Collection {
  final int id;
  final String name;
  final String overview;
  final List<Movie> parts;

  Collection({
    required this.id,
    required this.name,
    required this.overview,
    required this.parts,
  });

  factory Collection.fromJson(dynamic json) {
    return Collection(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        parts: cast<List<Movie>>(json["parts"].map((movie) => Movie.fromJson(movie)).toList())!,
    );
  }
}