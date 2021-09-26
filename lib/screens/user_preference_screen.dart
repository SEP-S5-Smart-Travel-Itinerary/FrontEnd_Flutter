import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:frontend_flutter/widgets/logo.dart';
import 'package:frontend_flutter/assets/font_size.dart';
import 'package:frontend_flutter/widgets/rounded_button_without_icon.dart';
import '../controller/user_controller.dart';
import '../main_screen.dart';

class UserPreference extends StatefulWidget {
  @override
  _UserPreferenceState createState() => _UserPreferenceState();
}

class _UserPreferenceState extends State<UserPreference> {
  List<String> options = [
    'Point of interest',
    'Town square',
    'Place of worship',
    'Natural feature',
    'Locality',
    'Landmark',
    'Health',
    'Food',
    'Neighborhood',
    'Country',
    'Continent',
    'Museum',
    'Zoo',
    'Movie Theatre',
    'Park'
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
                        '“Travel makes one modest. You see what a tiny place you occupy in the world” – Gustave Flaubert ',
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
                    onPressed: () => addPreferences(selectedChoices)
                        .whenComplete(() => Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                                builder: (context) => MainScreen()))),
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
