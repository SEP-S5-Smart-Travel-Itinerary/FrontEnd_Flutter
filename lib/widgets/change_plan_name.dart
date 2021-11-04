import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/plan_controller.dart';
import 'package:frontend_flutter/screens/travel_plan_view.dart';
import '../controller/globals.dart' as globals;

class ChangePlanName extends StatefulWidget {
  final String text;
  const ChangePlanName({required this.text});
  @override
  _ChangePlanNameState createState() => _ChangePlanNameState();
}

class _ChangePlanNameState extends State<ChangePlanName> {
  String? _name = "";
  GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: Text('Change Plan Name'),
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
                  'Change Plan Name',
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
                    labelText: 'Enter new plan name',
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
                      return "plan name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (String? value) {
                    setState(() {
                      this._name = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 25.0,
                ),

                SizedBox(
                  height: 30,
                ),

                ElevatedButton(
                  onPressed: () {
                    if (_formkey1.currentState!.validate()) {
                      changeName(_name, globals.createplan_id).then((value) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TravelPlanView())));
                    } else {
                      print("not ok");
                    }
                  },
                  child: Container(
                      height: 50,
                      child: Center(
                          child: const Text(
                        'Change Plan Name',
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
