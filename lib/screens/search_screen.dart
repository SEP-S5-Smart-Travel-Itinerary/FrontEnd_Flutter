import 'package:flutter/material.dart';
import '../assets/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
            ),
          ],
        ),
      )),
    );
  }
}
