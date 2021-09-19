import 'package:hive/hive.dart';

// part 'location_data.g.dart';

enum Types { attraction, restuarant, hotel }

@HiveType(typeId: 1)
class LocationData {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  Types type;

  @HiveField(3)
  String description;

  @HiveField(4)
  double longitude;

  @HiveField(5)
  double latitude;

  @HiveField(6)
  double ratings;

  @HiveField(7)
  double fee;

  String currentWeather;

  LocationData(
      {required this.id,
      required this.name,
      this.type = Types.attraction,
      required this.description,
      required this.longitude,
      required this.latitude,
      this.ratings = 0.0,
      this.fee = 0.0,
      this.currentWeather = 'no weather data'});
}
