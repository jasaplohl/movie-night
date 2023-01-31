import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/models/tv_show_model.dart';

import 'constants.dart';

Future<List<TvShow>> getPopularTvShows({int page = 1}) async {
  return await _getTvShows("$apiRoot/tv/popular?page=$page");
}

Future<List<TvShow>> _getTvShows(String url) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    final List<dynamic> results = body["results"];
    return results.map((tvJson) => TvShow.fromJson(tvJson)).toList();
  } else {
    throw Exception(body["status_message"]);
  }
}