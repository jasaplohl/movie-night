import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/models/collection_model.dart';
import 'package:movie_night/models/movie_details_model.dart';

import 'constants.dart';

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
