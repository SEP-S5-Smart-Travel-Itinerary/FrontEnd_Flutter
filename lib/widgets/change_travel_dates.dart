import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/plan_controller.dart';
import 'package:frontend_flutter/screens/travel_plan_view.dart';
import '../controller/globals.dart' as globals;

class ChangePlanDates extends StatefulWidget {
  final String text;
  const ChangePlanDates({required this.text});
  @override
  _ChangePlanDatesState createState() => _ChangePlanDatesState();
}

class _ChangePlanDatesState extends State<ChangePlanDates> {
  DateTime? _startDate;
  DateTime? _endDate;
  GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: Text('Change Plan Dates'),
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
                  'Change Plan Dates',
                  style: TextStyle(color: PrimaryColor),
                ),
                SizedBox(height: 5),

                // Add countries
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
                      _startDate = value!.start;
                      _endDate = value.end;
                    }),

                SizedBox(
                  height: 25.0,
                ),

                SizedBox(
                  height: 30,
                ),

                ElevatedButton(
                  onPressed: () {
                    if (_formkey1.currentState!.validate()) {
                      changeDates(globals.createplan_id, _startDate, _endDate)
                          .then((value) => Navigator.push(
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
                        'Change Plan Dates',
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
