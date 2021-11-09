import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_flutter/assets/colors.dart';
import '../widgets/rounded_button_with_icon.dart';
import 'package:frontend_flutter/widgets/logo.dart';
import 'package:frontend_flutter/assets/font_size.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../controller/user_controller.dart';

import 'signin_screen.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isKeyboardOpen = false;
  String email = "";
  String password = "";
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (mounted == true) {
        setState(() {
          _isKeyboardOpen = visible;
        });
      }
    });
  }

  // // google sign in function
  // Future googleSignIn() async {

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _isKeyboardOpen
                    ? Container(
                        height: 1,
                      )
                    : Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Text(
                              'Welcome to',
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20,
                                  color: PrimaryColor),
                            ),
                            Logo(logoSize: LoginScreenLogoSize),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                'Travel changes you. As you move through this life and this world, you change things slightly, you leave marks behind, however small. And in return, life — and travel — leaves marks on you.',
                                style: TextStyle(color: PrimaryColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),

                // SizedBox(
                //   height: 15,
                // ),
                Column(children: [
                  _isKeyboardOpen
                      ? Container(
                          height: 1,
                        )
                      : Container(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Column(children: [
                            Lottie.network(
                                'https://assets10.lottiefiles.com/datafiles/AtGF4p7zA8LpP2R/data.json',
                                height: 200,
                                width: 200)
                          ]),
                        ),
                  SizedBox(
                    height: 15,
                  ),

                  //login with email container

                  Container(
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formkey,
                      child: Column(children: [
                        TextFormField(
                          initialValue: '',
                          validator: (_val) {
                            if (_val == "") {
                              return "Email cannot be empty";
                            } else if (RegExp(
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                .hasMatch(_val!)) {
                              return null;
                            } else {
                              return "Enter valid Email";
                            }
                          },
                          onChanged: (val) {
                            if (mounted == true) {
                              setState(() {
                                email = val;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: '',
                          validator: (_val) {
                            if (_val == "") {
                              return "Password cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            if (mounted == true) {
                              setState(() {
                                password = val;
                              });
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LoginButton(
                          text: 'Sign up with Email',
                          imagePath: 'icons/email_icon.png',
                          color: Colors.black,
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              signUp(email, password, context);
                            } else {
                              print("not ok");
                            }
                          },

                          // onPressed: () => signUp(email, password).whenComplete(
                          //     () => Navigator.of(context).pushReplacement(
                          //         MaterialPageRoute(
                          //             builder: (context) => SignInScreen()))),
                        ),
                      ]),
                    ),
                  ),

                  //end of login with email container

                  SizedBox(
                    height: 15,
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => SignInScreen()));
                    },
                    child: Text("Already a member ? Sign in here",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: PrimaryColor,
                        )),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
