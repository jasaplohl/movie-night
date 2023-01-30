class Movie {
  final String? posterPath;
  final bool adult;
  final String overview;
  final String releaseDate;
  final List<num> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final num popularity;
  final num voteCount;
  final bool video;
  final num voteAverage;

  Movie({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });

  factory Movie.fromJson(dynamic json) {
    return Movie(
      posterPath: json["poster_path"],
      adult: json["adult"],
      overview: json["overview"],
      releaseDate: json["release_date"],
      genreIds: (json["genre_ids"] as List<dynamic>).map((dynamic genreId) => genreId as num).toList(),
      id: json["id"],
      originalTitle: json["original_title"],
      originalLanguage: json["original_language"],
      title: json["title"],
      backdropPath: json["backdrop_path"],
      popularity: json["popularity"],
      voteCount: json["vote_count"],
      video: json["video"],
      voteAverage: json["vote_average"],
    );
  }
}