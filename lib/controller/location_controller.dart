import 'dart:convert';
import '../models/location_data_initial.dart';
import 'package:http/http.dart' as http;

Future<List<LocationDataInit>> fetchNearbyLocations() async {
  var url = Uri.parse("http://localhost:3000/apiuser/nearbyattractions");

  var response = await http
      .post(url, body: {"latitude": "6.053519", "longitude": "80.220978"});
  if (response.statusCode == 200) {
    print("sucess called");
    //print(response.body);
    List jsonResponse = json.decode(response.body)["data"];
    //print(jsonResponse);
    return jsonResponse
        .map((location) => new LocationDataInit.fromJson(location))
        .toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}


