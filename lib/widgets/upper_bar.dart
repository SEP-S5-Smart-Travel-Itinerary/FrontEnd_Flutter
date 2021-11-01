import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/color_badge.dart';
import 'package:frontend_flutter/widgets/star_rating_bar.dart';
import '../controller/book_ctrl.dart';

class UpperBar extends StatelessWidget {
  final String type;
  final String weather;
  final double location;
  final String location_id;

  const UpperBar(
      {this.type = "ATTRACTION",
      this.weather = 'sunny',
      this.location = 4,
      required this.location_id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      color: Color(0xFFEFF2F4),
      padding: EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                LocationBadge(bannerType: type),
                SizedBox(
                  width: 10,
                ),
                //Text(type),
              ]),
              SizedBox(
                height: 3,
              ),
              Row(children: [
                Text(
                  "rating",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  width: 5,
                ),
                 StarRatingBar(
                      ratings: location,
                    )
                
              ]),
              SizedBox(
                height: 3,
              ),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              addBookmark(location_id);
            },
            icon: Icon(Icons.bookmark_add),
            color: Colors.black,
            iconSize: 35,
          )
        ],
      ),
    );
  }
}
