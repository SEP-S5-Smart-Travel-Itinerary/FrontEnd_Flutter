import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/travel_plan_card.dart';

class PlansView extends StatelessWidget {
  const PlansView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 15,
            padding: EdgeInsets.only(left: 10, right: 5, top: 15),
            itemBuilder: (BuildContext context, int index) =>
                TravelCard(title: "Victoria Trip")),
      ),
    );
  }
}
