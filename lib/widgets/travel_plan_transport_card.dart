import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_flutter/assets/colors.dart';

class TravelPlanTransportCard extends StatelessWidget {
  final int starting;
  final int ending;
  final String mode;

  const TravelPlanTransportCard(
      {required this.starting, required this.ending, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        color: SecondaryColorLightGrey,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SecondaryColorLightGrey,
                  border: Border.all(width: 2, color: SecondaryColorDarkGrey)),
              child: Text('$starting'),
            ),
            (mode == 'Walk')
                ? Icon(Icons.nordic_walking)
                : Icon(Icons.local_taxi),
            Text('$mode'),
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SecondaryColorLightGrey,
                  border: Border.all(width: 2, color: SecondaryColorDarkGrey)),
              child: Text('$ending'),
            ),
          ],
        ),
      ),
    );
  }
}
