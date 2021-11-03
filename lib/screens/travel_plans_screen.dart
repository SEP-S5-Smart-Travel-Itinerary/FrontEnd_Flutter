import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/plan_controller.dart';
import 'package:frontend_flutter/models/plandetail_init.dart';
import 'package:frontend_flutter/widgets/plans_view.dart';
import 'package:frontend_flutter/widgets/new_trip_form.dart';
import 'package:frontend_flutter/widgets/add_friends_form.dart';
import 'package:frontend_flutter/widgets/travel_plan_card.dart';

class TravelPlan extends StatefulWidget {
  const TravelPlan({Key? key}) : super(key: key);

  @override
  _TravelPlanState createState() => _TravelPlanState();
}

class _TravelPlanState extends State<TravelPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Travel Plans'),
        backgroundColor: PrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: getPalns(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                List<PlanDetailInit> locList = snapshot.data;
                //print(locList[0].plan_id);
                return ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: locList.length,
                  padding: EdgeInsets.only(left: 10, top: 15),
                  //scrollDirection: Axis.horizontal,
                  // itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) => TravelCard(
                    title: locList[index].name,
                    plan_id: locList[index].plan_id,
                    //imageUrl:"",
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text("$snapshot.error");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          heroTag: 'addnew',
          backgroundColor: Color(0xFFFF5722).withOpacity(0.8),
          icon: const Icon(Icons.add),
          label: Text('Create Plan'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => FullScreenDialog(),
                // builder: (BuildContext context) => AddFriendsDialog(),
                fullscreenDialog: true,
              ),
            );
          }),
    );
  }
}

// Form overlay