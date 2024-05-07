import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:food_deliveryman/app/config/constants.dart';
import 'package:food_deliveryman/app/providers/ride.dart';
import 'package:food_deliveryman/app/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class GeofireService {
  static DatabaseReference databaseReference = FirebaseDatabase.instance
      .ref()
      .child('Driver/${auth.currentUser!.uid}/driverStatus');

  static goOnline() async {
    Position currentPosition = await LocationServices.getCurrentLocation();
    Geofire.initialize('OnlineDrivers');
    Geofire.setLocation(auth.currentUser!.uid, currentPosition.latitude,
        currentPosition.longitude);
    databaseReference.set('ONLINE');
    databaseReference.onValue.listen((event) {});
  }

  static goOffline() async {
    Geofire.removeLocation(auth.currentUser!.uid);
    databaseReference.set('OFFLINE');
    databaseReference.onDisconnect();
  }

  static updateLocationRealtime(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    LocationSettings settings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 10);

    StreamSubscription<Position> driverPositionStream =
        Geolocator.getPositionStream(locationSettings: settings)
            .listen((event) {
      Geofire.setLocation(
          auth.currentUser!.uid, event.latitude, event.longitude);

      context.read<RideProvider>().updateCurrentPosition(position: event);
    });
  }
}
