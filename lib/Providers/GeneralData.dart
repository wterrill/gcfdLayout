import 'package:flutter/material.dart';
import 'package:device_id/device_id.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GeneralData with ChangeNotifier {
  String username;
  double safeAreaDiff = 0.0;
  BoxConstraints safeArea;
  Size mediaArea;
  int numberOfDaysShown;
  String deviceid;
  bool confirmButtonEnabled = false;
  String personInterviewed;
  bool syncInProgress = false;
  String syncMessage = "";
  bool emailValidated = false;
  bool showTopDrawer = false;

  //SchedulingPage
  bool backgroundDisable;

  GeneralData() {
    initializeApp();
  }

  void toggleShowTopDrawer() {
    showTopDrawer = !showTopDrawer;
  }

  void initializeApp() async {
    backgroundDisable = false;
    numberOfDaysShown = 8;

    if (!kIsWeb) {
      deviceid = await DeviceId.getID;
      // deviceid = await DeviceId.getIMEI;
      // deviceid = await DeviceId.getMEID;
    } else {
      deviceid = "website";
    }
    notifyListeners();
  }

  void updateNumberOfDaysShown(int number) {
    numberOfDaysShown = number;
    notifyListeners();
  }

  void enableConfirmButton() {
    confirmButtonEnabled = true;
    notifyListeners();
  }

  void disableConfirmButton() {
    confirmButtonEnabled = false;
    notifyListeners();
  }

  void toggleSyncInProgressOn() {
    syncInProgress = true;
    notifyListeners();
  }

  void toggleSyncInProgressOff() {
    syncInProgress = false;
    notifyListeners();
  }

  void updateSyncMessage(String message) {
    syncMessage = message;
    notifyListeners();
  }
}
