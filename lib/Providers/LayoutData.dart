import 'package:flutter/material.dart';
import 'package:gcfdlayout2/definitions/Event.dart';

class LayoutData with ChangeNotifier {
  double safeAreaDiff = 0.0;
  BoxConstraints safeArea;
  Size mediaArea;

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

  void toggleBigDrawer({Event event}) {
    backgroundDisable = !backgroundDisable;
    if (event != null) selectedEvent = event;
    notifyListeners();
  }
}
