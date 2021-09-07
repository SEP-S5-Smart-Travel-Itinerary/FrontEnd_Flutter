import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/upper_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:frontend_flutter/widgets/review_section.dart';

class Attraction extends StatefulWidget {
  @override
  _AttractionState createState() => _AttractionState();
}

class _AttractionState extends State<Attraction> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: Text('Victoria Park of Nuwara Eliya'),
            centerTitle: true,
            expandedHeight: 230.0,
            floating: true,
            pinned: true,
            snap: true,
            leading: Icon(Icons.arrow_back_outlined),
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Image.network(
                  'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
                  fit: BoxFit.cover,
                )),
              ],
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Container(),
          // )
        ];
      },
      body: Column(
        children: [
          // upper bar
          UpperBar(),

          //description
          Container(
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                style: TextStyle(color: Colors.black.withOpacity(0.7)),
              )),

          //map location section

          Expanded(
            child: Container(
              height: 300,
              child: GoogleMap(
                initialCameraPosition: _kGooglePlex,
                mapType: MapType.satellite,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),

          Expanded(child: ReviewSection())
        ],
      ),
    ));
  }
}
