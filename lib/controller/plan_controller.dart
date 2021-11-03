import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/book_init.dart';
import 'package:frontend_flutter/models/location_data.dart';
import 'package:frontend_flutter/models/location_data_initial.dart';
import 'package:frontend_flutter/models/plandetail_init.dart';
import 'package:frontend_flutter/models/plann_data.dart';
import 'package:frontend_flutter/widgets/add_friends_form.dart';
import 'package:frontend_flutter/widgets/logo.dart';
import 'package:http/http.dart' as http;

import '../models/plan_data_init.dart';
import 'globals.dart' as globals;
import 'package:intl/intl.dart';
import '../services/local_notification_manager.dart';

NotificationService _notificationService = NotificationService();

Future<PlanDataInit> createItin(
    String? name, int? budget, DateTime? startDate, DateTime? endDate) async {
  //print(startDate);

  var newDate = new DateTime(
      startDate!.year, startDate.month, startDate.day, startDate.hour - 6);
  print(newDate);

  await _notificationService.scheduleNotifications(
      title: name,
      body: "Schedule trip begins tomorrow",
      time: DateTime.parse(newDate.toString()));

  final response = await http.post(
    Uri.parse('https://septravelplanner.herokuapp.com/itinerary/createitin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "Name": name,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate!.toIso8601String(),
      "initialBud": budget
    }),
  );

  var jsonResponse = json.decode(response.body)["message"];
  globals.createplan_id = jsonResponse["_id"];

//adding planing person
  var addfds = await http.post(
    Uri.parse('https://septravelplanner.herokuapp.com/itinerary/addmembers'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "members": [globals.currentUserEmail],
      "plan_id": globals.createplan_id,
    }),
  );
  //getPalnDetails(globals.createplan_id);
  //print(globals.createplan_id);

  //print(response);

  if (response.statusCode == 200) {
    print("success");
    return PlanDataInit.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create itin.');
  }
}

Future Addfriends(List<String> friends) async {
  //     print(friends[0]);
  //     var search = await http.post(
  //   Uri.parse('http://localhost:3000/user/searchUser'),
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode({
  //     "email": friends[0],

  //   }),
  // );

  // if (search.statusCode == 200) {
  print("success");
  final response = await http.post(
    Uri.parse('https://septravelplanner.herokuapp.com/itinerary/addmembers'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "members": friends,
      "plan_id": globals.createplan_id,
    }),
  );

  if (response.statusCode == 200) {
    print("success");
    //return PlanDataInit.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create itin.');
  }
  // } else {
  //   print("fail");
  //   throw Exception('Failed to create itin.');
  // //   Widget build(BuildContext context) {
  // //   return Material(
  // //       color: Colors.transparent,
  // //       child: Text(
  // //           "Input Member haven't Registered to Star Trips",
  // //           style: TextStyle(
  // //             fontFamily: 'custom font', // remove this if don't have custom font
  // //             fontSize: 20.0, // text size
  // //             color: Colors.red, // text color
  // //           ),
  // //       ),
  // //     );
  // // }
  // }
}

Future<List<PlanDetailInit>> getPalns() async {
  //print("gajk");
  var url =
      Uri.parse("https://septravelplanner.herokuapp.com/itinerary/getallitin");

  var response =
      await http.post(url, body: {"user_id": globals.currentUserEmail});
  //print(response.body);
  List jsonResponse = json.decode(response.body)["message"];
  //print(jsonResponse);
  return jsonResponse
      .map((location) => new PlanDetailInit.fromJson(location))
      .toList();
}

Future getPalnDetails() async {
  //print("gajk");
  var url =
      Uri.parse("https://septravelplanner.herokuapp.com/itinerary/alldetails");

  var response = await http.post(url, body: {"plan_id": globals.createplan_id});
  //print(response.body);
  var jsonResponse = json.decode(response.body)["message"];
  globals.InitialBudget = jsonResponse["InitialBudget"];
  globals.TotalBudget = jsonResponse["TotalBudget"];
  globals.Locations = jsonResponse["Locations"];
  globals.Name = jsonResponse["Name"];
  globals.Transport = jsonResponse["Transport"];
  globals.TripMates = jsonResponse["TripMates"];
  globals.StartDate = DateTime.parse(jsonResponse["StartDate"]);
  globals.EndDate = DateTime.parse(jsonResponse["EndDate"]);
  print(globals.InitialBudget);
  print(globals.TotalBudget);
  print(globals.Locations);
  print(globals.Name);
  print(globals.Transport);
  print(globals.TripMates);
  print(globals.StartDate);
  print(globals.EndDate);

  DateFormat dateFormat = DateFormat("MM/dd");
  globals.startdatestring = dateFormat.format(globals.StartDate);
  globals.enddatestring = dateFormat.format(globals.EndDate);
  print(globals.startdatestring);
  print(globals.enddatestring);
}

Future changeName(String? new_name, String? plan_id) async {
  //print("gajk");
  var url = Uri.parse(
      "https://septravelplanner.herokuapp.com/itinerary/changeplanname");

  var response =
      await http.post(url, body: {"new_name": new_name, "plan_id": plan_id});
  //print(response.body);
  globals.Name = new_name!;
}

//------------------------------------------------------------------------------------
//delete plan
Future deletePlan(String? plan_id) async {
  var url =
      Uri.parse("https://septravelplanner.herokuapp.com/itinerary/deleteitin");

  var response = await http.post(url, body: {"plan_id": plan_id});

  globals.Name = "This Plan has been Deleted";
}

//-------------------------------------------------------------------------------------------------
//edit budget
Future editBudget(int? new_budget, String? plan_id) async {
  print(new_budget);
  //var url = Uri.parse("http://localhost:3000/itinerary/editbudget");

  // var response = await http
  //     .post(url, body: {"new_budget": new_budget,"plan_id":plan_id});
  //print(response.body);
  final response = await http.post(
    Uri.parse('https://septravelplanner.herokuapp.com/itinerary/editbudget'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "new_budget": new_budget,
      "plan_id": plan_id,
    }),
  );
  print("hjhjA");
  globals.InitialBudget = new_budget!;
}

//--------------------------------------------------------------------------------
Future changeDates(
    String? plan_id, DateTime? newstartDate, DateTime? newendDate) async {
  var url =
      Uri.parse("https://septravelplanner.herokuapp.com/itinerary/changedates");

  var response = await http.post(url, body: {
    "plan_id": plan_id,
    "startDate": newstartDate!.toIso8601String(),
    "endDate": newendDate!.toIso8601String()
  });

  globals.StartDate = newstartDate;
  globals.EndDate = newendDate;
  DateFormat dateFormat = DateFormat("MM/dd");
  globals.startdatestring = dateFormat.format(globals.StartDate);
  globals.enddatestring = dateFormat.format(globals.EndDate);
  //print(globals.EndDate);
}

Future<LocationData> getLocationdetails(String place_id) async {
  var url = Uri.parse("https://septravelplanner.herokuapp.com/apiuser/details");

  var response =
      await http.post(url, body: {"place_id": "ChIJQ9yCmWtZ4joRNu1evW41NTo"});
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

Future<List<PlannDataInit>> fetchPlanLocationList() async {
  //print("gajk");
  var url = Uri.parse(
      "https://septravelplanner.herokuapp.com/itinerary/planlocations");

  var response = await http.post(url, body: {"plan_id": globals.createplan_id});
  //print(response.body);
  List jsonResponse = json.decode(response.body)["message"];
  //print(jsonResponse);
  return jsonResponse
      .map((location) => new PlannDataInit.fromJson(location))
      .toList();
}
