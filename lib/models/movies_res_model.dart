import 'package:movie_night/models/movie_model.dart';

class MovieRes {
  final int page;
  final List<Movie> results;
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
      results: (json["results"] as List<dynamic>).map((dynamic movie) => Movie.fromJson(movie)).toList(),
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }
}