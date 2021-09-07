import 'package:frontend_flutter/models/location_data.dart';
import 'package:frontend_flutter/models/transport_data.dart';
import 'package:frontend_flutter/models/user_data.dart';

class PlanData {
  int id;
  String name;
  DateTime created;
  double version;
  double? init_budget;
  double? tot_budget;
  DateTime start_date;
  DateTime end_date;
  UserData admin;
  late final List<LocationData> locations = [];
  late final List<TransportData> transport = [];
  late final List<UserData> travel_mates = [];

  PlanData({
    required this.id,
    required this.name,
    required this.created,
    this.version = 1.0,
    this.init_budget,
    this.tot_budget,
    required this.start_date,
    required this.end_date,
    required this.admin,
  });
}
