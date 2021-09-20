import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:frontend_flutter/widgets/rounded_button_with_icon.dart';
import '../services/authentication_service.dart';

import 'signin_screen.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  File? _imageFile;
  final _picker = ImagePicker();
  final String name = 'Pasan madushan';
  final String email = 'pasan.18@cse.mrt.ac.lk';
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
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/8/85/Elon_Musk_Royal_Society_%28crop1%29.jpg"),
                backgroundColor: Colors.transparent,
              ),
              IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () async => _pickImageFromGallery()),
              Text(
                name,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: SecondaryColorDarkGrey),
              ),
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
              LoginButton(
                text: 'Logout',
                imagePath: "icons/logout.png",
                color: Colors.red.withOpacity(0.8),
                onPressed: () => signOutUser().whenComplete(() =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SignInScreen()))),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
            ],
          ),
        )));
  }
}
