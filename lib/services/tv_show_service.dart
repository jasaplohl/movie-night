import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';

import 'constants.dart';

Future<List<Media>> getPopularTvShows({int page = 1}) async {
  return await _getTvShows("$apiRoot/tv/popular?page=$page");
}

Future<List<Media>> getTopRatedTvShows({int page = 1}) async {
  return await _getTvShows("$apiRoot/tv/top_rated?page=$page");
}

Future<List<Media>> getTrendingTvShowsDaily() async {
  return await _getTvShows("$apiRoot/trending/tv/day");
}

Future<List<Media>> getTrendingTvShowsWeekly() async {
  return await _getTvShows("$apiRoot/trending/tv/week");
}

Future<List<Media>> _getTvShows(String url) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    final List<dynamic> results = body["results"];
    return results.map((tvJson) => Media.fromJson(tvJson, MediaType.tv)).toList();
  } else {
    throw Exception(body["status_message"]);
  }
}