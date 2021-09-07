import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';

class AddFriendsDialog extends StatefulWidget {
  @override
  _AddFriendsDialogState createState() => _AddFriendsDialogState();
}

class _AddFriendsDialogState extends State<AddFriendsDialog> {
  List<String> _friends = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: Text('Plan a new trip'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 30.0),

              Text(
                'Add Trip Mates',
                style: TextStyle(color: PrimaryColor),
              ),
              SizedBox(height: 5),

              // Add countries
              TextFormField(
                cursorColor: PrimaryColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                  filled: true,
                  fillColor: SecondayColorBlue,
                  labelText: 'Add Trip Mates',
                  labelStyle: TextStyle(color: PrimaryColor),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(color: PrimaryColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(color: PrimaryColor, width: 2),
                  ),
                ),
                // onChanged: (String? value) {
                //   this._budget = value;
                //   print('name=$_budget');
                // },
                // validator: _validateName,
              ),

              SizedBox(
                height: 30,
              ),

              ElevatedButton(
                onPressed: () {},
                child: Container(
                    height: 50,
                    child: Center(
                        child: const Text(
                      'Add Trip Mates',
                      style: TextStyle(fontSize: 18),
                    ))),
                style: ElevatedButton.styleFrom(
                  primary: PrimaryColor,
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Continue without trip mates',
                    style: TextStyle(color: PrimaryColor),
                  ))
            ],
          ),
        ));
  }
}
