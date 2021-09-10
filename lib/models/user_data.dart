import 'package:hive/hive.dart';

// part 'user_data.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int username;

  @HiveField(2)
  double longitude;

  @HiveField(3)
  double latitude;

  UserData(
      {required this.id,
      required this.username,
      this.longitude = 0,
      this.latitude = 0});
}
