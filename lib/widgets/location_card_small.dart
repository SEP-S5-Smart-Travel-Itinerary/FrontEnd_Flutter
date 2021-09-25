import 'package:flutter/material.dart';
import 'package:frontend_flutter/screens/attraction_screen.dart';

class LocationCardSmall extends StatelessWidget {
  final String imageUrl;
  final String locationName;
  final String locationId;

  const LocationCardSmall(
      {this.imageUrl =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      required this.locationName,
      required this.locationId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Attraction(
                locationId: locationId,
                name: locationName,
              ))),
      child: Card(
        elevation: 5,
        child: Container(
          height: 180,
          width: 140,
          // color: Colors.red,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover)),
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
                    Text(
                      locationName,
                      style: TextStyle(color: Colors.white),
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
