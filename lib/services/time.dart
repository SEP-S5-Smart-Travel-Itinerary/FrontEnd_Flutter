import 'package:intl/intl.dart';

class CurrentDateTime {
  DateTime now = new DateTime.now();

  String getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  String getCurrentTime() {
    return DateFormat('hh:mm').format(DateTime.now());
  }
}
