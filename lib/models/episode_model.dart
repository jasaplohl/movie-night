class Episode {
  final int id;
  final String name;
  final String? airDate;
  final int episodeNumber;
  final int seasonNumber;
  final String overview;
  final String? stillPath;
  final num voteAverage;
  final int voteCount;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episodeNumber,
    required this.seasonNumber,
    required this.overview,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Episode.fromJson(dynamic json) {
    return Episode(
      id: json["id"],
      name: json["name"],
      airDate: json["air_date"],
      episodeNumber: json["episode_number"],
      seasonNumber: json["season_number"],
      overview: json["overview"],
      stillPath: json["still_path"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
    );
  }
}