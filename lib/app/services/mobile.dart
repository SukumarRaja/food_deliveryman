// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_deliveryman/app/services/profile.dart';
import 'package:food_deliveryman/app/services/push_notification.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../config/constants.dart';
import '../providers/mobile_auth.dart';
import '../ui/pages/auth/login.dart';
import '../ui/pages/auth/otp.dart';
import '../ui/pages/auth/resgistration.dart';
import '../ui/pages/auth/sign_in_logic.dart';
import '../ui/pages/home/main.dart';

class MobileAuthServices {
  static checkAuthentication({context}) {
    User? user = auth.currentUser;
    if (user == null) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
      return false;
    } else {
      checkUserRegistration(context: context);
    }
  }

  static receiveOtp({required BuildContext context, mobileNo}) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: mobileNo,
          verificationCompleted: (PhoneAuthCredential credentials) {
            log(credentials.toString());
          },
          verificationFailed: (FirebaseAuthException exception) {
            log(exception.toString());
            throw Exception(exception);
          },
          codeSent: (verificationId, resendToken) {
            context
                .read<MobileAuthProvider>()
                .updateVerificationId(verificationId);
            Navigator.push(
                context,
                PageTransition(
                  child: const Otp(),
                  type: PageTransitionType.rightToLeft,
                ));
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } catch (e) {
      debugPrint("Error on receive otp $e");
    }
  }

  static verifyOtp({required BuildContext context, otp}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: context.read<MobileAuthProvider>().verificationId!,
          smsCode: otp);
      await auth.signInWithCredential(credential);
      Navigator.push(
          context,
          PageTransition(
            child: const SignInLogic(),
            type: PageTransitionType.rightToLeft,
          ));
    } catch (e) {
      debugPrint("Error on verify otp $e");
      log(e.toString());
      throw Exception(e);
    }
  }

  static checkUserRegistration({required BuildContext context}) async {
    try {
      bool userIsRegistered = await ProfileServices.checkForRegistration();
      if (userIsRegistered) {
        PushNotificationService.initializeFCM();
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const HomeMain(), type: PageTransitionType.rightToLeft),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const Registration(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
