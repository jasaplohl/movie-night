class MovieDetails {
  final int id;
  final String originalTitle;
  final String title;
  final num voteAverage;
  final String releaseDate;
  final String? overview;
  final bool adult;
  final dynamic belongsToCollection;
  final String? posterPath;
  final String? backdropPath;
  final dynamic genres;
  final String? homePage;
  final String originalLanguage;

  MovieDetails({
    required this.id,
    required this.originalTitle,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.adult,
    this.belongsToCollection,
    this.posterPath,
    this.backdropPath,
    this.genres,
    this.homePage,
    required this.originalLanguage,
  });

  factory MovieDetails.fromJson(dynamic json) {
    // TODO:
    return MovieDetails(
      id: json["id"],
      originalTitle: json["id"],
      title: json["id"],
      voteAverage: json["id"],
      releaseDate: json["id"],
      overview: json["id"],
      adult: json["id"],
      belongsToCollection: json["id"],
      posterPath: json["id"],
      backdropPath: json["id"],
      genres: json["id"],
      homePage: json["id"],
      originalLanguage: json["id"],
    );
  }
}