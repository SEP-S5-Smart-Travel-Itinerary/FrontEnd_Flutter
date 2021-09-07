import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.notifications),
        backgroundColor: PrimaryColor,
        title: Text('Notifications'),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Builder(
        builder: (BuildContext context) => ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 15,
            padding: EdgeInsets.only(left: 10, top: 15),
            itemBuilder: (BuildContext context, int index) => Card()),
      ),
    );
  }
}
