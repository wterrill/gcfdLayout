import 'package:flutter/material.dart';
import 'package:auditor/Definitions/Event.dart';

class LayoutData with ChangeNotifier {
  double safeAreaDiff = 0.0;
  BoxConstraints safeArea;
  Size mediaArea;
  int numberOfDaysShown;

  //SchedulingPage
  bool backgroundDisable;
  Event selectedEvent;

  LayoutData() {
    initializeApp();
  }

  void initializeApp() {
    backgroundDisable = false;
    numberOfDaysShown = 8;
    notifyListeners();
  }

  void toggleBigDrawerWidget({Event event}) {
    backgroundDisable = !backgroundDisable;
    if (event != null) selectedEvent = event;
    notifyListeners();
  }

  void updateNumberOfDaysShown(int number) {
    numberOfDaysShown = number;
    notifyListeners();
  }
}
