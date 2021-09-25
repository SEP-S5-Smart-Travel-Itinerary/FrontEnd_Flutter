import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import './location_card_small.dart';

class TravelPlanAddLocation extends StatelessWidget {
  final String searchQuery;
  // final double distance;

  const TravelPlanAddLocation({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        color: SecondaryColorLightGrey,
        height: 240,
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
              // onChanged: (String? value) {
              //   this._budget = value;
              //   print('name=$_budget');
              // },
              // validator: _validateName,
            ),
            Text(
              "Recommended Places",
              style: TextStyle(
                  fontWeight: FontWeight.w100, color: SecondaryColorDarkGrey),
            ),
            SizedBox(
              height: 120.0,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) =>
                    LocationCardSmall(
                  locationId: 'sdsdsd',
                  locationName: 'Victoria Park',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
