import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/collection_model.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/models/movie_details_model.dart';
import 'package:movie_night/models/media_res_model.dart';

import 'constants.dart';

Future<List<Media>> getPopularMovies({int page = 1}) async {
  return await _getMovies("$apiRoot/movie/popular?page=$page");
}

Future<List<Media>> getTopRatedMovies({int page = 1}) async {
  return await _getMovies("$apiRoot/movie/top_rated?page=$page");
}

Future<List<Media>> getTrendingMoviesDaily() async {
  return await _getMovies("$apiRoot/trending/movie/day");
}

Future<List<Media>> getTrendingMoviesWeekly() async {
  return await _getMovies("$apiRoot/trending/movie/week");
}

Future<List<Media>> _getMovies(String url) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    final List<dynamic> results = body["results"];
    return results.map((movieJson) => Media.fromJson(movieJson, MediaType.movie)).toList();
  } else {
    throw Exception(body["status_message"]);
  }
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

Future<Collection> getCollection(int collectionId) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final String url = "$apiRoot/collection/$collectionId";
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    return Collection.fromJson(body);
  } else {
    throw Exception(body["status_message"]);
  }
}

// TODO: Include adult?
Future<MediaRes> searchMovies(String query, int page) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final url = "$apiRoot/search/movie?query=$query&page=$page";
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    return MediaRes.fromJson(body, MediaType.movie);
  } else {
    throw Exception(body["status_message"]);
  }
}