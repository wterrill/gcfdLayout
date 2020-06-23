import 'package:auditor/Definitions/CalendarClasses/CalendarResult.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';

import 'QuestionTypes/DateQuestion.dart';
import 'QuestionTypes/Display.dart';
import 'QuestionTypes/DropDownQuestion.dart';
import 'QuestionTypes/FillInNumQuestion.dart';
import 'QuestionTypes/FillInQuestion.dart';
import 'QuestionTypes/IssuesNoIssuesQuestion.dart';
import 'QuestionTypes/YesNoNaQuestion.dart';
import 'QuestionTypes/YesNoQuestion.dart';

class AuditQuestions extends StatefulWidget {
  AuditQuestions({Key key, this.activeSection, this.activecalendarResult})
      : super(key: key);
  final Section activeSection;
  final CalendarResult activecalendarResult;

  @override
  _AuditQuestionsState createState() => _AuditQuestionsState();
}

class _AuditQuestionsState extends State<AuditQuestions> {
  @override
  Widget build(BuildContext context) {
    print("building auditQuestions");
    var questionAutoGroup = AutoSizeGroup();
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          itemCount: widget.activeSection.questions.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: index.isEven
                  ? ColorDefs.colorAlternateDark
                  : ColorDefs.colorAlternateLight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    if (widget.activeSection.questions[index].typeOfQuestion ==
                        "display")
                      Display(
                        index: index,
                        activeSection: widget.activeSection,
                        activeCalendarResult: widget.activecalendarResult,
                      ),
                    if (widget.activeSection.questions[index].typeOfQuestion ==
                        "yesNo")
                      YesNoQuestion(
                        index: index,
                        activeSection: widget.activeSection,
                      ),
                    if (widget.activeSection.questions[index].typeOfQuestion ==
                        "issuesNoIssues")
                      IssuesNoIssuesQuestion(
                        index: index,
                        activeSection: widget.activeSection,
                      ),
                    if (widget.activeSection.questions[index].typeOfQuestion ==
                        "fillIn")
                      FillInQuestion(
                          index: index,
                          activeSection: widget.activeSection,
                          questionAutoGroup: questionAutoGroup),
                    if (widget.activeSection.questions[index].typeOfQuestion ==
                        "fillInNum")
                      FillInNumQuestion(
                          index: index,
                          activeSection: widget.activeSection,
                          questionAutoGroup: questionAutoGroup),
                    if (widget.activeSection.questions[index].typeOfQuestion ==
                        "dropDown")
                      DropDownQuestion(
                          index: index,
                          activeSection: widget.activeSection,
                          questionAutoGroup: questionAutoGroup),
                    if (widget.activeSection.questions[index].typeOfQuestion ==
                        "date")
                      DateQuestion(
                        index: index,
                        activeSection: widget.activeSection,
                        questionAutoGroup: questionAutoGroup,
                      ),
                    if (widget.activeSection.questions[index].typeOfQuestion ==
                        "yesNoNa")
                      YesNoNaQuestion(
                        index: index,
                        activeSection: widget.activeSection,
                        questionAutoGroup: questionAutoGroup,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
