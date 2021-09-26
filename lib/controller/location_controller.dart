import 'dart:convert';
import '../models/location_data_initial.dart';
import '../models/location_data.dart';
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

    return jsonResponse
        .map((location) => new LocationDataInit.fromJson(location))
        .toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

// fetch details of a location
Future fetchDetailsofLocations(String placeId) async {
  print("connected to the server");
  print(placeId);

  var url = Uri.parse("http://localhost:3000/apiuser/details");

  var response = await http.post(url, body: {"place_id": placeId});
  // print(response.body);
  if (response.statusCode == 200) {
    // print(response.body);
    // print("sucess called");
    final Map jsonResponse = json.decode(response.body)["data"];
    print("----------------------------------------");
    print(jsonResponse[0]["imagelink"][0]["html_attributions"][0]);
    return LocationData.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load location details from API');
  }
}
