import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/plan_controller.dart';
import 'package:frontend_flutter/controller/user_controller.dart';
import 'package:frontend_flutter/screens/travel_plan_view.dart';
import 'package:frontend_flutter/widgets/reviews_view.dart';
import 'package:http/http.dart' as http;

class ChangeName extends StatefulWidget {
  final String text;
  const ChangeName({required this.text});
  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  String _title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: Text('Change User Name'),
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
                'Change User Name',
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
                  labelText: 'Add New username',
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

              

              SizedBox(
                height: 30,
              ),

              ElevatedButton(
                onPressed: () {
                  changeUsername(_title).then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangeName(text: "Successfully Changed"))));
                },
                child: Container(
                    height: 50,
                    child: Center(
                        child: const Text(
                      'Change Username',
                      style: TextStyle(fontSize: 18),
                    ))),
                style: ElevatedButton.styleFrom(
                  primary: PrimaryColor,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                widget.text,
                style: TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }

  
}
