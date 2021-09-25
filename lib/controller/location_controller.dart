import 'dart:convert';
import '../models/location_data_initial.dart';
import 'package:http/http.dart' as http;

// fetch nearby locations
Future<List<LocationDataInit>> fetchNearbyLocations() async {
  print("connected to the server");

  var url = Uri.parse("http://localhost:3000/apiuser/nearbyattractions");

  var response = await http
      .post(url, body: {"latitude": "6.053519", "longitude": "80.220978"});
  if (response.statusCode == 200) {
    // print(response.body);
    // print("sucess called");
    List jsonResponse = json.decode(response.body)["data"];
    // print(jsonResponse);
    return jsonResponse
        .map((location) => new LocationDataInit.fromJson(location))
        .toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

// fetch details of a location
Future<List<LocationDataInit>> fetchDetailsofLocations(String placeId) async {
  print("connected to the server");
  print(placeId);

  var url = Uri.parse("http://localhost:3000/apiuser/details");

  var response =
      await http.post(url, body: {"place_id": "ChIJY_qDpIV54ToRJ7hkWrfzwAw"});
  print(response.body);
  if (response.statusCode == 200) {
    // print(response.body);
    // print("sucess called");
    List jsonResponse = json.decode(response.body)["data"];
    //print(jsonResponse);
    return jsonResponse
        .map((location) => new LocationDataInit.fromJson(location))
        .toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}
