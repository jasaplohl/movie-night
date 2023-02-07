import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_night/models/person_details_model.dart';
import 'package:movie_night/utils/constants.dart';

Future<PersonDetails> getPersonDetails(int personId) async {
  final String accessToken = dotenv.env["API_ACCESS_TOKEN"]!;
  final String url = "$apiRoot/person/$personId?append_to_response=combined_credits,images";
  final res = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $accessToken"
  });
  final dynamic body = jsonDecode(res.body);
  if(res.statusCode == 200) {
    return PersonDetails.fromJson(body);
  } else {
    throw Exception(body["status_message"]);
  }
}