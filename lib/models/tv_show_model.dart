import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/episode_model.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/models/production_company_model.dart';
import 'package:movie_night/models/season_model.dart';

class TvShowDetails {
  final String? backdropPath;
  final int episodeRunTime;
  final String firstAirDate;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String lastAirDate;
  final String name;
  final Episode? nextEpisodeToAir;
  final dynamic networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<dynamic> originCountry;
  final String originalLanguage;
  final String overview;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<Season> seasons;
  final String status;
  final String? tagline;
  final String type;
  final num voteAverage;
  final int voteCount;

  TvShowDetails({
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.lastAirDate,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.productionCompanies,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvShowDetails.fromJson(dynamic json) {
    return TvShowDetails(
      backdropPath: json["backdrop_path"],
      episodeRunTime: (json["episode_run_time"] as List<dynamic>)[0] as int,
      firstAirDate: json["first_air_date"],
      genres: (json["genres"] as List<dynamic>).map((dynamic e) => Genre.fromJson(e, MediaType.tv)).toList(),
      homepage: json["homepage"],
      id: json["id"],
      lastAirDate: json["last_air_date"],
      name: json["name"],
      nextEpisodeToAir: json["next_episode_to_air"] != null ? Episode.fromJson(json["next_episode_to_air"]) : null,
      networks: json["networks"],
      numberOfEpisodes: json["number_of_episodes"],
      numberOfSeasons: json["number_of_seasons"],
      originCountry: json["origin_country"],
      originalLanguage: json["original_language"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      productionCompanies: (json["production_companies"] as List<dynamic>).map((dynamic e) => ProductionCompany.fromJson(e)).toList(),
      seasons: (json["seasons"] as List<dynamic>).map((dynamic e) => Season.fromJson(e)).toList(),
      status: json["status"],
      tagline: json["tagline"],
      type: json["type"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
    );
  }
}