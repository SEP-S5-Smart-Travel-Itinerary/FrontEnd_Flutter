import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/location_controller.dart';
import 'package:frontend_flutter/models/location_data.dart';
import 'package:frontend_flutter/models/location_data_initial.dart';
import 'package:frontend_flutter/screens/places_screen3.dart';
import 'package:frontend_flutter/screens/travel_plan_view.dart';
import 'package:frontend_flutter/widgets/location_card_small.dart';
import 'package:frontend_flutter/widgets/rounded_button_without_icon.dart';
import 'package:frontend_flutter/widgets/upper_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:frontend_flutter/widgets/review_section.dart';
import '../controller/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:time_range/time_range.dart';
import '../services/local_notification_manager.dart';

class AttractionForPlan extends StatefulWidget {
  final String locationId;
  final String? name;
  final String imageLink;
  final String description;
  final rating;

  const AttractionForPlan(
      {required this.locationId,
      this.rating = 4,
      this.name = "Victorial Park 123",
      this.imageLink =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      this.description =
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."});

  @override
  State<AttractionForPlan> createState() => _AttractionForPlanState();
}

class _AttractionForPlanState extends State<AttractionForPlan> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  String date = "";

  String _media = "Walk";

  static const menuItems = <String>[
    'Taxi',
    'Walk',
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  DateTime selectedDate = DateTime.now();

  NotificationService _notifications = NotificationService();

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: globals.StartDate,
      firstDate: globals.StartDate,
      lastDate: globals.EndDate,
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
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
          title: Text(
            widget.name!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${widget.imageLink}&key=AIzaSyB06HS2ON1-5EI_JRK4_xlDM4McoEs-aO4'),
                        fit: BoxFit.cover)),
              ),

              UpperBar(
                  location_id: widget.locationId,
                  type: this.widget.description,
                  rating: widget.rating),
              //description
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  child: Text(
                    //this.widget.description,
                    "${widget.name!} is a very picturesque area. This area is frequented by tourists and belongs to the ${this.widget.description} category. This place is easily accessible and there are many Accoomadations around ${widget.name!}",
                    style: TextStyle(color: Colors.black),
                  )),

              Divider(),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: RoundedButton(
                  text: "Pick a date",
                  color: PrimaryColor,
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ),

              Divider(),
              SizedBox(
                height: 20,
              ),

              Text("Choose Travel Time"),

              TimeRange(
                  fromTitle: Text(
                    'From',
                    style: TextStyle(fontSize: 18),
                  ),
                  toTitle: Text(
                    'To',
                    style: TextStyle(fontSize: 18),
                  ),
                  titlePadding: 20,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black87),
                  activeTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  backgroundColor: Colors.transparent,
                  firstTime: TimeOfDay(hour: 6, minute: 00),
                  lastTime: TimeOfDay(hour: 23, minute: 00),
                  timeStep: 30,
                  timeBlock: 30,
                  onRangeCompleted: (range) {
                    setState(() {
                      startTime = range!.start;
                      endTime = range.end;
                    });
                  }),

              SizedBox(
                height: 15,
              ),

              Divider(),
              SizedBox(
                height: 20,
              ),

              Text(
                'Select preferred way to get into this location',
                style: TextStyle(color: PrimaryColor),
              ),
              SizedBox(height: 5),

              ListTile(
                title: const Text('Select travel media'),
                trailing: DropdownButton<String>(
                    value: _media,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _media = newValue);
                      }
                    },
                    items: this._dropDownMenuItems),
              ),

              const SizedBox(height: 24.0),

              ElevatedButton(
                onPressed: () {
                  if (startTime != null && endTime != null) {
                    addLocations(
                            widget.locationId,
                            globals.createplan_id,
                            startTime.toString(),
                            endTime.toString(),
                            selectedDate,
                            _media)
                        .then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TravelPlanView())));
                  } else {
                    Fluttertoast.showToast(
                        msg: "Select travel time",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: PrimaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: Container(
                    height: 50,
                    child: Center(
                        child: const Text(
                      'Add This Location to the plan',
                      style: TextStyle(fontSize: 18),
                    ))),
                style: ElevatedButton.styleFrom(
                  primary: PrimaryColor,
                ),
              ),

              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  addLocations(String? location_id, String? plan_id, String startTime,
      String endTime, DateTime selectedDate, String media) async {
    print("start time " + startTime.substring(10, 15));
    print("end time " + endTime);
    print("start date " + selectedDate.toString());
    print(media);

    var starttime = startTime.substring(10, 15);
    var starthour = starttime.substring(0, 2);
    var startmin = starttime.substring(3, 5);

    var date2 = new DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, int.parse(starthour), int.parse(startmin) - 30);

    _notifications.scheduleNotifications(
        title: "Visit next location",
        body: "visit ${widget.name} in 30 minutes",
        time: date2);

    var url = Uri.parse(
        "https://septravelplanner.herokuapp.com/itinerary/addlocation");

    var response = await http.post(url, body: {
      "location_id": location_id,
      "plan_id": plan_id,
      "start": startTime,
      "end": endTime
    });

    print(globals.Locations);
    print(globals.Locations.length);

    var url2 = Uri.parse(
        "https://septravelplanner.herokuapp.com/itinerary/addtravelmedia");

    var response2 = await http
        .post(url2, body: {"plan_id": plan_id, "travel_media_id": media});

    print(response2);
  }
}
