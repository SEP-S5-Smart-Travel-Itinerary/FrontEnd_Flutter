class LocationDataInit {
  String name;
  List type;
  double? rating;
  String place_id;
  Object? imagelink;

  LocationDataInit(
      {required this.name,
      required this.type,
      this.rating,
      required this.place_id,
      this.imagelink});

  factory LocationDataInit.fromJson(Map<String, dynamic> json) {
    return LocationDataInit(
        name: json['name'],
        type: json['type'],
        rating: json['rating'],
        place_id: json['name'],
        imagelink: json['imagelink']);
  }
}
