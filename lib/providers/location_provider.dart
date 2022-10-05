import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plantngo_frontend/services/location_service.dart';

class LocationProvider extends ChangeNotifier {
  Position? _position = null;

  Position? get location => _position;

  void updateLocation() {
    determinePosition().then((value) {
      _position = value;
      notifyListeners();
    });
  }
}
