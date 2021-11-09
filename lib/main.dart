import 'package:flutter/material.dart';
import 'package:frontend_flutter/services/local_notification_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/appdata.dart';
import 'package:provider/provider.dart';
import '/screens/opening_screen.dart';

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
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Roboto'),
          home: OpeningScreen(),
        ));
  }
}
