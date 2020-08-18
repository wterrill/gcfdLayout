import 'package:flutter/material.dart';
import 'package:device_id/device_id.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hive/hive.dart';

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
  bool rememberMe = false;
  Box generalBox;
  bool generalInitialized = false;
  ScrollController questionScrollController = ScrollController();

  //SchedulingPage
  bool backgroundDisable;

  GeneralData() {
    initializeApp();
  }

  void initializeApp() async {
    initHive();
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

  void initHive() {
    Future generalFuture = Hive.openBox<String>('generalBox');
    Future.wait<dynamic>([generalFuture]).then((List<dynamic> value) {
      print("generalBox HIVE INTIALIZED");
      generalBox = Hive.box<String>('generalBox');
      generalInitialized = true;
      String rememberMeString = generalBox.get('rememberMe') as String;
      if (rememberMeString == "true") {
        rememberMe = true;
        username = generalBox.get('username') as String;
      } else {
        rememberMe = false;
      }
      notifyListeners();
    });
  }

  void notifyTheListeners() {
    notifyListeners();
  }

  void setRememberMe(bool value) {
    rememberMe = value;
    if (rememberMe) {
      generalBox.put('rememberMe', "true");
      // generalBox.put('username', username);
    } else {
      generalBox.put('rememberMe', "false");
      generalBox.delete('username');
    }
    print("****  rememberME  ****");
    print(rememberMe);
    print(generalBox.get('rememberMe'));
  }

  void saveUsername(String username) {
    // use,/rname = username;
    if (rememberMe) {
      generalBox.put('username', username);
    }
  }

  void toggleShowTopDrawer() {
    showTopDrawer = !showTopDrawer;
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
}
