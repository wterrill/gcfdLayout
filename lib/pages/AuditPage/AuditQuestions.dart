import 'package:auditor/AuditClasses/Question.dart';
import 'package:auditor/AuditClasses/Sections.dart';
import 'package:auditor/definitions/colorDefs.dart';
import 'package:flutter/material.dart';

class AuditQuestions extends StatefulWidget {
  AuditQuestions({Key key, this.activeSection}) : super(key: key);
  final Section activeSection;

  @override
  _AuditQuestionsState createState() => _AuditQuestionsState();
}

class _AuditQuestionsState extends State<AuditQuestions> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ...widget.activeSection.questions.map((Question question) {
            return Row(
              children: [
                Expanded(
                    child:
                        Text(question.text, style: ColorDefs.textBodyBlack10)),
                if (question.typeOfQuestion == "yesNo")
                  Row(
                    children: [
                      FlatButton(
                        color: Colors.blue,
                        child: Text("YES"),
                        onPressed: () {},
                      ),
                      FlatButton(
                        color: Colors.blue,
                        child: Text("NO"),
                        onPressed: () {},
                      ),
                    ],
                  ),
                if (question.typeOfQuestion == "yesNoNa")
                  Row(
                    children: [
                      FlatButton(
                        color: Colors.blue,
                        child: Text("YES"),
                        onPressed: () {},
                      ),
                      FlatButton(
                        color: Colors.blue,
                        child: Text("NO"),
                        onPressed: () {},
                      ),
                      FlatButton(
                        color: Colors.blue,
                        child: Text("N/A"),
                        onPressed: () {},
                      ),
                    ],
                  ),
              ],
            );
          }).toList()
        ],
      ),
    );
  }
}
