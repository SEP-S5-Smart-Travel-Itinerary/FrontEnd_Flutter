import 'dart:convert';
import '../models/location_data_initial.dart';
import '../models/location_data.dart';
import 'package:http/http.dart' as http;

// fetch nearby locations
Future<List<LocationDataInit>> fetchNearbyAttractions() async {
  var url = Uri.parse(
      "https://septravelplanner.herokuapp.com/apiuser/nearbyattractions");

  var response = await http
      .post(url, body: {"latitude": "6.053519", "longitude": "80.220978"});
  if (response.statusCode == 200) {
    print("sucess called");
    List jsonResponse = json.decode(response.body)["data"];
    print(jsonResponse[0]['imagelink'][0]['photo_reference']);
    return jsonResponse
        .map((location) => new LocationDataInit.fromJson(location))
        .toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}
//--------------------------------------------------------------------------------------

Future<List<LocationDataInit>> fetchNearbyRestaurants() async {
  var url = Uri.parse(
      "https://septravelplanner.herokuapp.com/apiuser/nearbyrestaurants");

  var response = await http
      .post(url, body: {"latitude": "6.053519", "longitude": "80.220978"});
  if (response.statusCode == 200) {
    print("sucess called");
    List jsonResponse = json.decode(response.body)["data"];
    print(jsonResponse);
    return jsonResponse
        .map((location) => new LocationDataInit.fromJson(location))
        .toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

//---------------------------------------------------------------------------------------
Future<List<LocationDataInit>> fetchNearbyAccommodations() async {
  var url = Uri.parse(
      "https://septravelplanner.herokuapp.com/apiuser/nearbyaccommodations");

  var response = await http
      .post(url, body: {"latitude": "6.053519", "longitude": "80.220978"});
  if (response.statusCode == 200) {
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

//---------------------------------------------------------------------------------------
//nearby locations with good ratings
Future<List<LocationDataInit>> fetchSuggestions() async {
  var url = Uri.parse(
      "https://septravelplanner.herokuapp.com/apiuser/suggestedlocations");

  var response = await http
      .post(url, body: {"latitude": "6.053519", "longitude": "80.220978"});
  if (response.statusCode == 200) {
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

//---------------------------------------------------------------------------------------
//fetch attractions by user preference
Future<List<LocationDataInit>> fetchAttractionsByCategory() async {
  var url = Uri.parse(
      "https://septravelplanner.herokuapp.com/apiuser/locationsbycategory");

  var response = await http.post(url, body: {
    "latitude": "6.053519",
    "longitude": "80.220978",
    "type": "natural_feature"
  });
  if (response.statusCode == 200) {
    print("sucess called");
    List jsonResponse = json.decode(response.body)["data"];
    // print("---------------recommended locations--------------");
    // print(jsonResponse);
    return jsonResponse
        .map((location) => new LocationDataInit.fromJson(location))
        .toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

//---------------------------------------------------------------------------------------------------
//get travel mode between two locations
Future<String> fetchTravelmode() async {
  var url =
      Uri.parse("https://septravelplanner.herokuapp.com/apiuser/travelmode");
  var response = await http.post(url, body: {
    "originlatitude": "40.6655101",
    "originlongitude": "-73.89188969999998",
    "destinationlatitude": "40.659569",
    "destinationlongitude": "-73.933783"
  });
  if (response.statusCode == 200) {
    print("sucess called");
    String jsonResponse = json.decode(response.body)["data"];
    return jsonResponse;
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

//----------------------------------------------------------------------------------------------
//get taxi fare between two locations
Future<double> fetchTaxiFare() async {
  var url =
      Uri.parse("https://septravelplanner.herokuapp.com/apiuser/gettaxifare");
  var response = await http.post(url, body: {
    "originlatitude": "40.6655101",
    "originlongitude": "-73.89188969999998",
    "destinationlatitude": "40.659569",
    "destinationlongitude": "-73.933783"
  });
  if (response.statusCode == 200) {
    print("sucess called");
    double jsonResponse = json.decode(response.body)["data"];
    return jsonResponse;
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

//--------------------------------------------------------------------------
// fetch details of a location
Future fetchDetailsofLocations(String placeId) async {
  print("connected to the server");
  print(placeId);

  var url = Uri.parse("https://septravelplanner.herokuapp.com/apiuser/details");

  var response = await http.post(url, body: {"place_id": placeId});
  // print(response.body);
  if (response.statusCode == 200) {
    // print(response.body);
    // print("sucess called");
    final Map jsonResponse = json.decode(response.body)["data"];
    print("----------------------------------------");
    // print(jsonResponse);
    return LocationData.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load location details from API');
  }
}

Future<List<LocationDataInit>> fetchLocations(String? name) async {
  var url =
      Uri.parse("https://septravelplanner.herokuapp.com/apiuser/locations");

  var response = await http.post(url, body: {"place": name});
  if (response.statusCode == 200) {
    print("sucess called");
    List jsonResponse = json.decode(response.body)["data"];
    // print(jsonResponse);
    return jsonResponse
        .map((location) => new LocationDataInit.fromJson(location))
        .toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}
