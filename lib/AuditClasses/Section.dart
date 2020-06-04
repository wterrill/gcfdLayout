import 'Question.dart';

enum Status { disabled, selected, available, inProgress, completed }

class Section {
  Map<String, List<Map<String, dynamic>>> section;

  String name;
  List<Question> questions;
  var status = Status.disabled;

  Section({this.section}) {
    List<Map<String, dynamic>> questionsList = section.values.toList()[0];
    questions = questionsList.map<Question>((question) {
      return Question(questionMap: question);
    }).toList();
    name = section.keys.toList()[0];
    if (name == "Confirm Details") {
      status = Status.selected;
    }
  }
}
