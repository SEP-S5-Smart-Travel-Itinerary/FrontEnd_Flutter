import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/controller/user_controller.dart';
import 'package:frontend_flutter/widgets/logo.dart';
import 'package:frontend_flutter/widgets/rounded_button_without_icon.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:frontend_flutter/widgets/rounded_button_with_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/authentication_service.dart';
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
              // CircleAvatar(
              //   radius: 70,
              //   backgroundImage: NetworkImage(
              //       "https://upload.wikimedia.org/wikipedia/commons/8/85/Elon_Musk_Royal_Society_%28crop1%29.jpg"),
              //   backgroundColor: Colors.transparent,
              // ),
              // IconButton(
              //     icon: const Icon(Icons.photo),
              //     onPressed: () async => _pickImageFromGallery()),
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
                height: 15,
              ),
              RoundedButton(
                text: "Edit User Details",
                color: PrimaryColor,
                onPressed: () => showModalBottomSheet(
                    context: context, builder: (ctx) => _buildBottomSheet(ctx)),
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

// modal bottom sheet for options
Container _buildBottomSheet(BuildContext context) {
  return Container(
    height: 350,
    // padding: const EdgeInsets.fromLTRB(8, top, right, bottom)
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: PrimaryColor),
        ),
        color: SecondayColorBlue),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 50),
        child: Column(
          children: <Widget>[
            RoundedButton(
              text: "Change Username",
              color: PrimaryColor,
              height: 150,
              onPressed: () => showModalBottomSheet(
                  // isScrollControlled: true,
                  context: context,
                  builder: (ctx) => _buildBottomSheetChangeUsername(ctx)),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              text: "Change Password",
              color: PrimaryColor,
              height: 150,
              onPressed: () => showModalBottomSheet(
                  // isScrollControlled: true,
                  context: context,
                  builder: (ctx) => _buildBottomSheetChangePassword(ctx)),
            ),
          ],
        ),
      ),
    ),
  );
}

//change plan name
Container _buildBottomSheetChangeUsername(BuildContext context) {
  GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();
  String? new_username;
  return Container(
    // padding: const EdgeInsets.fromLTRB(8, top, right, bottom)
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: PrimaryColor),
        ),
        color: SecondayColorBlue),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 50),
        child: Form(
          key: _formkey1,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: '',
                // controller: this._emailController,
                decoration: InputDecoration(
                  labelText: 'New Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                validator: (_val) {
                  if (_val == "") {
                    return "username cannot be empty";
                  } else {
                    return null;
                  }
                },
                onChanged: (String? value) {
                  new_username = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              RoundedButton(
                text: "Change Username",
                color: PrimaryColor,
                height: 150,
                onPressed: () {
                  if (_formkey1.currentState!.validate()) {
                    changeUsername(new_username).then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Settings())));
                  } else {
                    print("not ok");
                  }

                  //
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

//change plan name
Container _buildBottomSheetChangePassword(BuildContext context) {
  GlobalKey<FormState> _formkey2 = GlobalKey<FormState>();
  String? new_password;
  return Container(
    // padding: const EdgeInsets.fromLTRB(8, top, right, bottom)
    decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 5, color: PrimaryColor),
        ),
        color: SecondayColorBlue),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 50),
        child: Form(
          key: _formkey2,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: '',
                // controller: this._emailController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                validator: (_val) {
                  if (_val == "") {
                    return "password cannot be empty";
                  } else {
                    return null;
                  }
                },
                onChanged: (String? value) {
                  new_password = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              RoundedButton(
                text: "Change Password",
                color: PrimaryColor,
                height: 150,
                onPressed: () {
                  if (_formkey2.currentState!.validate()) {
                    changePassword(new_password).then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Settings())));
                  } else {
                    print("not ok");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
