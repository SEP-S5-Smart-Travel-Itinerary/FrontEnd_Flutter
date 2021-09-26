import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/add_location.dart';
import '../assets/colors.dart';
import 'package:http/http.dart' as http;

class SearchScreenForPlan extends StatefulWidget {
  const SearchScreenForPlan({Key? key}) : super(key: key);

  @override
  _SearchScreenForPlanState createState() => _SearchScreenForPlanState();
}

class _SearchScreenForPlanState extends State<SearchScreenForPlan> {
  List predictions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
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
        title: Text("Search Travel Attractions"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              cursorColor: PrimaryColor,
              decoration: InputDecoration(
                focusColor: PrimaryColor,
                filled: true,
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.white,
                hintText: 'Search cities and attractions',
                // labelText: 'Search cities and attractions',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
              onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(predictions[index]),
                      onTap: () {
                        Navigator.push(
                        context, planPlaceScreen2(title: predictions[index]));
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      )),
    );
  }
  void autoCompleteSearch(String value) async {
    var url = Uri.parse("http://localhost:3000/apiuser/auto");

  var response = await http
      .post(url, body: {"place": value});
    print("sucess called");
    //List jsonResponse = json.decode(response.body)["data"];
    // print(jsonResponse);
    setState(() {
        predictions = json.decode(response.body)["data"];
        print (predictions);
      });
  
  }
}
