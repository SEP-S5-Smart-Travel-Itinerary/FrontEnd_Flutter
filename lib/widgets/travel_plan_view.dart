import 'package:flutter/material.dart';

class TravelPlanView extends StatefulWidget {
  @override
  _TravelPlanViewState createState() => _TravelPlanViewState();
}

class _TravelPlanViewState extends State<TravelPlanView> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text('data'),
          )
        ],
      ),
    ));
  }
}
