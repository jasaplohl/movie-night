import 'package:movie_night/utils/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';

class MediaRes {
  final int page;
  final List<Media> results;
  final int totalPages;
  final int totalResults;

  MediaRes({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MediaRes.fromJson(dynamic json, MediaType mediaType) {
    List<Media> mediaRes;
    if(mediaType == MediaType.movie) {
      mediaRes = (json["results"] as List<dynamic>).map((dynamic movie) => Media.fromMovieJson(movie)).toList();
    } else if(mediaType == MediaType.tv) {
      mediaRes = (json["results"] as List<dynamic>).map((dynamic tv) => Media.fromTVJson(tv)).toList();
    } else {
      mediaRes = (json["results"] as List<dynamic>).map((dynamic person) => Media.fromPersonJson(person)).toList();
    }
    return MediaRes(
      page: json["page"],
      results: mediaRes,
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }
}