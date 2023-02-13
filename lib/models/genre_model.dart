import 'package:movie_night/enums/media_type_enum.dart';

class Genre {
  final int id;
  final String name;
  final MediaType type;

  Genre({
    required this.id,
    required this.name,
    required this.type,
  });

  factory Genre.fromJson(dynamic json, MediaType genreType) {
    return Genre(
      id: json["id"],
      name: json["name"],
      type: genreType,
    );
  }
}