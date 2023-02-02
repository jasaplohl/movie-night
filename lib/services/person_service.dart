import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/models/person_model.dart';
import 'package:movie_night/services/constants.dart';

Future<List<Person>> getPopularPeople({int page = 1}) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final String url = "$apiRoot/person/popular?page=$page";
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    final List<dynamic> results = body["results"];
    return results.map((dynamic personJson) => Person.fromJson(personJson)).toList();
  } else {
    throw Exception(body["status_message"]);
  }
}