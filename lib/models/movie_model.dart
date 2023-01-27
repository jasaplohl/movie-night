class Movie {
  final int id;
  final String originalTitle;
  final String title;
  final num voteAverage;
  final String releaseDate;
  final String? overview;
  final bool adult;
  final String? posterPath;
  final List<dynamic> genreIds;

  Movie({
    required this.id,
    required this.originalTitle,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.adult,
    this.posterPath,
    required this.genreIds
  });

  factory Movie.fromJson(dynamic json) {
    return Movie(
        id: json["id"],
        originalTitle: json["original_title"],
        title: json["title"],
        voteAverage: json["vote_average"],
        releaseDate: json["release_date"],
        overview: json["overview"],
        adult: json["adult"],
        posterPath: json["poster_path"],
        genreIds: json["genre_ids"]
    );
  }
}