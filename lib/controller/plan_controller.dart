import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/plan_data_init.dart';
import 'globals.dart' as globals;

Future<PlanDataInit> createItin(
    String? name, int? budget, DateTime? startDate, DateTime? endDate) async {
      //print(startDate);
  final response = await http.post(
    Uri.parse('http://localhost:3000/itinerary/createitin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "Name": name,
      "startDate": startDate!.toIso8601String(),
      "endDate": endDate!.toIso8601String(),
      "initialBud": budget
    }),
  );

  var jsonResponse = json.decode(response.body)["message"];
  globals.createplan_id=jsonResponse["_id"];
  //print(globals.createplan_id);

  //print(response);

  if (response.statusCode == 200) {
    print("success");
    return PlanDataInit.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create itin.');
  }
}

Future<PlanDataInit> Addfriends(List<String> friends) async {
      //print(startDate);
  final response = await http.post(
    Uri.parse('http://localhost:3000/itinerary/addmembers'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "members": friends,
      "plan_id": globals.createplan_id,
      
    }),
  );

  //var jsonResponse = json.decode(response.body)["message"];
  //globals.createplan_id=jsonResponse["_id"];
  //print(jsonResponse["_id"]);

  //print(response);

  if (response.statusCode == 200) {
    print("success");
    return PlanDataInit.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create itin.');
  }
}
