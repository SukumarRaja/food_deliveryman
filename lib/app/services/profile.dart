import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../config/constants.dart';
import '../data/models/driver.dart';
import '../ui/pages/auth/sign_in_logic.dart';
import 'toast.dart';

class ProfileServices {
  static registerDriver(DriverModel driverData, BuildContext context) async {
    print("driver data ${driverData.toMap().toString()}");
    realTimeDatabaseRef
        .child('Driver/${auth.currentUser!.uid}')
        .set(driverData.toMap())
        .then((value) {
      ToastService.sendScaffoldAlert(
          context: context,
          msg: "Register Successfully",
          toastStatus: 'SUCCESS');
      Navigator.push(
          context,
          PageTransition(
              child: const SignInLogic(),
              type: PageTransitionType.rightToLeft));
    }).onError((error, stackTrace) {
      print("error on $error");

      ToastService.sendScaffoldAlert(
          context: context,
          msg: "Oops! Error getting Registered",
          toastStatus: 'ERROR');
      Navigator.push(
          context,
          PageTransition(
              child: const SignInLogic(),
              type: PageTransitionType.rightToLeft));
    });
  }

  static Future<bool> checkForRegistration() async {
    try {
      final snapshot = await realTimeDatabaseRef
          .child('Driver/${auth.currentUser!.uid}')
          .get();
      if (snapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
