import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_deliveryman/app/config/constants.dart';

class PushNotificationService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static initializeFirebaseMessaging() async {
    await firebaseMessaging.requestPermission();

    ///background message
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    ///foreground message
    FirebaseMessaging.onMessage.listen(firebaseMessagingForegroundHandler);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  static Future<void> firebaseMessagingForegroundHandler(
      RemoteMessage message) async {}

  static getToken() async {
    var token = await firebaseMessaging.getToken();
    log("FCM token \n$token");
    DatabaseReference reference = FirebaseDatabase.instance
        .ref()
        .child('Driver/${auth.currentUser!.uid}/cloudMessagingToken');
    reference.set(token);
  }

  static subscribeToNotification() {
    firebaseMessaging.subscribeToTopic('DELIVERY_PARTNER');
  }

  static initializeFCM() {
    initializeFirebaseMessaging();
    getToken();
    subscribeToNotification();
  }
}
