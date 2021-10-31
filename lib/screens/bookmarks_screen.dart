import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/book_ctrl.dart';
import 'package:frontend_flutter/models/book_init.dart';
//import 'package:frontend_flutter/models/location_data_initial.dart';
import 'package:frontend_flutter/widgets/location_card.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({Key? key}) : super(key: key);

  get child => null;

  get loclist => null;

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
      body: FutureBuilder(
        future: fetchBookmarks(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<BookDataInit> loclist = snapshot.data;
            List<BookDataInit> list = [];
                      for(var i = 0; i < loclist.length; i++){
                        print(loclist[i].imagelink);
                        if(loclist[i].imagelink!=null){
                          print("hjk");
                              list.add(loclist[i]);
                        }
                          }

            //print(locList[0].rating);
            return ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              padding: EdgeInsets.only(left: 10, top: 15),
              //scrollDirection: Axis.horizontal,
              // itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) => LocationCard(
                  title: list[index].name,
                  location: "", //'Victorial Park of Nuwara Eliya',
                  rating: 4,
                  locationId: list[index].place_id,
                  imageUrl:list[index].imagelink[0]["photo_reference"],
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
    // Builder(
    //   builder: (BuildContext context) => ListView.builder(
    //     physics: ClampingScrollPhysics(),
    //     shrinkWrap: true,
    //     itemCount: 15,
    //     padding: EdgeInsets.only(left: 10, top: 15),
    //     itemBuilder: (BuildContext context, int index) => LocationCard(
    //       title: 'Victorial Park of Nuwara Eliya',
    //       location: 'Nuwara Eliya',
    //       rating: 4,
    //     ),
    //   ),
    // ),
  }
}
