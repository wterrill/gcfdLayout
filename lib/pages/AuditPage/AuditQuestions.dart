import 'package:flutter/material.dart';
import 'package:auditor/AuditClasses/Question.dart';
import 'package:auditor/AuditClasses/Sections.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AuditQuestions extends StatefulWidget {
  AuditQuestions({Key key, this.activeSection}) : super(key: key);
  final Section activeSection;

  @override
  _AuditQuestionsState createState() => _AuditQuestionsState();
}

class _AuditQuestionsState extends State<AuditQuestions> {
  @override
  Widget build(BuildContext context) {
    var questionAutoGroup = AutoSizeGroup();
    return Expanded(
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
                    Row(
                      children: [
                        Expanded(
                            child: AutoSizeText(
                                widget.activeSection.questions[index].text,
                                maxLines: 3,
                                group: questionAutoGroup,
                                style: ColorDefs.textBodyBlack20)),
                        if (widget.activeSection.questions[index]
                                .typeOfQuestion ==
                            "yesNo")
                          makeYesNoQuestion(index),
                        if (widget.activeSection.questions[index]
                                .typeOfQuestion ==
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
                    AnimatedContainer(
                        height:
                            widget.activeSection.questions[index].textBoxRollOut
                                ? 100
                                : 0,
                        color: Colors.white,
                        duration: Duration(milliseconds: 300),
                        child: TextField(
                          onChanged: (value) {
                            widget.activeSection.questions[index]
                                .optionalComment = value;
                            if (value.length < 2) {
                              setState(() {});
                            }
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: ColorDefs.textBodyBlack20,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: "sLabel"),
                        )),
                  ],
                ),
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

  Widget makeYesNoQuestion(int index) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            dynamic result = setQuestionValue(
                widget.activeSection.questions[index].userResponse, "Yes");
            widget.activeSection.questions[index].userResponse = result;
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              color: buttonColorPicker(
                  widget.activeSection.questions[index], "Yes"),
              borderRadius: BorderRadius.circular(20.0),
            ),
            width: 80,
            child: Center(child: Text("Yes", style: ColorDefs.textBodyBlack20)),
          ),
        ),
        GestureDetector(
          onTap: () {
            dynamic result = setQuestionValue(
                widget.activeSection.questions[index].userResponse, "No");
            widget.activeSection.questions[index].userResponse = result;
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
            child: Center(child: Text("No", style: ColorDefs.textBodyBlack20)),
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.activeSection.questions[index].textBoxRollOut =
                !widget.activeSection.questions[index].textBoxRollOut;
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(Icons.chat_bubble,
                color:
                    widget.activeSection.questions[index].optionalComment == ""
                        ? ColorDefs.colorChatNeutral
                        : ColorDefs.colorChatSelected),
          ),
        ),
      ],
    );
  }
}
