import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/screens/attraction_screen_for_plan.dart';
import 'package:frontend_flutter/widgets/color_badge.dart';
import 'package:frontend_flutter/widgets/star_rating_bar.dart';
import '../screens/attraction_screen.dart';
import '../models/location_data.dart';
import '../controller/location_controller.dart';

class ReviewCard extends StatefulWidget {
  final String title;
  final String location;

  const ReviewCard(
      {required this.title,
      required this.location,
      });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 5,
        child: Container(
          color: SecondayColorBlue,
          height: 80,
          child: Row(
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Container(
                height: 80,
                //width: MediaQuery.of(context).size.width * 0.5,
                child: Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
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
              
            ],
          ),
        ),
      ),
    );
  }
}
