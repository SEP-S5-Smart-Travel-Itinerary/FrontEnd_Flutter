import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/star_rating_bar.dart';
import '../screens/attraction_screen.dart';
import '../models/location_data.dart';
import '../controller/location_controller.dart';

class LocationCardLarge extends StatefulWidget {
  final String imageUrl;
  final String locationName;
  final String locationId;
  final String description;
  final double rating;
  const LocationCardLarge(
      {required this.locationId,
      this.imageUrl =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      required this.locationName,
      this.description =
          'orem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
      required this.rating});

  @override
  State<LocationCardLarge> createState() => _LocationCardLargeState();
}

class _LocationCardLargeState extends State<LocationCardLarge> {
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
                    )));
      },
      child: Card(
        elevation: 5,
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.8,
          // color: Colors.red,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: NetworkImage(widget.imageUrl), fit: BoxFit.cover)),
          child: Column(
            children: [
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.locationName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    StarRatingBar(
                      ratings: 2.5,
                    )
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
