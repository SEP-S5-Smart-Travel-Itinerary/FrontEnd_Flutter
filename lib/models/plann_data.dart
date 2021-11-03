class PlannDataInit {
  String name;
  List type;
  var rating;
  String place_id;
  var imagelink;
  String startTime;
  String endTime;
  String latitude;
  String longitude;

  PlannDataInit(
      {required this.name,
      required this.type,
      this.rating,
      required this.startTime,
      required this.endTime,
      required this.latitude,
      required this.longitude,
      required this.place_id,
      this.imagelink});

  factory PlannDataInit.fromJson(Map<String, dynamic> json) {
    return PlannDataInit(
        name: json['name'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        type: json['type'],
        rating: json['rating'],
        place_id: json['place_id'],
        imagelink: json['imagelink']);
  }
}
