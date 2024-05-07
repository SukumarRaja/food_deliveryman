import 'package:flutter/material.dart';

class MobileAuthProvider extends ChangeNotifier {
  dynamic verificationId;
  dynamic mobileNumber;

  updateVerificationId(verification) {
    verificationId = verification;
    notifyListeners();
  }

  updateMobileNumber(number) {
    mobileNumber = number;
    notifyListeners();
  }
}
