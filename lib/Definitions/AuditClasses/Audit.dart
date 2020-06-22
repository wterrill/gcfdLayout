import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';

import 'MetaData.dart';
import 'Question.dart';
import 'Section.dart';

import 'package:hive/hive.dart';
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

  Audit({this.questionnaire, this.calendarResult}) {
    for (Map<String, List<Map<String, dynamic>>> section in questionnaire) {
      sections.add(Section(section: section));
      print(sections);
      name = convertProgramTypeToOfficial(calendarResult.programType);
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
}
