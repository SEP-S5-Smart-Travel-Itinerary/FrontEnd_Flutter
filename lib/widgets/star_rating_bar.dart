import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRatingBar extends StatelessWidget {
  final double ratings;
  const StarRatingBar({required this.ratings});

  @override
  Widget build(BuildContext context) {
    return RatingBar(
        allowHalfRating: true,
        initialRating: ratings,
        itemSize: 13.5,
        itemPadding: EdgeInsets.all(1),
        glowColor: Colors.green,
        unratedColor: Colors.green,
        ratingWidget: RatingWidget(
            full: Image(
              image: AssetImage('icons/heart.png'),
              color: Color(0xFF03DAC6),
            ),
            half: Image(
                image: AssetImage('icons/heart_half.png'),
                color: Color(0xFF03DAC6)),
            empty: Image(
              image: AssetImage('icons/heart_border.png'),
              color: Color(0xFF03DAC6),
            )),
        onRatingUpdate: (rating) {
          print(rating);
        });
  }
}
