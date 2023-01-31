class TvShow {
  final String? posterPath;
  final num popularity;
  final int id;
  final String? backdropPath;
  final num voteAverage;
  final String overview;
  final String firstAirDate;
  final List<String> originCountry;
  final List<int> genreIds;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;

  TvShow({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  factory TvShow.fromJson(dynamic json) {
    return TvShow(
      posterPath: json["poster_path"],
      popularity: json["popularity"],
      id: json["id"],
      backdropPath: json["backdrop_path"],
      voteAverage: json["vote_average"],
      overview: json["overview"],
      firstAirDate: json["first_air_date"],
      originCountry: json["origin_country"],
      genreIds: (json["genre_ids"] as List<dynamic>).map((dynamic genreId) => genreId as int).toList(),
      originalLanguage: json["original_language"],
      voteCount: json["vote_count"],
      name: json["name"],
      originalName: json["original_name"],
    );
  }
}