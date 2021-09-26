import 'package:flutter/material.dart';
import 'package:frontend_flutter/services/local_notification_manager.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:frontend_flutter/widgets/rounded_button_with_icon.dart';
import 'models/appdata.dart';
import 'package:provider/provider.dart';
import '/screens/opening_screen.dart';
import '/screens/signup_screen.dart';
import 'screens/signin_screen.dart';
import 'package:frontend_flutter/screens/user_preference_screen.dart';
import 'screens/get_started_screen.dart';
import 'screens/home_screen.dart';
import 'screens/attraction_screen.dart';
import 'main_screen.dart';
import 'screens/travel_plans_screen.dart';
import 'services/location.dart';

import 'screens/travel_plan_view.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppData(),
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'Roboto'),
          home: MainScreen(),
          // home: Attraction(
          //   name: "abcd",
          // ),
          // home: UserPreference()
          // home: TravelPlan()),
          // home: TravelPlanView(),
        ));
  }
}
