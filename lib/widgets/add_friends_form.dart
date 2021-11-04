import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/plan_controller.dart';
import 'package:frontend_flutter/screens/travel_plan_view.dart';
import 'package:http/http.dart' as http;
import 'package:frontend_flutter/controller/globals.dart' as globals;

class AddFriendsDialog extends StatefulWidget {
  final String text;
  const AddFriendsDialog({required this.text});
  @override
  _AddFriendsDialogState createState() => _AddFriendsDialogState();
}

class _AddFriendsDialogState extends State<AddFriendsDialog> {
  List<String> _friends = [];
  String? _name;
  bool result = false;
  bool result2 = false;
  String touser = "";
  GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: Text('Plan a new trip'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formkey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 30.0),
          
                Text(
                  'Add Trip Mates',
                  style: TextStyle(color: PrimaryColor),
                ),
                SizedBox(height: 5),
          
                // Add countries
                TextFormField(
                  cursorColor: PrimaryColor,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                    filled: true,
                    fillColor: SecondayColorBlue,
                    labelText: 'Add Trip Mates',
                    labelStyle: TextStyle(color: PrimaryColor),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      borderSide: BorderSide(color: PrimaryColor, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      borderSide: BorderSide(color: PrimaryColor, width: 2),
                    ),
                  ),
                  validator: (_val) {
                    if (_val == "") {
                      return "Email can't be Empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (String? value) {
                    setState(() {
                      this._name = value;
                    });
                  },
          
                  // validator: _validateName,
                ),
          
                SizedBox(
                  height: 30,
                ),
          
                ElevatedButton(
                  onPressed: () {
                    if (_formkey1.currentState!.validate()) {
                    _friends.add(_name!);
                    print(_friends);
                    print(widget.text);
                    //Addfriends(_friends);
                    userSearch(_name!).then((value) => {
                          if (result)
                            {
                              memberSearch(_name!).then((value) => {
                                    if (result2)
                                      {
                                        Addfriends(_friends),
                                        //touserText("Successfully Added").then((value) =>
                                        Navigator.pushReplacement(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    AddFriendsDialog(
                                                        text:
                                                            "Successfully Added")))
                                      }
                                    else
                                      {
                                        Navigator.pushReplacement(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    AddFriendsDialog(
                                                        text:
                                                            "Input user is alreay exist in the plan")))
                                      }
                                  })
                            }
                          else
                            {
                              //touserText("Input user haven't Registerd Star Trips").then((value) =>
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => AddFriendsDialog(
                                          text:
                                              "Input user haven't Registerd Star Trips")))
                            }
                        });
                        } else {
                      print("not ok");
                    }
                    //print(result);
                  },
                  child: Container(
                      height: 50,
                      child: Center(
                          child: const Text(
                        'Add Trip Mates',
                        style: TextStyle(fontSize: 18),
                      ))),
                  style: ElevatedButton.styleFrom(
                    primary: PrimaryColor,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      getPalnDetails().then((value) => Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => TravelPlanView())));
                      //             Navigator.push(
                      // context, new MaterialPageRoute(builder: (context) => TravelPlanView()));
                    },
                    child: Text(
                      'Go to the Plan',
                      style: TextStyle(color: PrimaryColor),
                    )),
          
                Text(
                  widget.text,
                  style: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }

  userSearch(String value) async {
    var url =
        Uri.parse("https://septravelplanner.herokuapp.com/user/SearchUser");

    var response = await http.post(url, body: {"username": value});
    print("sucess called");
    //List jsonResponse = json.decode(response.body)["data"];
    // print(jsonResponse);

    result = json.decode(response.body)["success"];
    //print (result);
  }

  memberSearch(String value) async {
    var url = Uri.parse(
        "https://septravelplanner.herokuapp.com/itinerary/searchmembers");

    var response = await http
        .post(url, body: {"plan_id": globals.createplan_id, "username": value});
    print("sucess called");
    //List jsonResponse = json.decode(response.body)["data"];
    // print(jsonResponse);

    result2 = json.decode(response.body)["success"];
    //print (result);
  }
}
