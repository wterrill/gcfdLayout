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
      child: ListView.builder(
          itemCount: widget.activeSection.questions.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: index.isEven
                  ? ColorDefs.colorAlternateDark
                  : ColorDefs.colorAlternateLight,
              child: Row(
                children: [
                  Expanded(
                      child: Text(widget.activeSection.questions[index].text,
                          style: ColorDefs.textBodyBlack10)),
                  if (widget.activeSection.questions[index].typeOfQuestion ==
                      "yesNo")
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            dynamic result = setQuestionValue(
                                widget.activeSection.questions[index]
                                    .userResponse,
                                "Yes");
                            widget.activeSection.questions[index].userResponse =
                                result;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: buttonColorPicker(
                                  widget.activeSection.questions[index], "Yes"),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            width: 80,
                            child: Center(
                                child: Text("Yes",
                                    style: ColorDefs.textBodyBlack20)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            dynamic result = setQuestionValue(
                                widget.activeSection.questions[index]
                                    .userResponse,
                                "No");
                            widget.activeSection.questions[index].userResponse =
                                result;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: buttonColorPicker(
                                  widget.activeSection.questions[index], "No"),
                              borderRadius: BorderRadius.circular(20.0),
                              // border:
                              //     Border.all(width: 2.0, color: Colors.grey)
                            ),
                            width: 80,
                            child: Center(
                                child: Text("No",
                                    style: ColorDefs.textBodyBlack20)),
                          ),
                        ),
                      ],
                    ),
                  if (widget.activeSection.questions[index].typeOfQuestion ==
                      "yesNoNa")
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
              ),
            );
          }),
    );
  }

  Color buttonColorPicker(Question questionData, String buttonText) {
    Color finalButtonColor;
    if (questionData.userResponse == null ||
        questionData.userResponse != buttonText) {
      finalButtonColor = ColorDefs.colorButtonNeutral;
    }
    if (questionData.userResponse == buttonText && buttonText == "Yes") {
      finalButtonColor = ColorDefs.colorButtonYes;
    }

    if (questionData.userResponse == buttonText && buttonText == "No") {
      finalButtonColor = ColorDefs.colorButtonNo;
    }
    return finalButtonColor;
  }

  dynamic setQuestionValue(dynamic currentValue, dynamic buttonText) {
    bool isNotSameAsText = currentValue != buttonText;
    bool isSameAsText = currentValue == buttonText;

    if (isNotSameAsText) {
      currentValue = buttonText;
    } else if (isSameAsText) {
      currentValue = null;
    } else {
      currentValue ??= buttonText;
    }
    return currentValue;
  }
}
