import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import '../data/models/driver.dart';
import '../services/image.dart';

class ProfileProvider extends ChangeNotifier {
  DriverModel? driverProfile;
  File? profileImage;
  String? profileImageUrl;

  updateDriverProfile() async {}

  pickUserImageFromGallery(BuildContext context) async {
    profileImage = await ImageService.pickSingleImage(context: context);
    notifyListeners();
  }

  uploadImageAndGetImageUrl(BuildContext context) async {
    List<String> url =
        await ImageService.uploadImagesToFirebaseStorageAndGetUrl(
            images: [profileImage!], context: context);

    if (url.isNotEmpty) {
      profileImageUrl = url[0];
      log("image url is ${profileImage!}");
    }
    notifyListeners();
  }
}
