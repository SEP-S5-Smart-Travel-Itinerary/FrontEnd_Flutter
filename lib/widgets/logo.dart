import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';

class Logo extends StatelessWidget {
  final double logoSize;
  final Color color;

  const Logo({required this.logoSize, this.color = PrimaryColor});

  @override
  Widget build(BuildContext context) {
    return Text('STAR TRIPS',
        style: TextStyle(
            fontFamily: 'Aquatico', fontSize: logoSize, color: color));
  }
}
