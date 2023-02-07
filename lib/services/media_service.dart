import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/utils/media_type_enum.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/models/media_res_model.dart';

import '../utils/constants.dart';

Future<List<Media>> getPopular({int page = 1, required MediaType mediaType}) async {
  if(mediaType == MediaType.movie) {
    return await _getMedia("$apiRoot/movie/popular?page=$page", mediaType);
  } else if(mediaType == MediaType.tv) {
    return await _getMedia("$apiRoot/tv/popular?page=$page", mediaType);
  } else {
    return await _getMedia("$apiRoot/person/popular?page=$page", mediaType);
  }
}

Future<List<Media>> getTopRated({int page = 1, required MediaType mediaType}) async {
  if(mediaType == MediaType.movie) {
    return await _getMedia("$apiRoot/movie/top_rated?page=$page", mediaType);
  } else if(mediaType == MediaType.tv) {
    return await _getMedia("$apiRoot/tv/top_rated?page=$page", mediaType);
  } else {
    throw Exception("Can not get top rated people.");
  }
}

Future<List<Media>> getTrendingDaily(MediaType mediaType) async {
  if(mediaType == MediaType.movie) {
    return await _getMedia("$apiRoot/trending/movie/day", mediaType);
  } else if (mediaType == MediaType.tv){
    return await _getMedia("$apiRoot/trending/tv/day", mediaType);
  } else {
    throw Exception("Can not get daily trending people.");
  }
}

Future<List<Media>> getTrendingWeekly(MediaType mediaType) async {
  if(mediaType == MediaType.movie) {
    return await _getMedia("$apiRoot/trending/movie/week", mediaType);
  } else if(mediaType == MediaType.tv) {
    return await _getMedia("$apiRoot/trending/tv/week", mediaType);
  } else {
    throw Exception("Can not get weekly trending people.");
  }
}

// TODO: Include adult - toggle if the user is adult
Future<MediaRes> search(String query, int page, MediaType mediaType) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;

  String url;
  if(mediaType == MediaType.movie) {
    url = "$apiRoot/search/movie?query=$query&page=$page&include_adult=false";
  } else if(mediaType == MediaType.tv) {
    url = "$apiRoot/search/tv?query=$query&page=$page";
  } else {
    url = "$apiRoot/search/person?query=$query&page=$page";
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
    if(mediaType == MediaType.movie) {
      return results.map((dynamic movieJson) => Media.fromMovieJson(movieJson)).toList();
    } else if(mediaType == MediaType.tv) {
      return results.map((dynamic tvJson) => Media.fromTVJson(tvJson)).toList();
    } else {
      return results.map((dynamic personJson) => Media.fromPersonJson(personJson)).toList();
    }
  } else {
    throw Exception(body["status_message"]);
  }
}