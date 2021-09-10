import 'package:hive/hive.dart';

import 'package:frontend_flutter/models/location_data.dart';
import 'package:frontend_flutter/models/transport_data.dart';
import 'package:frontend_flutter/models/user_data.dart';

// part 'plan_data.g.dart';

@HiveType(typeId: 2)
class PlanData {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime created;

  @HiveField(3)
  double version;

  @HiveField(4)
  double? init_budget;

  @HiveField(5)
  double? tot_budget;

  @HiveField(6)
  DateTime start_date;

  @HiveField(7)
  DateTime end_date;

  @HiveField(8)
  UserData admin;

  @HiveField(9)
  late final List<LocationData> locations = [];

  @HiveField(10)
  late final List<TransportData> transport = [];

  @HiveField(11)
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
