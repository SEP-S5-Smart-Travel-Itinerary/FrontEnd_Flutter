import 'dart:ui';
import 'package:flutter/material.dart';

class FlightData {
  String currency;
  String total;

  FlightData({
    required this.currency,
    required this.total,
  });

  factory FlightData.fromJson(Map<dynamic, dynamic> json) {
    return FlightData(
      currency: json['currency'],
      total: json['total'],
    );
  }
}
