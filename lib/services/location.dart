import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CurrentLocation extends StatefulWidget {
  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  Position _currentPosition = Position(
      longitude: 343434,
      latitude: 343434,
      timestamp: DateTime(2022),
      accuracy: 343,
      altitude: 343,
      heading: 0.0,
      speed: 0,
      speedAccuracy: 0);

  String _currentAddress = "sdsdsd";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (_currentPosition != null)
          Text(
              "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
        if (_currentAddress != null) Text(_currentAddress),
        FlatButton(
          child: Text("Get location"),
          onPressed: () {
            getCurrentLocation();
          },
        ),
      ],
    );
  }

  getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
      return position;
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];
      print(place);

      setState(() {
        _currentAddress =
            "${place.street}, ${place.subAdministrativeArea}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
