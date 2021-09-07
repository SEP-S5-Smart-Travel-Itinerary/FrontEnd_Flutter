import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/widgets/location_card.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.bookmark),
        backgroundColor: PrimaryColor,
        title: Text('Bookmarks'),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Builder(
        builder: (BuildContext context) => ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 15,
          padding: EdgeInsets.only(left: 10, top: 15),
          itemBuilder: (BuildContext context, int index) => LocationCard(
            title: 'Victorial Park of Nuwara Eliya',
            location: 'Nuwara Eliya',
            rating: 4,
          ),
        ),
      ),
    );
  }
}
