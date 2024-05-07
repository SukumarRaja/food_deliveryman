import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_deliveryman/app/services/toast.dart';
import 'package:image_picker/image_picker.dart';

import '../config/constants.dart';

class ImageService {
  static pickSingleImage({required BuildContext context}) async {
    File selectedImage;
    var pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    XFile? filePick = pickedFile;
    if (filePick != null) {
      selectedImage = File(filePick.path);
      return selectedImage;
    } else {
      // ignore: use_build_context_synchronously
      ToastService.sendScaffoldAlert(
          context: context, msg: "No image selected", toastStatus: "WARNING");
    }
  }

  static uploadImagesToFirebaseStorageAndGetUrl(
      {required List<File> images, required BuildContext context}) async {
    List<String> imagesUrl = [];
    var sellerUid = auth.currentUser!.uid;
    await Future.forEach(images, (image) async {
      var imageName = "$sellerUid${uuid.v1().toString()}";
      Reference ref = storage.ref().child('UserProfileImages').child(imageName);
      await ref.putFile(File(image.path));
      var imageUrl = await ref.getDownloadURL();
      imagesUrl.add(imageUrl);
    });
    return imagesUrl;
  }
}
