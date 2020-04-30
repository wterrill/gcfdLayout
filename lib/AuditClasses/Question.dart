class Question {
  // info
  String text;
  String typeOfQuestion; // yesNo, yesNoNa, fillIn, dropDown, date, display
  dynamic userResponse; // what the user reponsed on the questionnaire
  dynamic happyPathResponse; // what the desired response is
  List<String> dropDownMenu;
  String optionalComment = "";
  bool textBoxRollOut = false;
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
      dropDownMenu = questionMap['menuItems'] as List<String>;
    }
  }
}
