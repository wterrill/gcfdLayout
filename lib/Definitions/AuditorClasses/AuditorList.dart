import 'package:auditor/Definitions/AuditorClasses/Auditor.dart';
import 'package:hive/hive.dart';
import 'dart:math';

part 'AuditorList.g.dart';

@HiveType(typeId: 13)
class AuditorList extends HiveObject {
  @HiveField(0)
  List<Auditor> auditorList;

  AuditorList({this.auditorList}) {}

  Auditor getRandom() {
    Random random = Random();
    Auditor auditor = auditorList[random.nextInt(auditorList.length)];
    return auditor;
  }

  List<String> getAuditorDropDown() {
    List<String> dropdown = ["Select"];
    for (Auditor auditor in auditorList) {
      dropdown.add(auditor.toString());
    }
    return dropdown;
  }
}
