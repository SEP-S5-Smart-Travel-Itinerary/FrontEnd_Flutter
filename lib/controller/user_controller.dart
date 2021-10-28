import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/main_screen.dart';
import 'package:http/http.dart' as http;
import '../screens/user_preference_screen.dart';
import 'globals.dart' as globals;

Future addPreferences(cat, context) async {
  print(cat);
  final response = await http.post(
    Uri.parse('http://localhost:3000/user/addpreferences'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "email": globals.currentUser,
      "categories": cat,
    }),
  );

  if (response.statusCode == 200) {
    print("success");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  } else {
    throw Exception('Failed to update preferences.');
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

Future signUp(email, password, context) async {
  final split = email.split('@');
  final Map<int, String> values = {
    for (int i = 0; i < split.length; i++) i: split[i]
  };
  var uName = values[0];

  final response = await http.post(
    Uri.parse('http://localhost:3000/user/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({"username": uName, "email": email, "password": password}),
  );

  Map jsonResponse = json.decode(response.body);

  if (response.statusCode == 200) {
    if (jsonResponse["sucess"] == 1) {
      print("succesfully registered");
      print(jsonResponse["data"]["Email"]);
      globals.currentUser = jsonResponse["data"]["Email"];
      // print("gloabal user " + globals.currentUser);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserPreference()));
    } else {
      String jsonResponse = json.decode(response.body)["message"];
      print(jsonResponse);
      Fluttertoast.showToast(
          msg: jsonResponse,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: PrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  } else {
    Fluttertoast.showToast(
        msg: "Connection Error Occured. Try Again Later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: PrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
