import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/plan_controller.dart';
import 'package:frontend_flutter/models/book_init.dart';
import 'package:frontend_flutter/models/travel_plan.dart';
import 'package:frontend_flutter/screens/home_screen.dart';
import '../main_screen.dart';
import '../widgets/travel_plan_view_location_card.dart';
import '../widgets/travel_plan_transport_card.dart';
import '../widgets/travel_plan_add_location.dart';
import '../widgets/rounded_button_without_icon.dart';
import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:frontend_flutter/controller/globals.dart' as globals;

class TravelPlanView extends StatefulWidget {
  @override
  _TravelPlanViewState createState() => _TravelPlanViewState();
}

class _TravelPlanViewState extends State<TravelPlanView> {
  List _listings = [];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => showModalBottomSheet(
                  context: context, builder: (ctx) => _buildBottomSheet(ctx)),
            ),
            SizedBox(
              width: 10,
            )
          ],
          backgroundColor: PrimaryColor,
          title: Text(globals.Name),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 110,
                color: SecondayColorBlue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  globals.startdatestring,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " - ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  globals.enddatestring,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: SecondaryColorDarkGrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'TRAVEL BUDGET',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      globals.InitialBudget.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    // Text(
                                    //   ' / ',
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.white),
                                    // ),
                                    // Text(
                                    //   '750',
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.white),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Row(
                                  //children: [Text('Nevada  '), Text('Paris')],
                                  )),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: PrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      globals.TripMates.length.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'members',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 5,
                color: PrimaryColor,
              ),

              // plan section
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TravelPlanAddLocation(),
                    FutureBuilder(
                      future: fetchPlanLocationList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          List<BookDataInit> locList = snapshot.data;
                          //print(locList[0].rating);
                          return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: locList.length,
                            padding: EdgeInsets.only(left: 10, top: 15),
                            //scrollDirection: Axis.horizontal,
                            // itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) =>
                                TravelPlanLocationCard(
                              title: locList[index].name,
                              location: "", //'Victorial Park of Nuwara Eliya',
                              rating: 4,
                              id: index + 1,
                              //location: locList[index].place_id,
                              //imageUrl:"",
                            ),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          //return Text("$snapshot.error");
                          return Text("No Locations");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                    TravelPlanTransportCard(
                      time: "5",
                      media: "Car",
                      distance: 100,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

// modal bottom sheet for options
Container _buildBottomSheet(BuildContext context) {
  return Container(
    height: 350,
    // padding: const EdgeInsets.fromLTRB(8, top, right, bottom)
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: PrimaryColor),
        ),
        color: SecondayColorBlue),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 50),
        child: Column(
          children: <Widget>[
            RoundedButton(
              text: "Change Plan Name",
              color: PrimaryColor,
              height: 150,
              onPressed: () => showModalBottomSheet(
                  // isScrollControlled: true,
                  context: context,
                  builder: (ctx) => _buildBottomSheetChangeName(ctx)),
            ),
            SizedBox(
              height: 20,
            ),
            // RoundedButton(
            //   text: "Edit Travel Locations",
            //   color: PrimaryColor,
            //   height: 150,
            //   onPressed: () => showModalBottomSheet(
            //       // isScrollControlled: true,
            //       context: context,
            //       builder: (ctx) => _buildBottomSheetChangeName(ctx)),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            RoundedButton(
              text: "Edit Travel Budget",
              color: PrimaryColor,
              height: 150,
              onPressed: () => showModalBottomSheet(
                  // isScrollControlled: true,
                  context: context,
                  builder: (ctx) => _buildBottomSheetChangeBudget(ctx)),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Edit Travel Dates",
              color: PrimaryColor,
              height: 150,
              onPressed: () => showModalBottomSheet(
                  // isScrollControlled: true,
                  context: context,
                  builder: (ctx) => _buildBottomSheetChangeDates(ctx)),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Delete Plan",
              color: Color(0xffC75151),
              height: 150,
              onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (ctx) => _buildBottomSheetDeletePlan(ctx)),
            )
          ],
        ),
      ),
    ),
  );
}

//change plan name
Container _buildBottomSheetChangeName(BuildContext context) {
  String? _name;
  return Container(
    // padding: const EdgeInsets.fromLTRB(8, top, right, bottom)
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: PrimaryColor),
        ),
        color: SecondayColorBlue),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 50),
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: '',
              // controller: this._emailController,
              decoration: InputDecoration(
                labelText: 'Plan Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              onChanged: (String? value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Change Plan Name",
              color: PrimaryColor,
              height: 150,
              onPressed: () {
                changeName(_name, globals.createplan_id).then((value) =>
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TravelPlanView())));
                //           Navigator.push(
                // context, new MaterialPageRoute(builder: (context) => TravelPlanView()));
                // print(_name);
                // print(_budget);
                // print(_startDate);
                // print(_endDate);
              },
            ),
          ],
        ),
      ),
    ),
  );
}

// Edit travel budget
Container _buildBottomSheetChangeBudget(BuildContext context) {
  int? _budget;
  return Container(
    // padding: const EdgeInsets.fromLTRB(8, top, right, bottom)
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: PrimaryColor),
        ),
        color: SecondayColorBlue),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 50),
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: '',
              // controller: this._emailController,
              decoration: InputDecoration(
                labelText: 'Travel Budget',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              onChanged: (String value) {
                _budget = int.parse(value);
              },
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Change Travel Budget",
              color: PrimaryColor,
              height: 150,
              onPressed: () {
                print(_budget);
                editBudget(_budget, globals.createplan_id).then((value) =>
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TravelPlanView())));
                //
              },
            ),
          ],
        ),
      ),
    ),
  );
}

// Delete plan
Container _buildBottomSheetDeletePlan(BuildContext context) {
  return Container(
    // padding: const EdgeInsets.fromLTRB(8, top, right, bottom)
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: PrimaryColor),
        ),
        color: SecondayColorBlue),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 50),
        child: Column(
          children: <Widget>[
            Text(
              "Are you sure you want to delete this travel plan?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Delete Travel Plan",
              color: Color(0xffC75151),
              height: 150,
              onPressed: () {
                deletePlan(globals.createplan_id).then((value) =>
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TravelPlanView())));
              },
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Cancel",
              color: SecondaryColorDarkGrey,
              height: 150,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TravelPlanView()));
              },
            ),
          ],
        ),
      ),
    ),
  );
}

// Edit travel dates
Container _buildBottomSheetChangeDates(BuildContext context) {
  DateTime? _startDate;
  DateTime? _endDate;
  return Container(
    height: 350,
    // padding: const EdgeInsets.fromLTRB(8, top, right, bottom)
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: PrimaryColor),
        ),
        color: SecondayColorBlue),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 50),
        child: Column(
          children: <Widget>[
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
                }
                // onSaved: (value) {
                //   // setState(() {
                //   //   myDateRange = value!;
                //   // });
                // }
                ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Edit Travel Dates",
              color: PrimaryColor,
              height: 150,
              onPressed: () {
                changeDates(globals.createplan_id, _startDate, _endDate).then(
                    (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TravelPlanView())));
              },
            ),
          ],
        ),
      ),
    ),
  );
}
