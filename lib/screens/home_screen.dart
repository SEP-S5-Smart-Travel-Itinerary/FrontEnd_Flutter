import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/models/location_data_initial.dart';
import 'package:frontend_flutter/screens/places_screen2.dart';
import 'package:frontend_flutter/widgets/logo.dart';
import 'package:frontend_flutter/widgets/location_card_large.dart';
import 'package:frontend_flutter/widgets/location_card_small.dart';
import 'places_screen.dart';
import 'search_screen.dart';

import 'package:geolocator/geolocator.dart';
import '../controller/globals.dart' as globals;

import 'package:frontend_flutter/controller/location_controller.dart';

class Home extends StatefulWidget {
  // NotificationService _notificationService = NotificationService();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      //APP BAR
      appBar: AppBar(
        elevation: 0,
        title: Logo(
          logoSize: 30,
          color: SecondayColorBlue,
        ),
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
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen())),
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
                child: FutureBuilder(
                  future: fetchAttractionsByCategory(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      List<LocationDataInit> loc_list = snapshot.data;
                      // print("hahj");
                      // print(loc_list[3].imagelink[0]["photo_reference"]);
                      // print("hahj");
                      // print(loc_list.length);
                      List<LocationDataInit> list = [];
                      for (var i = 0; i < loc_list.length; i++) {
                        // print(loc_list[i].imagelink);
                        if (loc_list[i].imagelink != null) {
                          print("hjk");
                          list.add(loc_list[i]);
                        }
                      }
                      //     print("hahj");
                      // print(loc_list[0].imagelink[0]["photo_reference"]);
                      // print("hahj");
                      print(list.length);
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        padding: EdgeInsets.only(left: 10),
                        scrollDirection: Axis.horizontal,
                        // itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            LocationCardLarge(
                          locationName: list[index].name,
                          locationId: list[index].place_id,
                          description: list[index].type[0],
                          rating: list[index].rating ?? 4,
                          photo: list[index].imagelink[0]["photo_reference"],
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: SecondaryColorDarkGrey),
                  onPressed: () {
                    Navigator.push(
                        context, PlaceScreen(title: 'Recommended Locations'));
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
                  future: fetchNearbyAttractions(),
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
                    // return Shimmer.fromColors(
                    //   // enabled: true,
                    //   baseColor: Colors.grey[400]!,
                    //   highlightColor: Colors.grey[100]!,

                    //   child: ListView.separated(
                    //     scrollDirection: Axis.horizontal,
                    //     shrinkWrap: true,
                    //     physics: const ClampingScrollPhysics(),
                    //     itemCount: 5,
                    //     itemBuilder: (_, __) => Padding(
                    //       padding: const EdgeInsets.only(bottom: 4),
                    //       child: placeHolderRow(),
                    //     ),
                    //     separatorBuilder: (_, __) => const SizedBox(height: 2),
                    //   ),
                    // );

                    return CircularProgressIndicator();
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: SecondaryColorDarkGrey),
                  onPressed: () {
                    Navigator.push(
                        context, PlaceScreen2(title: 'Nearby Locations'));
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

              // nearby restaurants

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
                  future: fetchNearbyRestaurants(),
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

              //nearby accomodation

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
                  future: fetchNearbyAccommodations(),
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
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
