import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_flutter/models/flight_det.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:frontend_flutter/assets/colors.dart';
import 'package:flutter/services.dart';
import '../controller/flight_controller.dart';

class FlightDetails extends StatefulWidget {
  const FlightDetails({Key? key}) : super(key: key);

  @override
  State<FlightDetails> createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  String _origin = "BKK (Bankok)";
  String _destination = "BKK (Bankok)";
  DateTime _travelDate = DateTime.now();
  int _adults = 1;

  String _amount = '';
  String _currency = "EUR";

  static final DateFormat formatter = DateFormat('yyyy-MM-dd');

  // IATA codes list
  static const menuItems = <String>[
    'BKK (Bankok)',
    'PAR (Paris)',
    'BFS (Belfast UK)',
    'BIL (Bilings USA)',
    'BER (Berline Germany)',
    'IXG (Belgaum India)',
    'PEK (Beijing China)',
    'BIO (Bilbao Spain)',
    'BLQ (Bologna Italy)',
    'CMB (Colombo Sri Lanka)'
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.flight),
          backgroundColor: PrimaryColor,
          title: Text('Flight Details'),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 30.0),
              // Origin selection
              Text(
                'Origin Country',
                style: TextStyle(color: PrimaryColor),
              ),
              SizedBox(height: 5),

              ListTile(
                title: const Text('Select Origin Country'),
                trailing: DropdownButton<String>(
                  value: _origin,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _origin = newValue);
                    }
                  },
                  items: this._dropDownMenuItems,
                ),
              ),

              const SizedBox(height: 24.0),

              // Destination selection
              Text(
                'Destination Country',
                style: TextStyle(color: PrimaryColor),
              ),
              SizedBox(height: 5),

              ListTile(
                title: const Text('Select Destination Country'),
                trailing: DropdownButton<String>(
                  value: _destination,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _destination = newValue);
                    }
                  },
                  items: this._dropDownMenuItems,
                ),
              ),

              const SizedBox(height: 24.0),

              // date range
              Text(
                'Date',
                style: TextStyle(color: PrimaryColor),
              ),

              TextFormField(
                controller: TextEditingController(
                    text: formatter.format(_travelDate).toString()),
                cursorColor: PrimaryColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.trip_origin),
                  filled: true,
                  fillColor: SecondayColorBlue,
                  labelText: 'Date',
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
                onTap: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime.now(),

                    // onChanged: (date) {
                    //   print('change $date');
                    // },
                    onConfirm: (date) {
                      setState(() {
                        _travelDate = date;
                      });
                    },
                    currentTime: DateTime.now(),
                  );
                },
              ),

              const SizedBox(height: 15.0),

              Text(
                'Number of Adults',
                style: TextStyle(color: PrimaryColor),
              ),
              SizedBox(height: 5),

              // Adults texfield
              TextFormField(
                initialValue: _adults.toString(),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                cursorColor: PrimaryColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: SecondayColorBlue,
                  labelText: 'Enter Number of adults',
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
                    this._adults = int.parse(value);
                  });
                },
                // validator: _validateName,
              ),

              SizedBox(
                height: 24,
              ),

              ElevatedButton(
                onPressed: () async {
                  if (_origin == _destination) {
                    Fluttertoast.showToast(
                        msg: "Origin & Destination are same",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: PrimaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  } else {
                    var result = await getFlightRates(_origin, _destination,
                        formatter.format(_travelDate).toString(), _adults);

                    print("---------results-----------");
                    print(result);
                    setState(() {
                      _amount = result.total;
                      _currency = result.currency;
                      _origin = "BKK (Bankok)";
                      _destination = "BKK (Bankok)";
                      _travelDate = DateTime.now();
                      _adults = 1;
                    });
                  }
                },
                child: Container(
                    height: 50,
                    child: Center(
                        child: const Text(
                      'Search Available Flights',
                      style: TextStyle(fontSize: 18),
                    ))),
                style: ElevatedButton.styleFrom(
                  primary: PrimaryColor,
                ),
              ),

              SizedBox(
                height: 24,
              ),

              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: PrimaryColor),
                  color: SecondayColorBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Flight Rate',
                      style: TextStyle(color: SecondaryColorDarkGrey),
                    ),
                    Text(_amount + " " + _currency)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
