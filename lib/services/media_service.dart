import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/models/media_res_model.dart';

import 'constants.dart';

Future<List<Media>> getPopular({int page = 1, required MediaType mediaType}) async {
  if(mediaType == MediaType.movie) {
    return await _getMedia("$apiRoot/movie/popular?page=$page", mediaType);
  } else {
    return await _getMedia("$apiRoot/tv/popular?page=$page", mediaType);
  }
}

Future<List<Media>> getTopRated({int page = 1, required MediaType mediaType}) async {
  if(mediaType == MediaType.movie) {
    return await _getMedia("$apiRoot/movie/top_rated?page=$page", mediaType);
  } else {
    return await _getMedia("$apiRoot/tv/top_rated?page=$page", mediaType);
  }
}

Future<List<Media>> getTrendingDaily(MediaType mediaType) async {
  if(mediaType == MediaType.movie) {
    return await _getMedia("$apiRoot/trending/movie/day", mediaType);
  } else {
    return await _getMedia("$apiRoot/trending/tv/day", mediaType);
  }
}

Future<List<Media>> getTrendingWeekly(MediaType mediaType) async {
  if(mediaType == MediaType.movie) {
    return await _getMedia("$apiRoot/trending/movie/week", mediaType);
  } else {
    return await _getMedia("$apiRoot/trending/tv/week", mediaType);
  }
}

// TODO: Include adult?
Future<MediaRes> search(String query, int page, MediaType mediaType) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;

  String url;
  if(mediaType == MediaType.movie) {
    url = "$apiRoot/search/movie?query=$query&page=$page";
  } else {
    url = "$apiRoot/search/tv?query=$query&page=$page";
  }

  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    return MediaRes.fromJson(body, mediaType);
  } else {
    throw Exception(body["status_message"]);
  }
}

Future<List<Media>> _getMedia(String url, MediaType mediaType) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    final List<dynamic> results = body["results"];
    return results.map((movieJson) => Media.fromJson(movieJson, mediaType)).toList();
  } else {
    throw Exception(body["status_message"]);
  }
}