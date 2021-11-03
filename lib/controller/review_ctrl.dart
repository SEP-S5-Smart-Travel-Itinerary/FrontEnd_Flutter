import 'dart:convert';

import 'package:frontend_flutter/models/review_data.dart';
import 'package:http/http.dart' as http;

Future<List<ReviewDataInit>> fetchReviews(String value) async {
  //print("gajk");
  var url =
      Uri.parse("https://septravelplanner.herokuapp.com/review/getreviews");

  var response = await http.post(url, body: {"loc_id": value});
  //print("bookmarked locations");
  print(response.body);
  List jsonResponse = json.decode(response.body)["message"];
  //print(jsonResponse);
  return jsonResponse
      .map((location) => new ReviewDataInit.fromJson(location))
      .toList();
}
