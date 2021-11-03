import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/plan_controller.dart';
import 'package:frontend_flutter/screens/travel_plan_view.dart';
import 'package:http/http.dart' as http;

class AddReviews extends StatefulWidget {
  final String loc_id;
  const AddReviews({required this.loc_id});
  @override
  _AddReviewsState createState() => _AddReviewsState();
}

class _AddReviewsState extends State<AddReviews> {
  List<String> _friends = [];
  String _title = "anonymous";
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: Text('Add reviews'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 30.0),

              Text(
                'Add Reviews',
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
                  labelText: 'Add your name or you can leave this as anonymous',
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
                onChanged: (String? value) {
                  setState(() {
                    this._title = value!;
                  });
                },

                // validator: _validateName,
              ),
              SizedBox(
                height: 25.0,
              ),

              TextFormField(
                cursorColor: PrimaryColor,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                  filled: true,
                  fillColor: SecondayColorBlue,
                  labelText: 'Add Description',
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
                onChanged: (String? value) {
                  setState(() {
                    this._description = value;
                  });
                },

                // validator: _validateName,
              ),

              SizedBox(
                height: 30,
              ),

              ElevatedButton(
                onPressed: () {
                  addreview(_title, _description!, widget.loc_id);
                },
                child: Container(
                    height: 50,
                    child: Center(
                        child: const Text(
                      'Add Review',
                      style: TextStyle(fontSize: 18),
                    ))),
                style: ElevatedButton.styleFrom(
                  primary: PrimaryColor,
                ),
              ),
            ],
          ),
        ));
  }

  addreview(String title, String description, String location_id) async {
    var url =
        Uri.parse("https://septravelplanner.herokuapp.com/review/addreview");

    var response = await http.post(url, body: {
      "title": title,
      "description": description,
      "loc_id": location_id
    });
    print("sucess called");
    //List jsonResponse = json.decode(response.body)["data"];
    // print(jsonResponse);
  }
}
