class Season {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final int episodeCount;
  final String? airDate;
  
  Season({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodeCount,
    required this.airDate,
  });
  
  factory Season.fromJson(dynamic json) {
    return Season(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        episodeCount: json["episode_count"],
        airDate: json["air_date"],
    );
  }
}