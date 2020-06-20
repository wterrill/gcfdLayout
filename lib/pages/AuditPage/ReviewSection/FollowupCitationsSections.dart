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
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.activeAudit.sections.length - 4,
        itemBuilder: (context, i) {
          return FollowupCitationsQuestions(
              sectionData: widget.activeAudit.sections[i + 1]);
        },
      ),
    );
  }
}

class FollowupCitationsQuestions extends StatefulWidget {
  final Section sectionData;
  FollowupCitationsQuestions({Key key, this.sectionData}) : super(key: key);

  @override
  _FollowupCitationsQuestionsState createState() =>
      _FollowupCitationsQuestionsState();
}

class _FollowupCitationsQuestionsState
    extends State<FollowupCitationsQuestions> {
  @override
  Widget build(BuildContext context) {
    bool notHappyPath(Question question) {
      bool isHappy = true;
      if (question.happyPathResponse != null) {
        if (!question.happyPathResponse.contains(question.userResponse)) {
          isHappy = false;
        }
      }
      return !isHappy;
    }

    List<Question> questions = widget.sectionData.questions;
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.sectionData.questions.length,
        itemBuilder: (context, index) {
          return Container(
            color: index.isEven
                ? ColorDefs.colorAlternateDark
                : ColorDefs.colorAlternateLight,
            child: Container(
              child: Column(
                children: [
                  if (notHappyPath(questions[index]) &&
                      questions[index].userResponse != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              questions[index].text,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ),
                        Container(
                          height: 55,
                          width: 180,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorDefs.colorAlternatingDark,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(widget.sectionData.name,
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
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Icon(Icons.flag, color: Colors.red),
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
                                    if (questions[index].optionalComment !=
                                        null) {
                                      questions[index].textBoxRollOut =
                                          !questions[index].textBoxRollOut;
                                      print(questions[index].textBoxRollOut);
                                      setState(() {});
                                    }
                                  },
                                  child: Icon(Icons.chat_bubble,
                                      color: questions[index].optionalComment ==
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
                  if (notHappyPath(questions[index]) &&
                      questions[index].userResponse != null)
                    ReviewCommentSection(
                        index: index,
                        questions: questions,
                        key: UniqueKey(),
                        numKeyboard: false,
                        mandatory: false)
                ],
              ),
              // leading: new Text(question.userResponse),
            ),
          );
        });
  }
}
