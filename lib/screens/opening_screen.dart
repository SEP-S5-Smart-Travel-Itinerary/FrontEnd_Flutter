import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/assets/font_size.dart';
import 'package:frontend_flutter/widgets/Logo.dart';
import 'package:frontend_flutter/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';

class OpeningScreen extends StatefulWidget {
  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
    });
    super.initState();
    // new Timer(const Duration(seconds: 2), onClose);
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SignInScreen())));

    return Scaffold(
      backgroundColor: SecondayColorBlue,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.64,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Logo(
                      logoSize: OpeningLogoSize,
                    ),
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SMART TRAVEL PLANNER',
                      style: TextStyle(color: PrimaryColor, letterSpacing: 4),
                    ),
                  ]),
            )
          ],
        ),
      )),
    );
  }

  // void onClose() {
  //   Navigator.of(context).pushReplacement(new PageRouteBuilder(
  //       maintainState: true,
  //       opaque: true,
  //       pageBuilder: (context, _, __) => new Calculator(),
  //       transitionDuration: const Duration(milliseconds: 700),
  //       transitionsBuilder: (context, anim1, anim2, child) {
  //         var begin = Offset(1.0, 0.0);
  //         var end = Offset.zero;
  //         var curve = Curves.ease;

  //         var tween =
  //             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //         return new SlideTransition(
  //           position: anim1.drive(tween),
  //           child: child,
  //         );
  //       }));
  // }
}
