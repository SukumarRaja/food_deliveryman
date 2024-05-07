import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:food_deliveryman/app/data/models/driver.dart';
import 'package:food_deliveryman/app/services/geo_fire.dart';
import 'package:food_deliveryman/app/utility/colors.dart';
import 'package:food_deliveryman/app/utility/text_styles.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../config/constants.dart';
import '../../../services/location.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ///google map
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(11.9008, 76.009), zoom: 14);

  Completer<GoogleMapController> googleMapController = Completer();

  GoogleMapController? mapController;
  static DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('Driver/${auth.currentUser!.uid}');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            height: 10.h,
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            child: StreamBuilder(
                stream: databaseReference.onValue,
                builder: (context, event) {
                  if (event.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(color: black));
                  }
                  if (event.data != null) {
                    DriverModel driverData = DriverModel.fromMap(
                        jsonDecode(jsonEncode(event.data!.snapshot.value))
                            as Map<String, dynamic>);
                    if (driverData.driverStatus == 'ONLINE') {
                      return SwipeButton(
                        thumbPadding: EdgeInsets.all(1.w),
                        thumb: Icon(Icons.chevron_right, color: white),
                        inactiveThumbColor: black,
                        activeThumbColor: black,
                        inactiveTrackColor: greyShade3,
                        activeTrackColor: greyShade3,
                        elevationThumb: 2,
                        elevationTrack: 2,
                        onSwipe: () {
                          GeofireService.goOffline();
                        },
                        child: Text("Done for Today",
                            style: AppTextStyles.body14Bold),
                      );
                    } else {
                      return SwipeButton(
                        thumbPadding: EdgeInsets.all(1.w),
                        thumb: Icon(Icons.chevron_right, color: white),
                        inactiveThumbColor: black,
                        activeThumbColor: black,
                        inactiveTrackColor: greyShade3,
                        activeTrackColor: greyShade3,
                        elevationThumb: 2,
                        elevationTrack: 2,
                        onSwipe: () {
                          GeofireService.goOnline();
                          GeofireService.updateLocationRealtime(context);
                        },
                        child:
                            Text("Go Online", style: AppTextStyles.body14Bold),
                      );
                    }
                  }
                  return Center(child: CircularProgressIndicator(color: black));
                }),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: cameraPosition,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: (controller) async {
                googleMapController.complete(controller);
                mapController = controller;
                Position crrPosition =
                    await LocationServices.getCurrentLocation();
                LatLng crrLatLng =
                    LatLng(crrPosition.latitude, crrPosition.longitude);
                CameraPosition cameraPosition =
                    CameraPosition(target: crrLatLng, zoom: 14);
                mapController!.animateCamera(
                    CameraUpdate.newCameraPosition(cameraPosition));
              },
            ),
          )
        ],
      ),
    ));
  }
}
