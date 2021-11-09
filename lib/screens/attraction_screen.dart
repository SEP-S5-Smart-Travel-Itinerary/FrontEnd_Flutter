import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/models/location_data.dart';
import 'package:frontend_flutter/models/location_data_initial.dart';
import 'package:frontend_flutter/widgets/add_reviews_form.dart';
import 'package:frontend_flutter/widgets/location_card_small.dart';
import 'package:frontend_flutter/widgets/reviews_view.dart';
import 'package:frontend_flutter/widgets/upper_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:frontend_flutter/widgets/review_section.dart';
import '../controller/location_controller.dart';
import 'package:http/http.dart' as http;

class Attraction extends StatefulWidget {
  final String locationId;
  final String? name;
  final String imageLink;
  final String description;
  final rating;
  //final String photo;

  const Attraction(
      {required this.locationId,
      //required this.photo,
      this.name = "Victorial Park 123",
      this.rating = 4,
      this.imageLink =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      this.description =
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."});

  @override
  State<Attraction> createState() => _AttractionState();
}

class _AttractionState extends State<Attraction> {
  double longitude = 0.0;
  double latitude = 0.0;

  @override
  void initState() {
    super.initState();
    fetchDetailsofLocations(widget.locationId);
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

              //nearby attractions

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Nearby Attractions',
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
                  future: fetchNearbyAttractionsNew(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      List<LocationDataInit> loc_list = snapshot.data;

                      List<LocationDataInit> list = [];
                      for (var i = 0; i < loc_list.length; i++) {
                        // print(loc_list[i].imagelink);
                        if (loc_list[i].imagelink != null) {
                          // print("hjk");
                          list.add(loc_list[i]);
                        }
                      }

                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        padding: EdgeInsets.only(left: 10),
                        scrollDirection: Axis.horizontal,
                        // itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            LocationCardSmall(
                          locationId: list[index].place_id,
                          locationName: list[index].name,
                          description: list[index].type[0],
                          rating: list[index].rating ?? 4,
                          //photo:list[index].imagelink[0]["photo_reference"]
                          imageUrl: list[index].imagelink[0]["photo_reference"],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text("$snapshot.error");
                    }

                    return CircularProgressIndicator();
                  },
                ),
              ),

              //nearby restaurants

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Nearby Restaurants',
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
                  future: fetchNearbyRestaurantsNew(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      List<LocationDataInit> loc_list = snapshot.data;

                      List<LocationDataInit> list = [];
                      for (var i = 0; i < loc_list.length; i++) {
                        // print(loc_list[i].imagelink);
                        if (loc_list[i].imagelink != null) {
                          // print("hjk");
                          list.add(loc_list[i]);
                        }
                      }

                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        padding: EdgeInsets.only(left: 10),
                        scrollDirection: Axis.horizontal,
                        // itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            LocationCardSmall(
                          locationId: list[index].place_id,
                          locationName: list[index].name,
                          description: list[index].type[0],
                          rating: list[index].rating ?? 4,
                          //photo:list[index].imagelink[0]["photo_reference"]
                          imageUrl: list[index].imagelink[0]["photo_reference"],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text("$snapshot.error");
                    }

                    return CircularProgressIndicator();
                  },
                ),
              ),

              // nearby accomomodation

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Nearby Accomodations',
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
                  future: fetchNearbyAccommodationsNew(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      List<LocationDataInit> loc_list = snapshot.data;

                      List<LocationDataInit> list = [];
                      for (var i = 0; i < loc_list.length; i++) {
                        // print(loc_list[i].imagelink);
                        if (loc_list[i].imagelink != null) {
                          // print("hjk");
                          list.add(loc_list[i]);
                        }
                      }

                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        padding: EdgeInsets.only(left: 10),
                        scrollDirection: Axis.horizontal,
                        // itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            LocationCardSmall(
                          locationId: list[index].place_id,
                          locationName: list[index].name,
                          description: list[index].type[0],
                          rating: list[index].rating ?? 4,
                          //photo:list[index].imagelink[0]["photo_reference"]
                          imageUrl: list[index].imagelink[0]["photo_reference"],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text("$snapshot.error");
                    }

                    return CircularProgressIndicator();
                  },
                ),
              ),

              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  fetchDetailsofLocations(String placeId) async {
    var url =
        Uri.parse("https://septravelplanner.herokuapp.com/apiuser/details");

    var response = await http.post(url, body: {"place_id": placeId});
    // print(response.body);
    if (response.statusCode == 200) {
      final Map jsonResponse = json.decode(response.body)["data"];
      // print(jsonResponse);
      setState(() {
        longitude = jsonResponse["longitude"];
        latitude = jsonResponse["latitude"];
      });

      return LocationData.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load location details from API');
    }
  }

  fetchNearbyAttractionsNew() async {
    var url = Uri.parse(
        "https://septravelplanner.herokuapp.com/apiuser/nearbyattractions");

    var response = await http.post(url, body: {
      "latitude": latitude.toString(),
      "longitude": longitude.toString()
    });

    if (response.statusCode == 200) {
      print("sucess called");
      List jsonResponse = json.decode(response.body)["data"];
      // print(jsonResponse[0]['imagelink'][0]['photo_reference']);
      return jsonResponse
          .map((location) => new LocationDataInit.fromJson(location))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<LocationDataInit>> fetchNearbyRestaurantsNew() async {
    await getCurrentLocation();
    var url = Uri.parse(
        "https://septravelplanner.herokuapp.com/apiuser/nearbyrestaurants");

    var response = await http.post(url, body: {
      "latitude": latitude.toString(),
      "longitude": longitude.toString()
    });
    if (response.statusCode == 200) {
      print("sucess called");
      List jsonResponse = json.decode(response.body)["data"];
      // print(jsonResponse);
      return jsonResponse
          .map((location) => new LocationDataInit.fromJson(location))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<LocationDataInit>> fetchNearbyAccommodationsNew() async {
    await getCurrentLocation();
    var url = Uri.parse(
        "https://septravelplanner.herokuapp.com/apiuser/nearbyaccommodations");

    var response = await http.post(url, body: {
      "latitude": latitude.toString(),
      "longitude": longitude.toString()
    });
    if (response.statusCode == 200) {
      // print("sucess called");
      List jsonResponse = json.decode(response.body)["data"];
      // print(jsonResponse);
      return jsonResponse
          .map((location) => new LocationDataInit.fromJson(location))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
