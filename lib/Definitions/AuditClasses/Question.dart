import 'package:hive/hive.dart';
part 'Question.g.dart';

@HiveType(typeId: 8)
class Question extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  String typeOfQuestion; // yesNo, yesNoNa, fillIn, dropDown, date, display

  @HiveField(2)
  String userResponse; // what the user reponsed on the questionnaire

  @HiveField(3)
  List<String> happyPathResponse; // what the desired response is

  @HiveField(4)
  List<String> dropDownMenu;

  @HiveField(5)
  String optionalComment;

  @HiveField(6)
  String note;

  @HiveField(7)
  bool textBoxRollOut;

  @HiveField(8)
  bool completed = false;

  @HiveField(9)
  bool flagged = false;

  @HiveField(10)
  Map<String, dynamic> questionMap;

  @HiveField(11)
  String displayVariable;

  Question({this.questionMap}) {
    text = questionMap['text'] as String;
    typeOfQuestion = questionMap['type'] as String;
    if (questionMap['type'] == "dropDown") {
      dropDownMenu = questionMap['menuItems'] as List<String>;
    }
    if (questionMap['type'] != "fillIn") {
      textBoxRollOut = false;
    } else {
      textBoxRollOut = true;
    }
  }
}
