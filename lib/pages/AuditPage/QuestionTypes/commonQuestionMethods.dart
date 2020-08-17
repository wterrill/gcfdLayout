import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/AuditClasses/Section.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';

Color buttonColorPicker(Question questionData, String buttonText) {
  Color finalButtonColor;
  if (questionData.userResponse == null || questionData.userResponse != buttonText) {
    finalButtonColor = ColorDefs.colorButtonNeutral;
  }
  if (questionData.userResponse == buttonText && buttonText == "Yes" ||
      questionData.userResponse == buttonText && buttonText == "No Issues") {
    finalButtonColor = ColorDefs.colorButtonYes;
  }

  if (questionData.userResponse == buttonText && buttonText == "No" ||
      questionData.userResponse == buttonText && buttonText == "Issues") {
    finalButtonColor = ColorDefs.colorButtonNo;
  }

  if (questionData.userResponse == buttonText && buttonText == 'NA') {
    finalButtonColor = ColorDefs.colorChatNeutral;
  }

  if (questionData.userResponse == "0" && buttonText == 'NA') {
    finalButtonColor = ColorDefs.colorChatNeutral;
  }
  print(finalButtonColor);
  return finalButtonColor;
}

String setQuestionValue(String currentValue, String buttonText) {
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
  int numQuestions = activeSection.questions.length;

  for (Question question in activeSection.questions) {
    if (question.userResponse == null && question.typeOfQuestion.toLowerCase() != "display") {
      done = false;
    } else {
      numComplete += 1;
    }
  }

  if (!done && numComplete > 0) result = Status.inProgress;
  if (done) result = Status.completed;
  if ((numQuestions - numComplete) < 4) {
    highlightQuestions(activeSection);
  }

  return result;
}

void highlightQuestions(Section activeSection) {
  for (Question question in activeSection.questions) {
    if (question.userResponse == null && question.typeOfQuestion.toLowerCase() != "display") {
      question.highlight = true;
    } else {
      question.highlight = false;
    }
  }
}
