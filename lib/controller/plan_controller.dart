import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/plan_data_init.dart';

Future<PlanDataInit> createItin(
    String? name, int? budget, DateTime? startDate, DateTime? endDate) async {
  final response = await http.post(
    Uri.parse('http://localhost:3001/itinerary/createitin'),
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

  if (response.statusCode == 200) {
    print("success");
    return PlanDataInit.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create itin.');
  }
}
