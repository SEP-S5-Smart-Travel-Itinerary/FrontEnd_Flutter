import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/plan_controller.dart';
import 'package:frontend_flutter/controller/user_controller.dart';
import 'package:frontend_flutter/screens/travel_plan_view.dart';
import 'package:frontend_flutter/widgets/reviews_view.dart';
import 'package:http/http.dart' as http;

class ChangePwd extends StatefulWidget {
  final String text;
  const ChangePwd({required this.text});
  @override
  _ChangePwdState createState() => _ChangePwdState();
}

class _ChangePwdState extends State<ChangePwd> {
  String _title = "";
  String _repwd = "";
  GlobalKey<FormState> _formkey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: Text('Change Password'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formkey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 30.0),

                Text(
                  'Change Password',
                  style: TextStyle(color: PrimaryColor),
                ),
                SizedBox(height: 5),

                // enter password
                TextFormField(
                  cursorColor: PrimaryColor,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                    filled: true,
                    fillColor: SecondayColorBlue,
                    labelText: 'Enter new password',
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
                  obscureText: true,
                  validator: (_val) {
                    if (_val == "") {
                      return "password cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (String? value) {
                    setState(() {
                      this._title = value!;
                    });
                  },
                ),

                const SizedBox(height: 20.0),

                // re -enter password
                Text(
                  'Re-enter Password',
                  style: TextStyle(color: PrimaryColor),
                ),
                SizedBox(height: 5),

                TextFormField(
                  cursorColor: PrimaryColor,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                    filled: true,
                    fillColor: SecondayColorBlue,
                    labelText: 'Re-enter password',
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
                  obscureText: true,
                  validator: (_val) {
                    if (_val == "") {
                      return "re-enter password cannot be empty";
                    } else if (_val != _title) {
                      return "password mismatch";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (String? value) {
                    setState(() {
                      this._repwd = value!;
                    });
                  },
                ),

                SizedBox(
                  height: 50,
                ),

                ElevatedButton(
                  onPressed: () {
                    if (_formkey2.currentState!.validate()) {
                      changePassword(_title).then((value) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePwd(
                                      text: "Password Changed Successfully"))));
                    } else {
                      print("not ok");
                    }
                  },
                  child: Container(
                      height: 50,
                      child: Center(
                          child: const Text(
                        'Change Password',
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
          ),
        ));
  }
}
