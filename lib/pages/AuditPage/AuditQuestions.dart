import 'package:auditor/AuditClasses/Question.dart';
import 'package:auditor/AuditClasses/Sections.dart';
import 'package:auditor/definitions/colorDefs.dart';
import 'package:flutter/material.dart';

class AuditQuestions extends StatefulWidget {
  AuditQuestions({Key key, this.activeSection}) : super(key: key);
  Section activeSection;

  @override
  _AuditQuestionsState createState() => _AuditQuestionsState();
}

class _AuditQuestionsState extends State<AuditQuestions> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ...widget.activeSection.questions
              .map((Question question) =>
                  Text(question.text, style: ColorDefs.textBodyBlack10))
              .toList()
        ],
      ),
    );
  }
}
