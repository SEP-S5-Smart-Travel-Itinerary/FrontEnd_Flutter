import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/services.dart';
import '../controller/plan_controller.dart';
import 'add_friends_form.dart';

class FullScreenDialog extends StatefulWidget {
  @override
  _FullScreenDialogState createState() => _FullScreenDialogState();
}

class _FullScreenDialogState extends State<FullScreenDialog> {
  String? _name;
  int? _budget;
  DateTime? _startDate;
  DateTime? _endDate;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 30.0),
                // Name texfield
                Text(
                  'Name the tour',
                  style: TextStyle(color: PrimaryColor),
                ),
                SizedBox(height: 5),
                TextFormField(
                  cursorColor: PrimaryColor,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.trip_origin),
                    filled: true,
                    fillColor: SecondayColorBlue,
                    labelText: 'Trip Name',
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
                      return "Name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (String? value) {
                    setState(() {
                      this._name = value;
                    });
                  },
                ),

                const SizedBox(height: 24.0),

                // date range
                Text(
                  'Select the dates of the trip',
                  style: TextStyle(color: PrimaryColor),
                ),

                DateRangeField(
                    firstDate: DateTime(2020),
                    enabled: true,
                    initialValue: DateTimeRange(
                        start: DateTime.now(),
                        end: DateTime.now().add(Duration(days: 5))),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      filled: true,
                      fillColor: SecondayColorBlue,
                      labelText: 'Trip Dates',
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
                    validator: (value) {
                      if (value!.start.isBefore(DateTime.now())) {
                        return 'Please enter a later start date';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _startDate = value!.start;
                        _endDate = value.end;
                      });
                    }),

                const SizedBox(height: 15.0),

                Text(
                  'Enter the travel budget',
                  style: TextStyle(color: PrimaryColor),
                ),
                SizedBox(height: 5),

                // Budget texfield
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  cursorColor: PrimaryColor,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                    filled: true,
                    fillColor: SecondayColorBlue,
                    labelText: 'Travel Budget',
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
                      return "Travel budget cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (String value) {
                    setState(() {
                      this._budget = int.parse(value);
                    });
                  },
                  // validator: _validateName,
                ),

                SizedBox(
                  height: 45,
                ),

                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      createItin(_name, _budget, _startDate, _endDate);
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  AddFriendsDialog(text: "")));
                    } else {
                      print("not ok");
                    }
                  },
                  child: Container(
                      height: 50,
                      child: Center(
                          child: const Text(
                        'Start Planning',
                        style: TextStyle(fontSize: 18),
                      ))),
                  style: ElevatedButton.styleFrom(
                    primary: PrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
