import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  final Color color;
  final Color fontColor;
  final Color borderColor;

  const RoundedButton(
      {required this.text,
      this.onPressed,
      required this.color,
      this.fontColor = Colors.white,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: this.color,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 10, right: 10),
            primary: Colors.white,
            textStyle: const TextStyle(fontSize: 18),
          ),
          onPressed: () {},
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  this.text,
                  style: TextStyle(fontSize: 18, color: this.fontColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
