import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/models/location_data_initial.dart';
import 'package:frontend_flutter/screens/search_screen_for_planing.dart';
import './location_card_small.dart';
import 'package:http/http.dart' as http;

import 'add_location.dart';

class TravelPlanAddLocation extends StatefulWidget {
  //const TravelPlanAddLocation({ Key? key }) : super(key: key);

  @override
  _TravelPlanAddLocationState createState() => _TravelPlanAddLocationState();
}

class _TravelPlanAddLocationState extends State<TravelPlanAddLocation> {
  List predictions = [];
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        color: SecondaryColorLightGrey,
        height: 100,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              cursorColor: SecondaryColorDarkGrey,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.location_pin,
                  color: SecondaryColorDarkGrey,
                ),
                filled: true,
                fillColor: SecondaryColorLightGrey,
                labelText: 'Add Location',
                labelStyle: TextStyle(color: SecondaryColorDarkGrey),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide:
                      BorderSide(color: SecondaryColorDarkGrey, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide:
                      BorderSide(color: SecondaryColorDarkGrey, width: 2),
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreenForPlan())),
            ),
            Text(
              "Nearby Places",
              style: TextStyle(
                  fontWeight: FontWeight.w100, color: SecondaryColorDarkGrey),
            ),

            // SizedBox(
            //   height: 120.0,
            //   child: ListView.builder(
            //     physics: ClampingScrollPhysics(),
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 15,
            //     itemBuilder: (BuildContext context, int index) =>
            //         LocationCardSmall(
            //       locationId: 'sdsdsd',
            //       locationName: 'Victoria Park',
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var url = Uri.parse("https://septravelplanner.herokuapp.com/apiuser/auto");

    var response = await http.post(url, body: {"place": value});
    print("sucess called");
    //List jsonResponse = json.decode(response.body)["data"];
    // print(jsonResponse);
    setState(() {
      predictions = json.decode(response.body)["data"];
      print(predictions);
    });
  }

  // ignore: non_constant_identifier_names

}
