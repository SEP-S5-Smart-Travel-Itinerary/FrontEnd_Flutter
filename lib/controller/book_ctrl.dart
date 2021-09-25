import 'dart:convert';
import 'package:frontend_flutter/models/book_init.dart';
import 'package:frontend_flutter/models/location_data_initial.dart';
import 'package:http/http.dart' as http;

Future<List<BookDataInit>> fetchBookmarks() async {
  //print("gajk");
  var url = Uri.parse("http://localhost:3000/user/getbookmarks");

  var response = await http
      .post(url, body: {"email": "malithi_abc@gmail.com"});
    //print(response.body);
    List jsonResponse = json.decode(response.body)["message"];
    //print(jsonResponse);
    return jsonResponse
        .map((location) => new BookDataInit.fromJson(location))
        .toList();
  
}