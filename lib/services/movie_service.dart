import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/models/movie_model.dart';

Future<List<Movie>> getPopularMovies({required int page}) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final String apiRoot = dotenv.env["API_ROOT"]!;
  final res = await http.get(Uri.parse("$apiRoot/movie/popular?page=$page"), headers: {
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