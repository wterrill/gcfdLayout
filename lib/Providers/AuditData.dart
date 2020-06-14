import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/ExternalDataAudit.dart';
import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AuditData with ChangeNotifier {
  bool auditStarted = false;
  Audit activeAudit;
  Section activeSection;
  Box auditBox;
  Audit retrievedAudit;
  CalendarResult activeCalendarResult;

  AuditData() {
    initialize();
    initHive();
  }
/////////////// HIVE STUFF ////////////////
  void initHive() {
    Future auditBoxFuture = Hive.openBox<Audit>('auditBox');

    Future.wait<dynamic>([auditBoxFuture]).then((List<dynamic> value) {
      print("HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      auditBox = Hive.box<Audit>('auditBox');
      notifyListeners();
    });
  }

  void saveAudit() {
    auditBox.put(
        '${activeAudit.calendarResult.startTime}-${activeAudit.calendarResult.agencyName}-${activeAudit.calendarResult.programNum}-${activeAudit.calendarResult.auditor}',
        activeAudit);
  }

  bool getAudit(CalendarResult calendarResult) {
    retrievedAudit = auditBox.get(
            '${calendarResult.startTime}-${calendarResult.agencyName}-${calendarResult.programNum}-${calendarResult.auditor}')
        as Audit;
    print(retrievedAudit);
    if (retrievedAudit == null) {
      return false;
    } else {
      return true;
    }
  }

////////////////////////////E ND OF HIVE STUFF ////////////////
  void updateSectionStatus(Status status) {
    print("in updateSectionStatus");
    if (status != activeSection.status) {
      activeSection.status = status;
      notifyListeners();
    }
  }

  void initialize() {
    print("initialized AuditData");
  }

  void toggleStartAudit() {
    auditStarted = !auditStarted;
    notifyListeners();
  }

  void loadExisting(CalendarResult calendarResult) {
    activeAudit = retrievedAudit;
    activeSection = activeAudit.sections[0];
    activeCalendarResult = calendarResult;
  }

  void createAuditClass(CalendarResult calendarResult) {
    if (calendarResult.programType.toLowerCase() == "pantry audit") {
      activeAudit = Audit(
          questionnaire: pantryAuditSectionsQuestions,
          calendarResult: calendarResult);
      activeSection = activeAudit.sections[0];
      activeCalendarResult = calendarResult;
    }
  }

  void updateActiveSection(Section newSection) {
    activeSection = newSection;
    notifyListeners();
  }

  void createNewAudit(CalendarResult calendarResult) {
    createAuditClass(calendarResult);
  }
}
