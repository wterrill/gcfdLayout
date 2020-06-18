import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ReviewQuestionTypes/FillInQuestion.dart';
import 'ReviewQuestionTypes/ReviewCommentSection.dart';
import 'ReviewQuestionTypes/YesNoQuestion.dart';

class ReviewPage extends StatelessWidget {
  final Audit activeAudit;
  const ReviewPage({Key key, this.activeAudit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 700,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: activeAudit.sections.length - 4,
          itemBuilder: (context, i) {
            return Container(
              decoration: BoxDecoration(
                  color: ColorDefs.colorAlternateLight,
                  border: Border.all(
                      color: ColorDefs.colorAlternateDark, width: 3)),
              child: ExpansionTile(
                trailing: Icon(Icons.arrow_drop_down),
                backgroundColor: ColorDefs.colorChatSelected,
                title: Text(activeAudit.sections[i + 1].name,
                    style: ColorDefs.textBodyBlack20),
                children: <Widget>[
                  ExpandableContent(sectionData: activeAudit.sections[i + 1]),
                ],
              ),
            );
          },
        )

        // Text("Review Page"),
        );
  }
}

class ExpandableContent extends StatefulWidget {
  const ExpandableContent({Key key, this.sectionData}) : super(key: key);
  final Section sectionData;

  @override
  _ExpandableContentState createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent> {
  @override
  Widget build(BuildContext context) {
    List<Question> questions = widget.sectionData.questions;

    bool happyPath(Question question) {
      bool isHappy = true;
      if (question.happyPathResponse != null) {
        if (!question.happyPathResponse.contains(question.userResponse)) {
          isHappy = false;
        }
      }
      return isHappy;
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.sectionData.questions.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              if (questions[index].typeOfQuestion == "yesNo" ||
                  questions[index].typeOfQuestion == "yesNoNa")
                ReviewYesNoQuestion(
                  index: index,
                  questions: questions,
                ),
              if (questions[index].typeOfQuestion == "fillIn" ||
                  questions[index].typeOfQuestion == "fillInNum" ||
                  questions[index].typeOfQuestion == "date")
                ReviewFillInQuestion(
                  index: index,
                  questions: questions,
                ),
            ],
          );
        });
  }
}
