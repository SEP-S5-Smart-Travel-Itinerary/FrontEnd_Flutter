import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';

class TravelPlanTransportCard extends StatelessWidget {
  final String media;
  final double distance;
  final String time;

  const TravelPlanTransportCard(
      {required this.media, required this.distance, required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
          // isScrollControlled: true,
          context: context,
          builder: (ctx) => _buildBottomSheetTravelMedia(ctx)),
      child: Card(
        elevation: 5,
        child: Container(
          color: SecondaryColorLightGrey,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.nordic_walking),
              Text('$time min $media'),
              Text('$distance feet'),
              Icon(Icons.navigation)
            ],
          ),
        ),
      ),
    );
  }
}

// Travel media
Container _buildBottomSheetTravelMedia(BuildContext context) {
  return Container(
    height: 400,
    // padding: const EdgeInsets.fromLTRB(8, top, right, bottom)
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: SecondaryColorDarkGrey),
        ),
        color: Colors.white),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 50),
        child: Column(
          children: <Widget>[
            Text(
              "Travel Media",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              "500 feet",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Container(
                color: SecondaryColorLightGrey,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.nordic_walking),
                    Text('Walk'),
                    Text('23 min'),
                    Text('Free'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: Container(
                color: SecondaryColorLightGrey,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.car_rental),
                    Text('Taxi'),
                    Text('23 min'),
                    Text("30 usd"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: Container(
                color: SecondaryColorLightGrey,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.bus_alert),
                    Text('Bus'),
                    Text('3 min'),
                    Text('5 usd'),
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
