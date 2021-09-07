import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/widgets/plans_view.dart';
import 'package:frontend_flutter/widgets/new_trip_form.dart';
import 'package:frontend_flutter/widgets/add_friends_form.dart';

class TravelPlan extends StatefulWidget {
  const TravelPlan({Key? key}) : super(key: key);

  @override
  _TravelPlanState createState() => _TravelPlanState();
}

class _TravelPlanState extends State<TravelPlan> {
  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      Container(
        child: Text('No ongoing trips'),
      ),
      PlansView(),
      PlansView(),
    ];
    final _kTabs = <Tab>[
      const Tab(text: 'Ongoing'),
      const Tab(text: 'Planned'),
      const Tab(text: 'Completed'),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Travel Plans'),
          backgroundColor: PrimaryColor,
          bottom: TabBar(
            tabs: _kTabs,
          ),
        ),
        body: TabBarView(
          children: _kTabPages,
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
                  // builder: (BuildContext context) => FullScreenDialog(),
                  builder: (BuildContext context) => AddFriendsDialog(),
                  fullscreenDialog: true,
                ),
              );
            }),
      ),
    );
  }
}

// Form overlay

