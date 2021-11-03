import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/widgets/logo.dart';
import 'package:frontend_flutter/assets/font_size.dart';
import 'package:frontend_flutter/widgets/rounded_button_without_icon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../controller/user_controller.dart';
import '../main_screen.dart';

class UserPreference extends StatefulWidget {
  @override
  _UserPreferenceState createState() => _UserPreferenceState();
}

class _UserPreferenceState extends State<UserPreference> {
  List<String> options = [
    'point_of_interest',
    'town_square',
    'place_of_worship',
    'natural_feature',
    'locality',
    'landmark',
    'health',
    'food',
    'neighborhood',
    'country',
    'continent',
  ];

  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];
    options.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              // print(selectedChoices);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Welcome to',
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 20,
                            color: PrimaryColor),
                      ),
                      Logo(logoSize: LoginScreenLogoSize),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Lorem Ipsum is abcdedffdfd simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy ',
                        style: TextStyle(color: PrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Column(children: [
                  Text(
                    'Select your preferred travel experiences.',
                    style: TextStyle(
                        color: PrimaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    children: _buildChoiceList(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RoundedButton(
                    text: "Next   >",
                    color: PrimaryColor,
                    // onPressed: () => addPreferences(selectedChoices)
                    //     .whenComplete(() => Navigator.of(context)
                    //         .pushReplacement(MaterialPageRoute(
                    //             builder: (context) => MainScreen()))),
                    onPressed: () {
                      if (selectedChoices.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Preferences not selected",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: PrimaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        addPreferences(selectedChoices, context);
                      }
                    },
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
