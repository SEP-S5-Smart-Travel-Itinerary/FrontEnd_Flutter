import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;

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
Future changeUsername(new_username) async {
 // print(cat);
  final response = await http.post(
    Uri.parse('http://localhost:3000/user/changeusername'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "email": "hashani@gmail.com",
      "new_username": new_username,
    }),
  );

  if (response.statusCode == 200) {
    print("success");
  } else {
    throw Exception('Failed to update username.');
  }
}
Future changePassword(new_password) async {
 // print(cat);
  final response = await http.post(
    Uri.parse('http://localhost:3000/user/changepassword'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "email": "hashani@gmail.com",
      "new_password": new_password,
    }),
  );

  if (response.statusCode == 200) {
    print("success");
  } else {
    throw Exception('Failed to update password.');
  }
}