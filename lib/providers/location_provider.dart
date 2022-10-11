import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:plantngo_frontend/services/location_service.dart';

class LocationProvider extends ChangeNotifier {
  Position? _position;

  Position? get location => _position;

  void setPosition(Position position) {
    _position = position;
    notifyListeners();
  }

  double calculateDistance(
    double locationLat,
    double locationLong,
  ) {
    if (location != null) {
      double distanceInMeters = manuallyCalculateDistance(locationLat,
          locationLong, (location?.latitude)!, (location?.longitude)!);
      return distanceInMeters;
    }
    return -1;
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return Future.error('Location services are disabled - first check.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  dynamic getLatLongFromAddress(
    String address,
  ) async {
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      return {
        "lat": locations.first.latitude,
        "long": locations.first.longitude,
      };
    }
    return null;
  }

// List<Placemark> placemarks =
//     await placemarkFromCoordinates(52.2165157, 6.9437819);
// print(placemarks);

}
