import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/widgets/color_badge.dart';
import 'package:frontend_flutter/widgets/star_rating_bar.dart';
import '../screens/attraction_screen.dart';
import '../models/location_data.dart';
import '../controller/location_controller.dart';

class LocationCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String location;
  final double rating;
  final String locationId;

  const LocationCard(
      {this.imageUrl =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      required this.title,
      required this.locationId,
      required this.location,
      this.rating = 4});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
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
          color: SecondayColorBlue,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    image: DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: PrimaryColor),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.location,
                        style: TextStyle(
                            fontSize: 13, color: SecondaryColorDarkGrey),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 8),
                height: 80,
                width: MediaQuery.of(context).size.width * 0.25,
                // color: Colors.amberAccent,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 0, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Badge
                      LocationBadge(
                        bannerType: "HOTEL",
                      ),

                      //Ratings
                      StarRatingBar(
                        ratings: widget.rating,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
