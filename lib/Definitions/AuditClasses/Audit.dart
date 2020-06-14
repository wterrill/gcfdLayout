import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';

import 'MetaData.dart';
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

  Audit({this.questionnaire, this.calendarResult}) {
    for (Map<String, List<Map<String, dynamic>>> section in questionnaire) {
      sections.add(Section(section: section));
      print(sections);
    }
  }
}
