import 'package:auditor/AuditClasses/Question.dart';
import 'package:auditor/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';

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

  if (questionData.userResponse == buttonText && buttonText == "NA") {
    finalButtonColor = ColorDefs.colorChatNeutral;
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

Status checkSectionDone(Section activeSection) {
  bool done = true;
  int numComplete = 0;
  Status result = Status.available;

  for (Question question in activeSection.questions) {
    //TODO This needs to be completed... NOT userResponse because it has to be checked with the happypath
    if (question.userResponse == null) {
      done = false;
    } else {
      numComplete += 1;
    }
  }

  if (!done && numComplete > 0) result = Status.inProgress;
  if (done) result = Status.completed;
  return result;
}
