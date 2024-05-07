import 'dart:developer';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';

import '../config/constants.dart';


class LocationServices {
  static getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        getCurrentLocation();
      }
    }
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    log("Current position ${currentPosition.toString()}");
    return currentPosition;
  }

  static registerRestaurantLocationInGeofire() async {
    Position currentLocation = await getCurrentLocation();
    Geofire.initialize('Restaurants');
    Geofire.setLocation(
      auth.currentUser!.uid,
      currentLocation.latitude,
      currentLocation.longitude,
    );
  }
}
