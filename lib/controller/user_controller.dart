import 'dart:convert';
import 'package:http/http.dart' as http;

Future addPreferences(cat) async {
  print(cat);
  final response = await http.post(
    Uri.parse('http://localhost:3000/user/addpreferences'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "email": "pasan@gmail.com",
      "categories": cat,
    }),
  );

  if (response.statusCode == 200) {
    print("success");
  } else {
    throw Exception('Failed to create itin.');
  }
}
