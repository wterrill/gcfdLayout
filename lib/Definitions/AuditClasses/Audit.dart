import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';

import 'MetaData.dart';
import 'Question.dart';
import 'Section.dart';

import 'package:hive/hive.dart';
import 'dart:typed_data';

part 'Audit.g.dart';

@HiveType(typeId: 6)
class Audit extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Section> sections = [];

  @HiveField(2)
  bool completed;

  @HiveField(3)
  List<MetaData> metadata;

  @HiveField(4)
  List<Map<String, List<Map<String, dynamic>>>> questionnaire;

  @HiveField(5)
  CalendarResult calendarResult;

  @HiveField(6)
  List<Question> citations = [];

  @HiveField(7)
  bool putProgramOnImmediateHold;

  @HiveField(8)
  Map<String, Uint8List> photoSig = {};

  @HiveField(9)
  List<Uint8List> photoList;

  @HiveField(10)
  bool followupRequired;

  @HiveField(11)
  DateTime correctiveActionPlanDueDate;

  @HiveField(12)
  bool detailsConfirmed = false;

  @HiveField(13)
  bool activateConfirmDetails = false;

  @HiveField(14)
  List<String> actionItemList = [];

  Audit({this.questionnaire, this.calendarResult}) {
    for (Map<String, List<Map<String, dynamic>>> section in questionnaire) {
      sections.add(Section(section: section));
      print(sections);
      name = convertProgramTypeToOfficial(calendarResult.programType);
      photoList = [];
    }
  }

  String convertProgramTypeToOfficial(String programType) {
    String value = "Error in Name";
    switch (programType) {
      case ("Pantry Audit"):
        value = "Pantry Policy / Procedures Checklist";
        break;
      case ("Congregate Audit"):
        value = "Congregate Policy Checklist";
        break;
      case ("Senior Adults Program"):
        value = "Senior Adults Policy Checklist";
        break;
      case ("Healthy Student Market"):
        value = "Healthy Student Policy Checklist";
        break;
    }
    return value;
  }

  Audit clone() {
    Audit clonedAudit =
        Audit(calendarResult: calendarResult, questionnaire: questionnaire);
    clonedAudit.name = name;
    clonedAudit.sections = List.from(sections);
    clonedAudit.completed = completed;
    // clonedAudit.metadata = List.from(metadata);
    clonedAudit.citations = List.from(citations);
    clonedAudit.putProgramOnImmediateHold = putProgramOnImmediateHold;
    clonedAudit.photoSig = Map.from(photoSig);
    clonedAudit.photoList = List.from(photoList);
    clonedAudit.followupRequired = followupRequired;
    clonedAudit.correctiveActionPlanDueDate = correctiveActionPlanDueDate;
    clonedAudit.detailsConfirmed = detailsConfirmed;
    clonedAudit.activateConfirmDetails = activateConfirmDetails;
    return clonedAudit;
  }
}
