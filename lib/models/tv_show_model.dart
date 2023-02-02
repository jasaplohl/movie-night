import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/episode_model.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/models/network_model.dart';
import 'package:movie_night/models/season_model.dart';
import 'package:movie_night/models/video_model.dart';

class TvShowDetails {
  final String? backdropPath;
  final int? episodeRunTime;
  final String firstAirDate;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String lastAirDate;
  final String name;
  final Episode? nextEpisodeToAir;
  final Episode? lastEpisodeToAir;
  final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<dynamic> originCountry;
  final String originalLanguage;
  final String overview;
  final String? posterPath;
  final List<Season> seasons;
  final String status;
  final String? tagline;
  final String type;
  final num voteAverage;
  final int voteCount;
  final List<Video>? videos;

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
    required this.lastEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
    required this.videos,
  });

  factory TvShowDetails.fromJson(dynamic json) {
    final List<dynamic> runTime = json["episode_run_time"] ?? [];
    return TvShowDetails(
      backdropPath: json["backdrop_path"],
      episodeRunTime: runTime.isNotEmpty ? runTime[0] as int : null,
      firstAirDate: json["first_air_date"],
      genres: (json["genres"] as List<dynamic>).map((dynamic e) => Genre.fromJson(e, MediaType.tv)).toList(),
      homepage: json["homepage"],
      id: json["id"],
      lastAirDate: json["last_air_date"],
      name: json["name"],
      nextEpisodeToAir: json["next_episode_to_air"] != null ? Episode.fromJson(json["next_episode_to_air"]) : null,
      lastEpisodeToAir: json["last_episode_to_air"] != null ? Episode.fromJson(json["last_episode_to_air"]) : null,
      networks: (json["networks"] as List<dynamic>).map((dynamic e) => Network.fromJson(e)).toList(),
      numberOfEpisodes: json["number_of_episodes"],
      numberOfSeasons: json["number_of_seasons"],
      originCountry: json["origin_country"],
      originalLanguage: json["original_language"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      seasons: (json["seasons"] as List<dynamic>).map((dynamic e) => Season.fromJson(e)).toList(),
      status: json["status"],
      tagline: json["tagline"],
      type: json["type"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
      videos: json["videos"]["results"] != null ? (json["videos"]["results"] as List<dynamic>).map((dynamic e) => Video.fromJson(e),).toList() : null,
    );
  }
}