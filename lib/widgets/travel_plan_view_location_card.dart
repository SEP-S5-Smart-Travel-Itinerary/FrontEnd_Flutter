import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/screens/travel_plan_view.dart';
import 'package:frontend_flutter/widgets/color_badge.dart';
import 'package:frontend_flutter/widgets/star_rating_bar.dart';
import 'package:frontend_flutter/widgets/color_badge.dart';
import 'package:http/http.dart' as http;
import 'package:frontend_flutter/controller/globals.dart' as globals;

class TravelPlanLocationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String locationId;
  final double rating;
  final int id;
  final String start;
  final String end;

  const TravelPlanLocationCard(
      {this.imageUrl =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      required this.title,
      required this.location,
      required this.locationId,
      required this.id,
      required this.start,
      required this.end,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        color: SecondayColorBlue,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          id.toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [Text(start),Text(" to "),Text(end)],
                    ),
                    Row(
                      children: [
                        LocationBadge(bannerType: "attraction"),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                  onPressed: () {
                    RemoveLocation(locationId).then((value) =>
                     Navigator.push(
        context, new MaterialPageRoute(builder: (context) => TravelPlanView()))
                     );
                  },
                  child: Text(
                    'Delete location',
                    style: TextStyle(color: Colors.red),
                  )),
                  
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(right: 8),
            //   height: 80,
            //   width: MediaQuery.of(context).size.width * 0.25,
            //   // color: Colors.amberAccent,
            //   child: Padding(
            //     padding: EdgeInsets.fromLTRB(8, 8, 0, 5),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         // Badge
            //         LocationBadge(
            //           bannerType: "HOTEL",
            //         ),

            //         //Ratings
            //         StarRatingBar(
            //           ratings: rating,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover)),
            ),
          ],
        ),
      ),
    );
  }
  RemoveLocation(String value) async {
    var url = Uri.parse("http://localhost:3000/itinerary/removelocation");

  var response = await http
      .post(url, body: {"location_id": value,"plan_id":globals.createplan_id});
    print("sucess called");
    //List jsonResponse = json.decode(response.body)["data"];
    // print(jsonResponse);
    
  
  }
}
