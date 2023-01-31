import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';

class MovieRes {
  final int page;
  final List<Media> results;
  final int totalPages;
  final int totalResults;

  MovieRes({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieRes.fromJson(dynamic json) {
    return MovieRes(
      page: json["page"],
      results: (json["results"] as List<dynamic>).map((dynamic movie) => Media.fromJson(movie, MediaType.movie)).toList(),
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }
}