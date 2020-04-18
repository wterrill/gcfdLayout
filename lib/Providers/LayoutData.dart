import 'package:flutter/material.dart';
import 'package:auditor/definitions/Event.dart';

class LayoutData with ChangeNotifier {
  double safeAreaDiff = 0.0;
  BoxConstraints safeArea;
  Size mediaArea;
  int numberOfDaysShown = 7;

  //SchedulingPage
  bool backgroundDisable;
  Event selectedEvent;

  LayoutData() {
    initializeApp();
  }

  void initializeApp() {
    backgroundDisable = false;
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
