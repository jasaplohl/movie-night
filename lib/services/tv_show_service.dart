import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/models/episode_model.dart';
import 'package:movie_night/models/tv_show_model.dart';

import 'constants.dart';

Future<TvShowDetails> getTvShowDetails(int tvShowId) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final String url = "$apiRoot/tv/$tvShowId?append_to_response=videos";
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    return TvShowDetails.fromJson(body);
  } else {
    throw Exception(body["status_message"]);
  }
}

Future<List<Episode>> getEpisodes(int tvShowId, int seasonNumber) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final String url = "$apiRoot/tv/$tvShowId/season/$seasonNumber";
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    return (body["episodes"] as List<dynamic>).map((dynamic e) => Episode.fromJson(e)).toList();
  } else {
    throw Exception(body["status_message"]);
  }
}