import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import '../widgets/travel_plan_view_location_card.dart';
import '../widgets/travel_plan_transport_card.dart';
import '../widgets/travel_plan_add_location.dart';
import '../widgets/rounded_button_without_icon.dart';
import 'package:date_range_form_field/date_range_form_field.dart';

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
          title: Text('Trip to Nuwara ELiya'),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: Container(
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
                                  "09/09",
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
                                  "09/11",
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
                                      '250',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      ' / ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '750',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
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
                            children: [Text('Nevada  '), Text('Paris')],
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
                                      '2',
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
                    // travel_plan_location_card.dart
                    TravelPlanLocationCard(
                      rating: 4,
                      location: 'Nuwara',
                      title: 'location',
                    ),

                    //travel_plan_transport_card.dart
                    TravelPlanTransportCard(
                      time: "5",
                      media: "Car",
                      distance: 100,
                    ),

                    //travel_plan_add_location.dart
                    TravelPlanAddLocation(searchQuery: "searchQuery")
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

Container _buildBottomSheetChangeName(BuildContext context) {
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
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Change Plan Name",
              color: PrimaryColor,
              height: 150,
            ),
          ],
        ),
      ),
    ),
  );
}

// Edit travel budget
Container _buildBottomSheetChangeBudget(BuildContext context) {
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
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Change Travel Budget",
              color: PrimaryColor,
              height: 150,
            ),
          ],
        ),
      ),
    ),
  );
}

// Edit travel budget
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
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Cancel",
              color: SecondaryColorDarkGrey,
              height: 150,
            ),
          ],
        ),
      ),
    ),
  );
}

// Edit travel dates
Container _buildBottomSheetChangeDates(BuildContext context) {
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
                onSaved: (value) {
                  // setState(() {
                  //   myDateRange = value!;
                  // });
                }),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Edit Travel Dates",
              color: PrimaryColor,
              height: 150,
            ),
          ],
        ),
      ),
    ),
  );
}
