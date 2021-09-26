import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/models/location_data.dart';
import 'package:frontend_flutter/screens/travel_plan_view.dart';
import 'package:frontend_flutter/widgets/location_card_small.dart';
import 'package:frontend_flutter/widgets/upper_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:frontend_flutter/widgets/review_section.dart';
import '../controller/globals.dart' as globals;
import 'package:http/http.dart' as http;

class AttractionForPlan extends StatefulWidget {
  final String locationId;
  final String? name;
  final String imageLink;
  final String description;

  const AttractionForPlan(
      {required this.locationId,
      this.name = "Victorial Park 123",
      this.imageLink =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      this.description =
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."});

  @override
  State<AttractionForPlan> createState() => _AttractionForPlanState();
}

class _AttractionForPlanState extends State<AttractionForPlan> {
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
        body: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: NetworkImage(widget.imageLink),
                      fit: BoxFit.cover)),
            ),

            UpperBar(),
            //description
            Container(
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                child: Text(
                  this.widget.description,
                  style: TextStyle(color: Colors.black.withOpacity(0.7)),
                )),
              ElevatedButton(
                onPressed: () {
                  addLocations(widget.locationId,globals.createplan_id).then((value) =>
                     Navigator.push(
        context, MaterialPageRoute(builder: (context) => TravelPlanView()))
                     );
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
            // map location section

            // Container(
            //   height: 300,
            //   child: GoogleMap(
            //     initialCameraPosition: _kGooglePlex,
            //     mapType: MapType.satellite,
            //     onMapCreated: (GoogleMapController controller) {
            //       _controller.complete(controller);
            //     },
            //   ),
            // ),

            SizedBox(
              height: 150.0,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 10),
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) =>
                    LocationCardSmall(
                  locationId: 'ssdsdsdsd',
                  locationName: 'Victoria Park',
                ),
              ),
            ),
            // Expanded(child: ReviewSection()),

            //submit a review section
            // Expanded(
            //   child: Column(),
            // )
          ],
        ));
  }
   addLocations(String? location_id,String? plan_id) async {
  var url = Uri.parse("http://localhost:3000/itinerary/addlocation");

  var response = await http
      .post(url, body: {"location_id": location_id,"plan_id":plan_id});
  
}
}
