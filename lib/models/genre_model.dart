enum GenreType {
  movie,
  tv
}

class Genre {
  final int id;
  final String name;
  final GenreType type;

  Genre({
    required this.id,
    required this.name,
    required this.type,
  });

  factory Genre.fromJson(dynamic json, GenreType genreType) {
    return Genre(
      id: json["id"],
      name: json["name"],
      type: genreType,
    );
  }
}