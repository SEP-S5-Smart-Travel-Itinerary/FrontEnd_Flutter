import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/plan_controller.dart';
import 'package:frontend_flutter/models/book_init.dart';
import 'package:frontend_flutter/models/plann_data.dart';
import 'package:frontend_flutter/models/travel_plan.dart';
import 'package:frontend_flutter/screens/home_screen.dart';
import 'package:frontend_flutter/widgets/add_friends_form.dart';
import 'package:frontend_flutter/widgets/change_plan_budget.dart';
import 'package:frontend_flutter/widgets/change_plan_name.dart';
import 'package:frontend_flutter/widgets/change_travel_dates.dart';
import '../main_screen.dart';
import '../widgets/travel_plan_view_location_card.dart';
import '../widgets/travel_plan_transport_card.dart';
import '../widgets/travel_plan_add_location.dart';
import '../widgets/rounded_button_without_icon.dart';
import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:frontend_flutter/controller/globals.dart' as globals;

class TravelPlanView extends StatefulWidget {
  @override
  _TravelPlanViewState createState() => _TravelPlanViewState();
}

class _TravelPlanViewState extends State<TravelPlanView> {
  List _listings = [];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => showModalBottomSheet(
                  context: context, builder: (ctx) => _buildBottomSheet(ctx)),
            ),
            SizedBox(
              width: 10,
            )
          ],
          backgroundColor: PrimaryColor,
          title: Text(globals.Name),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 130,
                color: SecondayColorBlue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  globals.startdatestring,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " - ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  globals.enddatestring,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // TextButton(
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           new MaterialPageRoute(
                          //               builder: (context) => AddFriendsDialog(text: "")));
                          //       },
                          //       child: Text(
                          //         'add a member',
                          //         style: TextStyle(color: Colors.red),
                          //       )),
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: SecondaryColorDarkGrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'TRAVEL BUDGET',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      globals.InitialBudget.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    // Text(
                                    //   ' / ',
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.white),
                                    // ),
                                    // Text(
                                    //   '750',
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.white),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            AddFriendsDialog(text: "")));
                              },
                              child: Text(
                                'add a member',
                                style: TextStyle(color: Colors.red),
                              )),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: PrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      globals.TripMates.length.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'members',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 5,
                color: PrimaryColor,
              ),

              // plan section
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    // travel plan add location
                    TravelPlanAddLocation(),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(),

                    // travel plan travel locations

                    Text(
                      'Travelling Locations',
                      style: TextStyle(color: PrimaryColor),
                    ),

                    FutureBuilder(
                      future: fetchPlanLocationList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          List<PlannDataInit> loc_list = snapshot.data;
                          List<PlannDataInit> list = [];
                          for (var i = 0; i < loc_list.length; i++) {
                            print(loc_list[i].imagelink);
                            if (loc_list[i].imagelink != null) {
                              print("hjk");
                              list.add(loc_list[i]);
                            }
                          }

                          return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: list.length,
                            padding: EdgeInsets.only(left: 10, top: 15),
                            //scrollDirection: Axis.horizontal,
                            // itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) =>
                                TravelPlanLocationCard(
                              title: list[index].name,
                              location: list[index]
                                  .type[0], //'Victorial Park of Nuwara Eliya',
                              rating: list[index].rating ?? 4,
                              id: index + 1,
                              locationId: list[index].place_id,
                              start: list[index].startTime,
                              end: list[index].endTime,
                              lat: list[index].latitude,
                              lon: list[index].longitude,
                              imageUrl: list[index].imagelink[0]
                                  ["photo_reference"],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          //return Text("$snapshot.error");
                          return Text("No Locations");
                        }
                        return CircularProgressIndicator();
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Divider(),

                    // travel plan transport details
                    Text(
                      'Transportation Mode',
                      style: TextStyle(color: PrimaryColor),
                    ),

                    FutureBuilder(
                      future: fetchTransportModes(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          List loc_list = snapshot.data;
                          List list2 = [];
                          for (var i = 1; i < loc_list.length; i++) {
                            list2.add(loc_list[i]);
                          }
                          print("tp list " + list2.toString());

                          return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: list2.length,
                            padding: EdgeInsets.only(left: 10, top: 15),
                            itemBuilder: (BuildContext context, int index) =>
                                TravelPlanTransportCard(
                              starting: index + 1,
                              ending: index + 2,
                              mode: list2[index],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          //return Text("$snapshot.error");
                          return Text("No Transport Modes");
                        }
                        return CircularProgressIndicator();
                      },
                    ),

                    // TravelPlanTransportCard(
                    //   starting: "1",
                    //   ending: "2",
                    //   mode: "Walk",
                    // ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

// modal bottom sheet for options
Container _buildBottomSheet(BuildContext context) {
  return Container(
    height: 350,
    // padding: const EdgeInsets.fromLTRB(8, top, right, bottom)
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: PrimaryColor),
        ),
        color: SecondayColorBlue),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 50),
        child: Column(
          children: <Widget>[
            RoundedButton(
              text: "Change Plan Name",
              color: PrimaryColor,
              height: 150,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => ChangePlanName(text: "")));
              },
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Edit Travel Budget",
              color: PrimaryColor,
              height: 150,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => ChangePlanBudget(text: "")));
              },
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // RoundedButton(
            //   text: "Edit Travel Dates",
            //   color: PrimaryColor,
            //   height: 150,
            //   onPressed: () {
            //     Navigator.pushReplacement(
            //         context,
            //         new MaterialPageRoute(
            //             builder: (context) => ChangePlanDates(text: "")));
            //   },
            // ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Delete Plan",
              color: Color(0xffC75151),
              height: 150,
              onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (ctx) => _buildBottomSheetDeletePlan(ctx)),
            )
          ],
        ),
      ),
    ),
  );
}

// Delete plan
Container _buildBottomSheetDeletePlan(BuildContext context) {
  return Container(
    // padding: const EdgeInsets.fromLTRB(8, top, right, bottom)
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: PrimaryColor),
        ),
        color: SecondayColorBlue),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 50),
        child: Column(
          children: <Widget>[
            Text(
              "Are you sure you want to delete this travel plan?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Delete Travel Plan",
              color: Color(0xffC75151),
              height: 150,
              onPressed: () {
                deletePlan(globals.createplan_id).then((value) =>
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TravelPlanView())));
              },
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Cancel",
              color: SecondaryColorDarkGrey,
              height: 150,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TravelPlanView()));
              },
            ),
          ],
        ),
      ),
    ),
  );
}
