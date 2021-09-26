import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/widgets/color_badge.dart';
import 'package:frontend_flutter/widgets/star_rating_bar.dart';
import 'package:frontend_flutter/widgets/color_badge.dart';

class TravelPlanLocationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final double rating;
  final int id;

  const TravelPlanLocationCard(
      {this.imageUrl =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      required this.title,
      required this.location,
      required this.id,
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
                    // Row(
                    //   children: [Text('Nuwara Eliya, Sri Lanka')],
                    // ),
                    Row(
                      children: [
                        LocationBadge(bannerType: "attraction"),
                        SizedBox(
                          width: 10,
                        ),
                        //Text('8.00 A.M - 10.00 A.M'),
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
}
