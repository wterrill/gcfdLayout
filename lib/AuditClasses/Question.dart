class Question {
  // info
  String text;
  String typeOfQuestion; // yesNo, yesNoNa, fillIn, dropDown, date, display
  List<String> dropdownMenu;
  String optionalComment;
  String mandatoryComment;
  bool completed = false;
  bool flagged = false;

  // input
  Map<String, dynamic> questionMap;
//  Question({Map<String, dynamic> questionMap}) {
  Question({this.questionMap}) {
    text = questionMap['text'] as String;
    typeOfQuestion = questionMap['type'] as String;
    if (questionMap['type'] == "dropDown") {
      dropdownMenu = questionMap['menuItems'] as List<String>;
    }
  }
}
