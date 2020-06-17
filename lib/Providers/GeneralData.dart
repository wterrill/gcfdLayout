import 'package:flutter/material.dart';
import 'package:device_id/device_id.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GeneralData with ChangeNotifier {
  String username;
  double safeAreaDiff = 0.0;
  BoxConstraints safeArea;
  Size mediaArea;
  int numberOfDaysShown;
  String deviceid;

  //SchedulingPage
  bool backgroundDisable;

  GeneralData() {
    initializeApp();
  }

  void initializeApp() async {
    backgroundDisable = false;
    numberOfDaysShown = 8;

    if (!kIsWeb) {
      deviceid = await DeviceId.getID;
    } else {
      deviceid = "website";
    }
    notifyListeners();
  }

  void updateNumberOfDaysShown(int number) {
    numberOfDaysShown = number;
    notifyListeners();
  }
}
