import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';

class LocationBadge extends StatelessWidget {
  final String bannerType;
  // final Color bannerColor;
  // final List types = ["ATTRACTION","HOTEL","RESTUARANT"];

  static Color findColor(String name) {
    if (name == 'ATTRACTION') {
      return AttractionBadgeColor;
    } else if (name == 'HOTEL') {
      return HotelBadgeColor;
    } else {
      return RestaurantBadgeColor;
    }
  }

  const LocationBadge({required this.bannerType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 3, 3, 5),
      color: findColor(bannerType),
      child: Text(
        bannerType,
        style: TextStyle(fontSize: 10, color: Colors.white),
      ),
    );
  }
}
