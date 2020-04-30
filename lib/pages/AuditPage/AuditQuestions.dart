import 'package:flutter/material.dart';
import 'package:auditor/AuditClasses/Question.dart';
import 'package:auditor/AuditClasses/Sections.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

class AuditQuestions extends StatefulWidget {
  AuditQuestions({Key key, this.activeSection}) : super(key: key);
  final Section activeSection;

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
                              "fillIn")
                            makeFillInQuestion(index),
                          if (widget.activeSection.questions[index]
                                  .typeOfQuestion ==
                              "dropDown")
                            makeDropDownQuestion(index),
                          if (widget.activeSection.questions[index]
                                  .typeOfQuestion ==
                              "date")
                            makeDateQuestion(index),
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
                      RepaintBoundary(
                        child: AnimatedContainer(
                            height: widget.activeSection.questions[index]
                                    .textBoxRollOut
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
                              style: widget.activeSection.questions[index]
                                      .textBoxRollOut
                                  ? ColorDefs.textBodyBlack20
                                  : ColorDefs.textTransparent,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: "Enter comments here"),
                            )),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
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
            margin: EdgeInsets.symmetric(horizontal: 4.0),
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
            margin: EdgeInsets.symmetric(horizontal: 4.0),
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

  Widget makeFillInQuestion(int index) {
    return Row(
      children: [
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
                        ? ColorDefs.colorChatRequired
                        : ColorDefs.colorChatSelected),
          ),
        ),
      ],
    );
  }

  Widget makeDropDownQuestion(int index) {
    return Row(
      children: [
        DropdownButton<String>(
          value: widget.activeSection.questions[index].userResponse as String ??
              "Select",
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: ColorDefs.textBodyBlack20,
          underline: Container(
            height: 2,
            color:
                (widget.activeSection.questions[index].userResponse == "Select")
                    ? Colors.red
                    : Colors.green,
          ),
          onChanged: (String newValue) {
            setState(() {
              widget.activeSection.questions[index].userResponse = newValue;
              if (newValue == "Other") {
                widget.activeSection.questions[index].textBoxRollOut = true;
              }
            });
          },
          items: widget.activeSection.questions[index].dropDownMenu
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
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

  Widget makeDateQuestion(int index) {
    return Row(
      children: [
        (widget.activeSection.questions[index].userResponse != null)
            ? Text(
                DateFormat.yMMMMd('en_US')
                    .format(widget.activeSection.questions[index].userResponse
                        as DateTime)
                    .toString(),
              )
            : Text(""),
        FlatButton(
            onPressed: () async {
              DateTime selectedDate;
              selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2018),
                lastDate: DateTime(2030),
                builder: (BuildContext context, Widget child) {
                  return Theme(
                    data: ThemeData.dark(),
                    child: child,
                  );
                },
              );
              widget.activeSection.questions[index].userResponse = selectedDate;
              setState(() {});

              // print(selectedDate);
            },
            child: Icon(Icons.calendar_today,
                color:
                    (widget.activeSection.questions[index].userResponse == null)
                        ? Colors.red
                        : Colors.green)),

        // DateFormat('EEEE').format(startingDate).toString();

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
