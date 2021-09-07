import 'dart:ui';

import 'package:flutter/material.dart';

class NewTaskModal extends StatelessWidget {
  const NewTaskModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.only(top: 25, left: 30, right: 30, bottom: 25),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(children: [
            Text(
              'Add task',
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 25),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(),
          ]),
        ));
  }
}

class ButtonTheme extends StatelessWidget {
  const ButtonTheme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(color: Colors.lightBlueAccent),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () {},
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
