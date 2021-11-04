import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/screens/travel_plan_view.dart';
import 'package:frontend_flutter/widgets/color_badge.dart';
import 'package:frontend_flutter/widgets/star_rating_bar.dart';
import 'package:frontend_flutter/widgets/color_badge.dart';
import 'package:http/http.dart' as http;
import 'package:frontend_flutter/controller/globals.dart' as globals;

class TravelPlanLocationCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String locationId;
  final rating;
  final int id;
  final String start;
  final String end;
  final String lat;
  final String lon;

  const TravelPlanLocationCard(
      {this.imageUrl =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      required this.title,
      required this.location,
      required this.locationId,
      required this.id,
      required this.start,
      required this.end,
      required this.lat,
      required this.lon,
      required this.rating});
  @override
  _TravelPlanLocationCardState createState() => _TravelPlanLocationCardState();
}

class _TravelPlanLocationCardState extends State<TravelPlanLocationCard> {
  String? weather = "cloud";
  @override
  void initState() {
    super.initState();
    GetWeather(widget.lat, widget.lon);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        color: SecondayColorBlue,
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.id.toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(widget.start.substring(10, 15)),
                        Text(" to "),
                        Text(widget.end.substring(10, 15))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("current weather : ")),
                        Text(weather!)
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          LocationBadge(bannerType: widget.location),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                RemoveLocation(widget.locationId).then(
                                    (value) => Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                TravelPlanView())));
                              },
                              child: Text(
                                'Delete location',
                                style: TextStyle(color: Colors.red),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(right: 8),
            //   height: 80,
            //   width: MediaQuery.of(context).size.width * 0.25,
            //   // color: Colors.amberAccent,
            //   child: Padding(
            //     padding: EdgeInsets.fromLTRB(8, 8, 0, 5),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         // Badge
            //         LocationBadge(
            //           bannerType: "HOTEL",
            //         ),

            //         //Ratings
            //         StarRatingBar(
            //           ratings: rating,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${widget.imageUrl}&key=AIzaSyB06HS2ON1-5EI_JRK4_xlDM4McoEs-aO4'),
                      fit: BoxFit.cover)),
            ),
          ],
        ),
      ),
    );
  }

  RemoveLocation(String value) async {
    var url = Uri.parse(
        "https://septravelplanner.herokuapp.com/itinerary/removelocation");

    var response = await http.post(url,
        body: {"location_id": value, "plan_id": globals.createplan_id});
    print("sucess called");
    //List jsonResponse = json.decode(response.body)["data"];
    // print(jsonResponse);
  }

  GetWeather(String latt, String lonn) async {
    var url =
        Uri.parse("https://septravelplanner.herokuapp.com/apiuser/weather");

    var response =
        await http.post(url, body: {"latitude": latt, "longitude": lonn});
    var jsres = json.decode(response.body)["data"];
    //weather=jsres[0]["description"];
    setState(() {
      weather = jsres[0]["description"];
      ;
    });
    print(weather);
    //List jsonResponse = json.decode(response.body)["data"];
    // print(jsonResponse);
  }
}
