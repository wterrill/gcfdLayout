import 'package:flutter/material.dart';

class AuditData with ChangeNotifier {
  bool auditStarted = false;

  AuditData() {
    initialize();
  }

  void initialize() {
    print("initialized AuditData");
  }

  void startAudit() {
    auditStarted = true;
    notifyListeners();
  }
}
