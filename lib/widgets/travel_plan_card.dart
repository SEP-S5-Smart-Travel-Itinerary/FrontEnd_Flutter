import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/screens/travel_plan_view.dart';

class TravelCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int locations;
  final String startDate;
  final String endDate;

  const TravelCard(
      {this.imageUrl =
          'https://images.unsplash.com/photo-1610017810004-a6f3c531df34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1934&q=80',
      required this.title,
      this.locations = 0,
      this.startDate = '2022/01/01',
      this.endDate = '2022/12/31'});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TravelPlanView()));
      },
      child: Card(
        elevation: 5,
        child: Container(
          color: SecondayColorBlue,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 80,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Text(
                      //   startDate + ' - ' + endDate,
                      //   style: TextStyle(
                      //       fontSize: 13, color: SecondaryColorDarkGrey),
                      // ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Text(
                          //   locations.toString() + ' ' + 'Locations',
                          //   style: TextStyle(
                          //       fontSize: 12, color: SecondaryColorDarkGrey),
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: 10,
                height: 100,
                decoration: BoxDecoration(
                  color: PrimaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 12,
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