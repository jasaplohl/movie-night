import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/models/movie_model.dart';

Future<List<Movie>> getPopularMovies({int page = 1}) async {
  final String apiRoot = dotenv.env["API_ROOT"]!;
  return await _getMovies("$apiRoot/movie/popular?page=$page");
}

Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
  final String apiRoot = dotenv.env["API_ROOT"]!;
  return await _getMovies("$apiRoot/movie/top_rated?page=$page");
}

Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
  final String apiRoot = dotenv.env["API_ROOT"]!;
  return await _getMovies("$apiRoot/movie/upcoming?page=$page");
}

String getImageUrl(String imageName) {
  String url = "https://image.tmdb.org/t/p/w200/$imageName";
  return url;
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