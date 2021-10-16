import 'package:flutter/material.dart';
import 'assets/colors.dart';

import 'screens/home_screen.dart';
import 'screens/bookmarks_screen.dart';
import 'screens/flight_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/travel_plans_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _selectedPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: PrimaryColor,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: BottomIcon(path: "icons/compass_icon.png"),
                  onPressed: () {
                    setState(() {
                      _selectedPage.jumpToPage(0);
                    });
                  }),
              IconButton(
                  icon: BottomIcon(path: "icons/bookmark_icon.png"),
                  onPressed: () {
                    setState(() {
                      _selectedPage.jumpToPage(1);
                    });
                  }),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              IconButton(
                  icon: BottomIcon(path: "icons/airport.png"),
                  onPressed: () {
                    setState(() {
                      _selectedPage.jumpToPage(2);
                    });
                  }),
              IconButton(
                  icon: BottomIcon(path: "icons/user_icon.png"),
                  onPressed: () {
                    setState(() {
                      _selectedPage.jumpToPage(3);
                    });
                  }),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _selectedPage,
        children: <Widget>[
          Home(),
          Bookmarks(),
          FlightDetails(),
          Settings(),
          TravelPlan(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              heroTag: 'main',
              backgroundColor: PrimaryColor,
              child: BottomIcon(
                path: "icons/globe_icon.png",
              ),
              onPressed: () {
                setState(() {
                  _selectedPage.jumpToPage(4);
                });
              })
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class BottomIcon extends StatelessWidget {
  final String path;

  const BottomIcon({required this.path});

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: null),
      child: Image(
        image: AssetImage(path),
        width: MediaQuery.of(context).size.height * 0.05,
        height: MediaQuery.of(context).size.height * 0.05,
        color: Colors.white,
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
      ),
    );
  }
}
