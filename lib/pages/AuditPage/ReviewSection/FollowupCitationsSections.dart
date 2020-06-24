import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';

import 'ReviewQuestionTypes/ReviewCommentSection.dart';

class FollowupCitationsSections extends StatefulWidget {
  FollowupCitationsSections({Key key, this.activeAudit}) : super(key: key);
  final Audit activeAudit;

  @override
  _FollowupCitationsSectionsState createState() =>
      _FollowupCitationsSectionsState();
}

class _FollowupCitationsSectionsState extends State<FollowupCitationsSections> {
  @override
  bool notHappyPath(Question question) {
    bool isHappy = true;
    if (question.happyPathResponse != null) {
      if (!question.happyPathResponse.contains(question.userResponse)) {
        isHappy = false;
      }
    }
    return !isHappy;
  }

  @override
  void initState() {
    super.initState();
    List<Question> citations = [];
    if (widget.activeAudit.citations.length == 0) {
      for (Section section in widget.activeAudit.sections) {
        List<String> avoid = ["Photos", "Intro", "Review", "Verification"];
        if (!avoid.contains(section.name)) {
          for (Question question in section.questions) {
            if (notHappyPath(question) && question.userResponse != null) {
              question.fromSectionName = section.name;
              citations.add(question);
            }
          }
        }
      }
      widget.activeAudit.citations = citations;
    }
  }

  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: widget.activeAudit.citations.length,
          itemBuilder: (context, index) {
            return Container(
              color: index.isEven
                  ? ColorDefs.colorAlternateDark
                  : ColorDefs.colorAlternateLight,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              widget.activeAudit.citations[index].text,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ),
                        Container(
                          height: 55,
                          width: 190,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorDefs.colorButton1Background,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                          widget.activeAudit.citations[index]
                                              .fromSectionName,
                                          // wrapWords: false,
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          style: ColorDefs.textBodyWhite15),
                                    ),
                                    height: 50,
                                    width: 100),
                              ),
                              Container(
                                  height: double.infinity,
                                  // color: ColorDefs.colorButtonNeutral,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.activeAudit.citations[index]
                                                    .unflagged =
                                                !widget.activeAudit
                                                    .citations[index].unflagged;
                                          });
                                        },
                                        child: Icon(Icons.flag,
                                            color: widget.activeAudit
                                                    .citations[index].unflagged
                                                ? ColorDefs.colorChatNeutral
                                                : Colors.red)),
                                  )),
                              // if (questions[index].userResponse != null &&
                              //     questions[index]
                              //             .typeOfQuestion
                              //             .toLowerCase() !=
                              //         "date")
                              //   Expanded(
                              //       child: Center(
                              //           child: Text(questions[index]
                              //               .userResponse
                              //               .toString()))),

                              // if (questions[index].typeOfQuestion.toLowerCase() == "date" &&
                              //     questions[index].userResponse != null) {
                              //   DateTime dateTime = DateTime.parse(questions[index].userResponse as String);
                              //   if (dateTime == null) {
                              //     dateString = "";
                              //   } else {
                              //     dateString = DateFormat('EEE, MMM-dd-yyyy').format(dateTime);
                              //   }
                              // }

                              // if (questions[index].typeOfQuestion.toLowerCase() ==
                              //         "date" &&
                              //     dateString != null)
                              //   Text(dateString),

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    widget.activeAudit.citations[index]
                                            .textBoxRollOut =
                                        !widget.activeAudit.citations[index]
                                            .textBoxRollOut;
                                    print(widget.activeAudit.citations[index]
                                        .textBoxRollOut);
                                    setState(() {});
                                  },
                                  child: Icon(Icons.chat_bubble,
                                      color: widget.activeAudit.citations[index]
                                                  .optionalComment ==
                                              null
                                          ? ColorDefs.colorChatNeutral
                                          : ColorDefs.colorChatSelected),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    ReviewCommentSection(
                        index: index,
                        questions: widget.activeAudit.citations,
                        key: UniqueKey(),
                        numKeyboard: false,
                        mandatory: false,
                        actionItem: false)
                  ],
                ),
                // leading: new Text(question.userResponse),
              ),
            );
          },
        ));
  }
}
