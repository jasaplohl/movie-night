import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/models/movie_details_model.dart';
import 'package:movie_night/models/movie_model.dart';

const apiRoot = "https://api.themoviedb.org/3";

Future<List<Movie>> getPopularMovies({int page = 1}) async {
  return await _getMovies("$apiRoot/movie/popular?page=$page");
}

Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
  return await _getMovies("$apiRoot/movie/top_rated?page=$page");
}

Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
  return await _getMovies("$apiRoot/movie/upcoming?page=$page");
}

String getImageUrl(String imageName) {
  String url = "https://image.tmdb.org/t/p/w200/$imageName";
  return url;
}

String getBackdropUrl(String imageName) {
  String url = "https://image.tmdb.org/t/p/w500/$imageName";
  return url;
}

Future<MovieDetails> getMovieDetails(int movieId) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;

  final String url = "$apiRoot/movie/$movieId?append_to_response=videos";
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    return MovieDetails.fromJson(body);
  } else {
    throw Exception(body["status_message"]);
  }
}

Future<List<Movie>> _getMovies(String url) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    final List<dynamic> results = body["results"];
    return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
  } else {
    throw Exception(body["status_message"]);
  }
}