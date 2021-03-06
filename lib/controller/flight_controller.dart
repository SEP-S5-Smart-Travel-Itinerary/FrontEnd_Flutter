import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/flight_det.dart';

Future<FlightData> getFlightRates(
    String origin, String destination, String date, int adults) async {
  print("-------------flight function--------------");
  print(
      origin + " - " + destination + " - " + date + " - " + adults.toString());

  var url =
      Uri.parse("https://septravelplanner.herokuapp.com/apiuser/flightofffers");

  print(origin.substring(0, 3));
  print(destination.substring(0, 3));

  var response = await http.post(url, body: {
    "origin": origin.substring(0, 3),
    "destination": destination.substring(0, 3),
    "date": date,
    "adults": adults.toString()
  });
  if (response.statusCode == 200) {
    final Map jsonResponse = json.decode(response.body)["data"][0]["price"];

    return FlightData.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load jobs from API');
  }
}
