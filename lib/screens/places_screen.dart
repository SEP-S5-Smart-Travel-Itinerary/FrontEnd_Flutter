import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/widgets/location_card.dart';

class PlaceSreen extends MaterialPageRoute<void> {
  final String title;
  PlaceSreen({required this.title})
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: PrimaryColor,
              title: Text(title),
              centerTitle: true,
              elevation: 1.0,
            ),
            body: Builder(
              builder: (BuildContext context) => ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 15,
                padding: EdgeInsets.only(left: 10, top: 20),
                itemBuilder: (BuildContext context, int index) => LocationCard(
                  title: 'Victorial Park of Nuwara Eliya',
                  location: 'Nuwara Eliya',
                  rating: 4,
                ),
              ),
            ),
          );
        });
}
