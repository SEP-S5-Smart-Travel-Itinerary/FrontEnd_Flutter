import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/models/location_data.dart';
import 'package:frontend_flutter/widgets/add_reviews_form.dart';
import 'package:frontend_flutter/widgets/location_card_small.dart';
import 'package:frontend_flutter/widgets/reviews_view.dart';
import 'package:frontend_flutter/widgets/upper_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:frontend_flutter/widgets/review_section.dart';
import '../controller/location_controller.dart';

class Attraction extends StatefulWidget {
  final String locationId;
  final String? name;
  final String imageLink;
  final String description;
  final double rating;
  //final String photo;

  const Attraction(
      {required this.locationId,
      //required this.photo,
      this.name = "Victorial Park 123",
      this.rating=4,
      this.imageLink =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      this.description =
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."});

  @override
  State<Attraction> createState() => _AttractionState();
}

class _AttractionState extends State<Attraction> {
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
                      image: NetworkImage('https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${widget.imageLink}&key=AIzaSyB06HS2ON1-5EI_JRK4_xlDM4McoEs-aO4'),
                      fit: BoxFit.cover)),
            ),

            UpperBar(location_id: widget.locationId,
                      type:this.widget.description,
                      location:widget.rating
                      ),
            //description
            Container(
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                child: Text(
                  //this.widget.description,
                  "${widget.name!} is a very picturesque area. This area is frequented by tourists and belongs to the ${this.widget.description} category. This place is easily accessible and there are many Accoomadations around ${widget.name!}",
                  style: TextStyle(color: Colors.black),
                )),
                // Row(
                //       children: [Text("rating: "),Text(widget.rating.toString())],
                //     ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddReviews(loc_id: widget.locationId)));
              },
              child: Container(
                  height: 50,
                  child: Center(
                      child: const Text(
                    'Add Review',
                    style: TextStyle(fontSize: 18),
                  ))),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ReviewView(title: widget.locationId)));
              },
              child: Container(
                  height: 50,
                  child: Center(
                      child: const Text(
                    'See Reviews',
                    style: TextStyle(fontSize: 18),
                  ))),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
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

            // SizedBox(
            //   height: 150.0,
            //   child: ListView.builder(
            //     physics: ClampingScrollPhysics(),
            //     shrinkWrap: true,
            //     padding: EdgeInsets.only(left: 10),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 15,
            //     itemBuilder: (BuildContext context, int index) =>
            //         LocationCardSmall(
            //       locationId: 'ssdsdsdsd',
            //       locationName: 'Victoria Park',
            //     ),
            //   ),
            // ),
            // Expanded(child: ReviewSection()),

            //submit a review section
            // Expanded(
            //   child: Column(),
            // )
          ],
        ));
  }
  // addLocations(String? location_id, String? plan_id) async {
  //   var url = Uri.parse("http://localhost:3000/itinerary/addlocation");

  //   var response = await http
  //       .post(url, body: {"location_id": location_id, "plan_id": plan_id});
  // }
}
