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
  final String photo;
  const LocationCardLarge(
      {required this.locationId,
      this.imageUrl =
          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=Aap_uEA7vb0DDYVJWEaX3O-AtYp77AaswQKSGtDaimt3gt7QCNpdjp1BkdM6acJ96xTec3tsV_ZJNL_JP-lqsVxydG3nh739RE_hepOOL05tfJh2_ranjMadb3VoBYFvF0ma6S24qZ6QJUuV6sSRrhCskSBP5C1myCzsebztMfGvm7ij3gZT&key=AIzaSyB06HS2ON1-5EI_JRK4_xlDM4McoEs-aO4',
      required this.locationName,
      this.description =
          'orem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
          required this.photo,
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
                      imageLink: widget.photo,
                      description:widget.description,
                      rating:widget.rating,
                      //photo:widget.photo,
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
                  image: NetworkImage('https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${widget.photo}&key=AIzaSyB06HS2ON1-5EI_JRK4_xlDM4McoEs-aO4'), fit: BoxFit.cover)),
                  //image:NetworkImage(widget.imageUrl),fit: BoxFit.cover)),
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
                      ratings: widget.rating,
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
