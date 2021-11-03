import 'dart:convert';
import 'package:frontend_flutter/models/book_init.dart';
import 'package:frontend_flutter/models/location_data_initial.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;

Future<List<BookDataInit>> fetchBookmarks() async {
  //print("gajk");
  var url =
      Uri.parse("https://septravelplanner.herokuapp.com/user/getbookmarks");

  var response = await http.post(url, body: {"email": globals.currentUserEmail});
  print("bookmarked locations");
  print(response.body);
  List jsonResponse = json.decode(response.body)["message"];
  //print(jsonResponse);
  return jsonResponse
      .map((location) => new BookDataInit.fromJson(location))
      .toList();
}

Future addBookmark(String location_id) async {
  final response = await http.post(
    Uri.parse('https://septravelplanner.herokuapp.com/user/addbookmark'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "location_id": location_id,
      "email": globals.currentUserEmail,
    }),
  );

  if (response.statusCode == 200) {
    print("success");
    return "Sucess";
  } else {
    throw Exception('Failed to create bookmark.');
  }
}
