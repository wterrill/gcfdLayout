import 'package:auditor/AuditClasses/Audit.dart';
import 'package:auditor/AuditClasses/Question.dart';
import 'package:auditor/AuditClasses/Sections.dart';
import 'package:flutter/material.dart';

import 'ExternalDataAudit.dart';

class AuditData with ChangeNotifier {
  bool auditStarted = false;
  Audit activeAudit;

  AuditData() {
    initialize();
  }

  void initialize() {
    print("initialized AuditData");
    createAuditClass();
  }

  void toggleStartAudit() {
    auditStarted = !auditStarted;
    notifyListeners();
  }

  Audit createAuditClass() {
    activeAudit = Audit(auditSectionsQuestions);
  }
}
