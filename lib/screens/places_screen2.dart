import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/location_controller.dart';
import 'package:frontend_flutter/models/location_data_initial.dart';
import 'package:frontend_flutter/widgets/location_card.dart';

class PlaceScreen2 extends MaterialPageRoute<void> {
  final String title;
  PlaceScreen2({required this.title})
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: PrimaryColor,
              title: Text(title),
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
                  future: fetchNearbyAttractions(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      List<LocationDataInit> loc_list = snapshot.data;
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: loc_list.length,
                        padding: EdgeInsets.only(left: 10, top: 20),
                       // scrollDirection: Axis.horizontal,
                        // itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            LocationCard(
                          title: loc_list[index].name,
                          location: '',
                          rating: 4,
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
        });
}
