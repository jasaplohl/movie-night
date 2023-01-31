import 'package:movie_night/enums/media_type_enum.dart';
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
    return MediaRes(
      page: json["page"],
      results: (json["results"] as List<dynamic>).map((dynamic movie) => Media.fromJson(movie, mediaType)).toList(),
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }
}