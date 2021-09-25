import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/services.dart';
import '../controller/plan_controller.dart';
import 'add_friends_form.dart';

class FullScreenDialog extends StatefulWidget {
  @override
  _FullScreenDialogState createState() => _FullScreenDialogState();
}

class _FullScreenDialogState extends State<FullScreenDialog> {
  String? _name;
  int? _budget;
  DateTime? _startDate;
  DateTime? _endDate;

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
              // Name texfield
              Text(
                'Name the tour',
                style: TextStyle(color: PrimaryColor),
              ),
              SizedBox(height: 5),
              TextFormField(
                cursorColor: PrimaryColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.trip_origin),
                  filled: true,
                  fillColor: SecondayColorBlue,
                  labelText: 'Trip Name',
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
                onChanged: (String? value) {
                  setState(() {
                    this._name = value;
                  });
                },
              ),

              const SizedBox(height: 24.0),

              // date range
              Text(
                'Select the dates of the trip',
                style: TextStyle(color: PrimaryColor),
              ),

              DateRangeField(
                  firstDate: DateTime(2020),
                  enabled: true,
                  initialValue: DateTimeRange(
                      start: DateTime.now(),
                      end: DateTime.now().add(Duration(days: 5))),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    filled: true,
                    fillColor: SecondayColorBlue,
                    labelText: 'Trip Dates',
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
                  validator: (value) {
                    if (value!.start.isBefore(DateTime.now())) {
                      return 'Please enter a later start date';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _startDate = value!.start;
                      _endDate = value.end;
                    });
                  }),

              const SizedBox(height: 15.0),

              Text(
                'Enter the travel budget',
                style: TextStyle(color: PrimaryColor),
              ),
              SizedBox(height: 5),

              // Budget texfield
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                cursorColor: PrimaryColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                  filled: true,
                  fillColor: SecondayColorBlue,
                  labelText: 'Travel Budget (optional)',
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
                onChanged: (String value) {
                  setState(() {
                    this._budget = int.parse(value);
                  });
                },
                // validator: _validateName,
              ),

              const SizedBox(height: 24.0),

              Text(
                'Add Countries',
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
                  labelText: 'Add Countries',
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
                onChanged: (String? value) {
                  // this._budget = value;
                  // print('name=$_budget');
                },
                // validator: _validateName,
              ),

              SizedBox(
                height: 24,
              ),

              ElevatedButton(
                onPressed: () {
                  createItin(_name, _budget, _startDate, _endDate);
                  Navigator.push(
        context, new MaterialPageRoute(builder: (context) => AddFriendsDialog()));
                  // print(_name);
                  // print(_budget);
                  // print(_startDate);
                  // print(_endDate);
                },
                child: Container(
                    height: 50,
                    child: Center(
                        child: const Text(
                      'Start Planning',
                      style: TextStyle(fontSize: 18),
                    ))),
                style: ElevatedButton.styleFrom(
                  primary: PrimaryColor,
                ),
              ),
            ],
          ),
        ));
  }
}

// ----------------------

// class TextFormFieldExample extends StatefulWidget {
//   const TextFormFieldExample({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _TextFormFieldExampleState();
// }

// // Adapted from the text form demo in official gallery app:
// // https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/text_form_field_demo.dart
// class _TextFormFieldExampleState extends State<TextFormFieldExample> {
//   final GlobalKey<FormFieldState<String>> _passwordFieldKey =
//       GlobalKey<FormFieldState<String>>();

//   String? _name;
//   String? _phoneNumber;
//   String? _email;
//   String? _password;

//   String? _validateName(String? value) {
//     if (value?.isEmpty ?? false) {
//       return 'Name is required.';
//     }
//     final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
//     if (!nameExp.hasMatch(value!)) {
//       return 'Please enter only alphabetical characters.';
//     }
//     return null;
//   }

//   }
// }

// class PasswordField extends StatefulWidget {
//   const PasswordField({
//     this.fieldKey,
//     this.hintText,
//     this.labelText,
//     this.helperText,
//     this.onSaved,
//     this.validator,
//     this.onFieldSubmitted,
//   });

//   final Key? fieldKey;
//   final String? hintText;
//   final String? labelText;
//   final String? helperText;
//   final FormFieldSetter<String>? onSaved;
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<String>? onFieldSubmitted;

//   @override
//   _PasswordFieldState createState() => _PasswordFieldState();
// }

// class _PasswordFieldState extends State<PasswordField> {
//   bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       key: widget.fieldKey,
//       obscureText: _obscureText,
//       maxLength: 8,
//       onSaved: widget.onSaved,
//       validator: widget.validator,
//       onFieldSubmitted: widget.onFieldSubmitted,
//       decoration: InputDecoration(
//         border: const UnderlineInputBorder(),
//         filled: true,
//         hintText: widget.hintText,
//         labelText: widget.labelText,
//         helperText: widget.helperText,
//         suffixIcon: GestureDetector(
//           onTap: () {
//             setState(() {
//               _obscureText = !_obscureText;
//             });
//           },
//           child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
//         ),
//       ),
//     );
//   }
// }
