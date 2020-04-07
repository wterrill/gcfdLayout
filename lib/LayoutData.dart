import 'package:flutter/material.dart';

class LayoutData with ChangeNotifier {
  double safeAreaDiff = 0.0;
  BoxConstraints safeArea;
  Size mediaArea;

  LayoutData() {
    initializeApp();
  }

  void initializeApp() {}
}
