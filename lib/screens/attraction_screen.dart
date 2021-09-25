import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/widgets/location_card_small.dart';
import 'package:frontend_flutter/widgets/upper_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:frontend_flutter/widgets/review_section.dart';
import '../controller/location_controller.dart';

class Attraction extends StatefulWidget {
  final String locationId;
  final String name;
  final String imageLink;
  final String description;

  const Attraction(
      {this.locationId = "ChIJY_qDpIV54ToRJ7hkWrfzwAw",
      required this.name,
      this.imageLink =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      this.description =
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."});

  @override
  State<Attraction> createState() => _AttractionState();
}

class _AttractionState extends State<Attraction> {
  @override
  void initState() {
    super.initState();
    fetchDetailsofLocations(widget.locationId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // SliverAppBar is declared in Scaffold.body, in slivers of a
      // CustomScrollView.
      body: FutureBuilder(
        // future: _future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.data.name);
          if (snapshot.hasData) {
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: PrimaryColor,
                  pinned: true,
                  snap: true,
                  title: Text(snapshot.data.name),
                  floating: true,
                  expandedHeight: 230.0,
                  leading: Icon(Icons.arrow_back_outlined),
                  flexibleSpace: FlexibleSpaceBar(

                      // title: Text(
                      //   'Victoria Park of Nuwara Eliya',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //   ),
                      // ),
                      background: Image.network(
                    this.widget.imageLink,
                    fit: BoxFit.cover,
                  )),
                ),
                // If the main content is a list, use SliverList instead.
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: Center(
                      child: Column(
                    children: [
                      // upper bar
                      UpperBar(),

                      //description
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 17, vertical: 10),
                          child: Text(
                            this.widget.description,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          )),

                      //map location section

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
                  )),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("$snapshot.error");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}










  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: NestedScrollView(
  //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
  //       return [
  //         SliverAppBar(
  //           title: Text('Victoria Park of Nuwara Eliya'),
  //           centerTitle: true,
  //           expandedHeight: 230.0,
  //           floating: true,
  //           pinned: true,
  //           snap: true,
  //           leading: Icon(Icons.arrow_back_outlined),
  //           flexibleSpace: Stack(
  //             children: <Widget>[
  //               Positioned.fill(
  //                   child: Image.network(
  //                 'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
  //                 fit: BoxFit.cover,
  //               )),
  //             ],
  //           ),
  //         ),
  //         // SliverToBoxAdapter(
  //         //   child: Container(),
  //         // )
  //       ];
  //     },
  //     body: Column(
  //       children: [
  //         // upper bar
  //         UpperBar(),

  //         //description
  //         Container(
  //             padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
  //             child: Text(
  //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  //               style: TextStyle(color: Colors.black.withOpacity(0.7)),
  //             )),

  //         //map location section

  //         Container(
  //           height: 300,
  //           child: GoogleMap(
  //             initialCameraPosition: _kGooglePlex,
  //             mapType: MapType.satellite,
  //             onMapCreated: (GoogleMapController controller) {
  //               _controller.complete(controller);
  //             },
  //           ),
  //         ),

  //         SizedBox(
  //           height: 150.0,
  //           child: ListView.builder(
  //             physics: ClampingScrollPhysics(),
  //             shrinkWrap: true,
  //             padding: EdgeInsets.only(left: 10),
  //             scrollDirection: Axis.horizontal,
  //             itemCount: 15,
  //             itemBuilder: (BuildContext context, int index) =>
  //                 LocationCardSmall(
  //               locationName: 'Victoria Park',
  //             ),
  //           ),
  //         ),
  //         // Expanded(child: ReviewSection()),

  //         //submit a review section
  //         // Expanded(
  //         //   child: Column(),
  //         // )
  //       ],
  //     ),
  //   ));
  // }