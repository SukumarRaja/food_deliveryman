import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class RideProvider extends ChangeNotifier {
  Position? currentPosition;

  updateCurrentPosition({required Position position}) {
    currentPosition = position;
    notifyListeners();
  }
}
