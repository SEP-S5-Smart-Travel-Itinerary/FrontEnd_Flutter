import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/widgets/changeName.dart';
import 'package:frontend_flutter/widgets/changePassword.dart';
import 'package:frontend_flutter/widgets/logo.dart';
import 'package:frontend_flutter/widgets/rounded_button_without_icon.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:frontend_flutter/widgets/rounded_button_with_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_flutter/controller/globals.dart' as globals;

import 'signin_screen.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  File? _imageFile;
  final _picker = ImagePicker();
  final String name = globals.currentUserUsername;
  final String email = globals.currentUserEmail;
  final bool notify = true;

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => this._imageFile = File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.settings),
          backgroundColor: PrimaryColor,
          title: Text('Settings'),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),

              Text(
                "Welcome to  ",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    color: PrimaryColor),
              ),
              SizedBox(
                height: 15,
              ),
              Logo(logoSize: 40),
              SizedBox(
                height: 15,
              ),
              Text(
                "Hi " + name + " ! ",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: PrimaryColor),
              ),

              SizedBox(
                width: 10,
              ),

              Divider(),

              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Icon(
                    Icons.mail_rounded,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              // RoundedButton(
              //   text: "Edit User Details",
              //   color: PrimaryColor,
              //   onPressed: () => showModalBottomSheet(
              //       context: context, builder: (ctx) => _buildBottomSheet(ctx)),
              // ),
              RoundedButton(
                text: "Change Username",
                color: PrimaryColor,
                height: 150,
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ChangeName(text: "")));
                },
              ),
              SizedBox(
                height: 15,
              ),
              RoundedButton(
                text: "Change Password",
                color: PrimaryColor,
                height: 150,
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ChangePwd(text: "")));
                },
              ),
              SizedBox(
                height: 50,
              ),

              Divider(),
              SizedBox(
                height: 50,
              ),
              LoginButton(
                text: 'Logout',
                imagePath: "icons/logout.png",
                color: Colors.red.withOpacity(0.8),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('token', "");
                  globals.currentUserEmail = "";
                  globals.currentUserID = "";
                  globals.currentUserUsername = "";

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )));
  }
}
