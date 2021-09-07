import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/location_card.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      const Center(child: Icon(Icons.alarm, size: 64.0, color: Colors.cyan)),
      const Center(child: Icon(Icons.alarm, size: 64.0, color: Colors.cyan)),
      const Center(child: Icon(Icons.forum, size: 64.0, color: Colors.blue)),
    ];

    final _kTabs = <Tab>[
      const Tab(
          child: Text(
        'Nearby Attractions',
        style: TextStyle(color: Color(0xFF757575)),
      )),
      const Tab(
          child: Text(
        'Nearby Hotels',
        style: TextStyle(color: Color(0xFF757575)),
      )),
      const Tab(
          child: Text(
        'Nearby Restuarants',
        style: TextStyle(color: Color(0xFF757575)),
      )),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: new Container(
            // color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new TabBar(
                  tabs: _kTabs,
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: _kTabPages,
        ),
      ),
    );
  }
}
