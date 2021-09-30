import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/location_controller.dart';
import 'package:frontend_flutter/controller/review_ctrl.dart';
import 'package:frontend_flutter/models/location_data_initial.dart';
import 'package:frontend_flutter/models/review_data.dart';
import 'package:frontend_flutter/widgets/location_card.dart';
import 'package:frontend_flutter/widgets/review_card.dart';

import 'location_card_for_plan.dart';

class ReviewView extends StatefulWidget {
  final String title;
  const ReviewView(
      {required this.title});
  @override
  _ReviewViewState createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  @override
  Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: PrimaryColor,
              title: Text("Reviews"),
              centerTitle: true,
              elevation: 1.0,
            ),
            //   body: Builder(
            //     builder: (BuildContext context) => ListView.builder(
            //       physics: ClampingScrollPhysics(),
            //       shrinkWrap: true,
            //       itemCount: 15,
            //       padding: EdgeInsets.only(left: 10, top: 20),
            //       itemBuilder: (BuildContext context, int index) => LocationCard(
            //         title: 'Victorial Park of Nuwara Eliya',
            //         location: 'Nuwara Eliya',
            //         rating: 4,
            //       ),
            //     ),
            //   ),
            // );
            body: FutureBuilder(
              future: fetchReviews(widget.title),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  List<ReviewDataInit> loc_list = snapshot.data;
                  return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: loc_list.length,
                    padding: EdgeInsets.only(left: 10, top: 20),
                    // scrollDirection: Axis.horizontal,
                    // itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ReviewCard(
                      title: loc_list[index].title,
                      location: loc_list[index].description,
                      
                      // rating: loc_list[index].rating,
                    ),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text("$snapshot.error");
                }

                return CircularProgressIndicator();
              },
            ),
          );
        }
}
