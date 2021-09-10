// import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    'channel ID',
    'channel name',
    'channel description',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  // Future<void> showNotifications() async {
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     "Notification Title",
  //     "This is the Notification Body!",
  //     NotificationDetails(android: _androidNotificationDetails),
  //   );
  // }

  // Future<void> scheduleNotifications() async {
  //   int daysBetween(DateTime from, DateTime to) {
  //     from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
  //     to = DateTime(to.year, to.month, to.day, from.hour, from.minute);
  //     return (to.difference(from).inSeconds / 60).round();
  //   }

  Future<void> scheduleNotifications({title, body, time}) async {
    daysBetween(DateTime to) {
      DateTime start = DateTime.now();
      DateTime end = to;
      return (end.difference(start).inSeconds);
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(
          // const Duration(seconds: 5),
          Duration(seconds: daysBetween(time)),
        ),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);

    // print(DateTime.now().difference(DateTime(1998, 11, 07)).inMinutes);
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future selectNotification(String? payload) async {}
}




// Scheduling trigger  - use this to shcedule a notification

//               RaisedButton(
//                 child: Text('Show Notification'),
//                 padding: const EdgeInsets.all(10),
//                 onPressed: () async {
//                   await _notificationService.scheduleNotifications(
//                       title: "New Timing",
//                       body: "Fun not",
//                       time: DateTime.parse("2021-09-09 13:42:00"));
//                 },
//               ),            
