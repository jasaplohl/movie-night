import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/genre_model.dart';
import 'package:movie_night/models/movies_res_model.dart';
import 'package:movie_night/services/constants.dart';

Future<List<Genre>> getMovieGenres() async {
  return await _getGenres("$apiRoot/genre/movie/list", MediaType.movie);
}

Future<List<Genre>> getTvShowGenres() async {
  return await _getGenres("$apiRoot/genre/tv/list", MediaType.tv);
}

Future<List<Genre>> _getGenres(String url, MediaType genreType) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    return (body["genres"] as List<dynamic>).map((dynamic bodyJson) => Genre.fromJson(bodyJson, genreType)).toList();
  } else {
    throw Exception(body["status_message"]);
  }
}

Future<MovieRes> getMoviesByGenre(int genreId, int page, String sortBy) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final url = "$apiRoot/discover/movie?with_genres=$genreId&page=$page&sort_by=$sortBy";
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    return MovieRes.fromJson(body);
  } else {
    throw Exception(body["status_message"]);
  }
}