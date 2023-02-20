import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/credit_model.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/models/video_model.dart';

class MovieDetails {
  final bool adult;
  final String? backdropPath;
  final int? collectionId;
  final int budget;
  final List<Genre> genres;
  final String? homePage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final num popularity;
  final String? posterPath;
  final List<dynamic> productionCountries;
  final String? releaseDate;
  final int revenue;
  final int? runtime;
  final List<dynamic> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final num voteAverage;
  final int voteCount;
  final List<Video> videos;
  final List<String>? backdropImages;
  final List<Credit> cast;
  final List<Credit> crew;
  final List<Media> recommendations;

  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.collectionId,
    required this.budget,
    required this.genres,
    required this.homePage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.videos,
    required this.backdropImages,
    required this.cast,
    required this.crew,
    required this.recommendations,
  });

  factory MovieDetails.fromJson(dynamic json) {
    return MovieDetails(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      collectionId: json["belongs_to_collection"] != null ? json["belongs_to_collection"]["id"] as int : null,
      budget: json["budget"],
      genres: (json["genres"] as List<dynamic>).map((dynamic genre) => Genre.fromJson(genre, MediaType.movie)).toList(),
      homePage: json["home_page"],
      id: json["id"],
      imdbId: json["imdb_id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"],
      posterPath: json["poster_path"],
      productionCountries: json["production_countries"],
      releaseDate: json["release_date"],
      revenue: json["revenue"],
      runtime: json["runtime"],
      spokenLanguages: json["spoken_languages"],
      status: json["status"],
      tagline: json["tagline"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
      videos: (json["videos"]["results"] as List<dynamic>).map((dynamic e) => Video.fromJson(e),).toList(),
      backdropImages: (json["images"]["backdrops"] as List<dynamic>).map((dynamic e) => e["file_path"].toString(),).toList(),
      cast: (json["credits"]["cast"] as List<dynamic>).map((dynamic e) => Credit.fromPersonJson(e),).toList(),
      crew: (json["credits"]["crew"] as List<dynamic>).map((dynamic e) => Credit.fromPersonJson(e),).toList(),
      recommendations: (json["recommendations"]["results"] as List<dynamic>).map((dynamic e) => Media.fromMovieJson(e),).toList(),
    );
  }
}