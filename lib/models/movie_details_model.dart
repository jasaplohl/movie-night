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
  final String? tagline;
  final List<dynamic>? videos;

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
    this.tagline,
    this.videos
  });

  factory MovieDetails.fromJson(dynamic json) {
    return MovieDetails(
      id: json["id"],
      originalTitle: json["original_title"],
      title: json["title"],
      voteAverage: json["vote_average"],
      releaseDate: json["release_date"],
      tagline: json["tagline"],
      overview: json["overview"],
      adult: json["adult"],
      belongsToCollection: json["belongs_to_collection"],
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"],
      genres: json["genres"],
      homePage: json["homepage"],
      originalLanguage: json["original_language"],
      videos: json["videos"]["results"]
    );
  }
}