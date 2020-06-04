import 'package:auditor/AuditClasses/Audit.dart';
// import 'package:auditor/AuditClasses/Question.dart';
import 'package:auditor/AuditClasses/Section.dart';
import 'package:auditor/Definitions/ExternalDataAudit.dart';
import 'package:flutter/material.dart';

class AuditData with ChangeNotifier {
  bool auditStarted = false;
  Audit activeAudit;
  Section activeSection;

  AuditData() {
    initialize();
  }

  void updateSectionStatus(Status status) {
    print("in updateSectionStatus");
    if (status != activeSection.status) {
      activeSection.status = status;
      notifyListeners();
    }
  }

  void initialize() {
    print("initialized AuditData");
    createAuditClass();
  }

  void toggleStartAudit() {
    auditStarted = !auditStarted;
    notifyListeners();
  }

  void createAuditClass() {
    activeAudit = Audit(auditSectionsQuestions);
    activeSection = activeAudit.sections[0];
  }

  void updateActiveSection(Section newSection) {
    activeSection = newSection;
    notifyListeners();
  }
}
