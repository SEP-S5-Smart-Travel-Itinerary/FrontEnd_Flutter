import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/location_data.dart';
import 'package:frontend_flutter/screens/attraction_screen.dart';
import '../controller/location_controller.dart';

class LocationCardSmall extends StatefulWidget {
  final String imageUrl;
  final String locationName;
  final String locationId;
  final String description;
  final rating;
  //final String photo;

  // NetworkImage getImage(photoReference) {
  //   print("photo ref " + photoReference);
  //   final url =
  //       "https://maps.googleapis.com/maps/api/place/photo?photo_reference=$photoReference&key=AIzaSyB06HS2ON1-5EI_JRK4_xlDM4McoEs-aO4";
  //   return NetworkImage(url);
  // }

  const LocationCardSmall({
    this.imageUrl =
        'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
    required this.locationName,
    this.description =
        'orem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
    this.rating = 4.0,
    //required this.photo,
    required this.locationId,
  });

  @override
  State<LocationCardSmall> createState() => _LocationCardSmallState();
}

class _LocationCardSmallState extends State<LocationCardSmall> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print("widget value" + widget.locationId);
        LocationData a = await fetchDetailsofLocations(widget.locationId);
        print("a received succesfully");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Attraction(
                      locationId: widget.locationId,
                      name: a.name,
                      imageLink: widget.imageUrl,
                      description: widget.description,
                      rating: widget.rating!,
                      //photo:widget.photo,
                    )));
      },
      child: Card(
        elevation: 5,
        child: Container(
          height: 180,
          width: 140,
          // color: Colors.red,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: NetworkImage(
                      'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${widget.imageUrl}&key=AIzaSyB06HS2ON1-5EI_JRK4_xlDM4McoEs-aO4'),
                  fit: BoxFit.cover)),
          // image: DecorationImage(image: NetworkImage(widget.imageUrl)),

          child: Column(
            children: [
              Spacer(),
              Container(
                width: 150,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.locationName,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
