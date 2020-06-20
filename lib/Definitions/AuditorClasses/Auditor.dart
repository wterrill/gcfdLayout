import 'package:hive/hive.dart';

part 'Auditor.g.dart';

@HiveType(typeId: 12)
class Auditor extends HiveObject {
  @HiveField(0)
  String auditorName; //"William Terill"",

  Auditor({this.auditorName}) {}

  String toString() {
    return auditorName;
  }
}
