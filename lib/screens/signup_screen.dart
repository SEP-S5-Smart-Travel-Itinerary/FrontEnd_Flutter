import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import '../widgets/rounded_button_with_icon.dart';
import 'package:frontend_flutter/widgets/logo.dart';
import 'package:frontend_flutter/assets/font_size.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

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
                Container(
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
                          'Lorem Ipsum is abcdedffdfd simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy ',
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
                  Container(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(children: [
                      LoginButton(
                        text: 'Sign up with Google',
                        imagePath: 'icons/google_icon.png',
                        color: Colors.white,
                        fontColor: PrimaryColor,
                        borderColor: Colors.black.withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      LoginButton(
                          text: 'Sign up with Facebook',
                          imagePath: 'icons/facebook_icon.png',
                          color: Color(0xFF1E4297),
                          borderColor: Color(0xFF1E4297)),
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
                    child: Column(children: [
                      TextFormField(
                        initialValue: '',
                        // controller: this._emailController,
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
                        // controller: this._passwordController,
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
                      ),
                    ]),
                  ),

                  //end of login with email container

                  SizedBox(
                    height: 15,
                  ),

                  Text("Already a member ? Sign in here",
                      style: TextStyle(
                        color: PrimaryColor,
                      ))
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
