import 'Question.dart';

class Section {
  // info
  String name;

  // Subtrees
  List<Question> questions;

  // display info
  bool completed = false;

  Map<String, List<Map<String, dynamic>>> section;

  Section({this.section}) {
    List<Map<String, dynamic>> questionsList = section.values.toList()[0];

    questions = questionsList.map<Question>((question) {
      print("+++++++++++++++++++++++ ${question} ");
      return Question(questionMap: question);
    }).toList();
    name = section.keys.toList()[0];
  }
}
