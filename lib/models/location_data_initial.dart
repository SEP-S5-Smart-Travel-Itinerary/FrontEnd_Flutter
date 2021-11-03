import 'dart:ui';

import 'package:flutter/material.dart';

class LocationDataInit {
  String name;
  List type;
  var rating;
  String place_id;
  var imagelink;

  LocationDataInit(
      {required this.name,
      required this.type,
      this.rating,
      required this.place_id,
      this.imagelink});

  factory LocationDataInit.fromJson(Map<String, dynamic> json) {
    //print(json['imagelink']);
    var list = [];
    if (json['imagelink'] != null) {
      list = json['imagelink'];
    }

    return LocationDataInit(
        name: json['name'],
        type: json['type'],
        rating: json['rating'],
        place_id: json['place_id'],
        imagelink: json['imagelink']);
  }
}
