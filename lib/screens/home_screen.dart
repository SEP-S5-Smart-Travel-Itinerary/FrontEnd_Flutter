import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/services/local_notification_manager.dart';
import 'package:frontend_flutter/widgets/logo.dart';
import 'package:frontend_flutter/widgets/location_card_large.dart';
import 'package:frontend_flutter/widgets/location_card_small.dart';
import 'places_screen.dart';
import 'package:http/http.dart' as http;

import 'package:frontend_flutter/services/location.dart';

class Home extends StatelessWidget {
  // NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    // final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    Future _getNearbyPlaces() async {
      var url = Uri.parse("http://localhost:3001/apiuser/nearbyaccommodations");
      // print("called");
      var response = await http
          .post(url, body: {"latitude": "6.168829", "longitude": "80.179398"});
      // print(response.body);
      // print("done");
    }

    return Scaffold(
      //APP BAR
      appBar: AppBar(
        elevation: 0,
        title: Logo(
          logoSize: 30,
          color: SecondayColorBlue,
        ),
        actions: [
          CircleAvatar(
            radius: 25,
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: PrimaryColor,
      ),

      //BODY

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //search section
              Container(
                padding:
                    EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
                height: 70,
                color: PrimaryColor,
                child: TextField(
                  style: TextStyle(color: PrimaryColor),
                  cursorColor: PrimaryColor,
                  decoration: InputDecoration(
                    focusColor: PrimaryColor,
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    fillColor: Colors.white,
                    hintText: 'Search cities and attractions',
                    // labelText: 'Search cities and attractions',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                  ),
                ),
              ),

              //Notification Trigger

              // RaisedButton(
              //   child: Text('Show Notification'),
              //   padding: const EdgeInsets.all(10),
              //   onPressed: () async {
              //     await _notificationService.scheduleNotifications(
              //         title: "New Timing",
              //         body: "Fun not",
              //         time: DateTime.parse("2021-09-10 00:21:00"));
              //   },
              // ),

              //Recommended Locations Section

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Recommended Places',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: SecondaryColorDarkGrey),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 200.0,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) =>
                      LocationCardLarge(
                    locationName: 'Victoria Park',
                    description:
                        "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
                    rating: 4,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: SecondaryColorDarkGrey),
                  onPressed: () {
                    Navigator.push(
                        context, PlaceSreen(title: 'Recommended Locations'));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(children: [
                        Spacer(),
                        Text('View all recommended places'),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ])),
                ),
              ),

              //Nearby Locations Section

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Nearby Places',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: SecondaryColorDarkGrey),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 180.0,
                child: FutureBuilder(
                  future: _getNearbyPlaces(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) =>
                          LocationCardSmall(
                        locationName: 'Victoria Park',
                      ),
                    );
                  },

                  // child: ListView.builder(
                  //   physics: ClampingScrollPhysics(),
                  //   shrinkWrap: true,
                  //   padding: EdgeInsets.only(left: 10),
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: 15,
                  //   itemBuilder: (BuildContext context, int index) =>
                  //       LocationCardSmall(
                  //     locationName: 'Victoria Park',
                  //   ),
                  // ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: SecondaryColorDarkGrey),
                  onPressed: () {
                    Navigator.push(
                        context, PlaceSreen(title: 'Nearby Locations'));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(children: [
                        Spacer(),
                        Text('View all nearby places'),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ])),
                ),
              ),
            ],
          ),
        ),
      ),

      //BOTTOM NAVIGATION
      // bottomNavigationBar: BottomNavBar(),

      // floatingActionButton: showFab
      //     ? FloatingActionButton(
      //         backgroundColor: PrimaryColor,
      //         child: BottomIcon(
      //           path: "icons/globe_icon.png",
      //         ),
      //         onPressed: () {})
      //     : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
