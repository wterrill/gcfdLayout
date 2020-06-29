String converNumberToStatus(int number) {
  String value = "NONE";
  switch (number) {
    case (-1):
      value = "Deleted";
      break;
    case (0):
      value = "Scheduled";
      break;
    case (1):
      value = "Submitted";
      break;
    case (2):
      value = "Follow Up";
      break;
    case (3):
      value = "Reviewed";
      break;
  }
  return value;
}

int convertAuditTypeToNumber(String auditTypeString) {
  int value = 0;
  switch (auditTypeString) {
    case ("Annual"):
      value = 1;
      break;

    case ("Food Rescue"):
      value = 2;
      break;

    case ("CEDA"):
      value = 3;
      break;

    case ("Bi-Annual"):
      value = 4;
      break;

    case ("Complaint"):
      value = 5;
      break;

    case ("Follow Up"):
      value = 6;
      break;

    case ("Grant"):
      value = 7;
      break;
  }
  return value;
}

String convertNumberToAuditType(int number) {
  String value = "NONE";
  switch (number) {
    case (1):
      value = "Annual";
      break;

    case (2):
      value = "Food Rescue";
      break;

    case (3):
      value = "CEDA";
      break;

    case (4):
      value = "Bi-Annual";
      break;

    case (5):
      value = "Complaint";
      break;

    case (6):
      value = "Follow Up";
      break;

    case (7):
      value = "Grant";
      break;
  }
  return value;
}

int convertProgramTypeToNumber(String programType) {
  int value = 0;
  switch (programType) {
    case ("Pantry Audit"):
      value = 1;
      break;
    case ("Congregate Audit"):
      value = 2;
      break;
    case ("Senior Adults Program"):
      value = 3;
      break;
    case ("Healthy Student Market"):
      value = 4;
      break;
  }
  return value;
}

String convertNumberToProgramType(int number) {
  String value = "None";
  switch (number) {
    case (1):
      value = "Pantry Audit";
      break;
    case (2):
      value = "Congregate Audit";
      break;
    case (3):
      value = "Senior Adults Program";
      break;
    case (4):
      value = "Healthy Student Market";
      break;
  }
  return value;
}

String convertNumberToStatus(int number) {
  String value = "None";
  switch (number) {
    case (-1):
      value = "Deleted";
      break;
    case (0):
      value = "Scheduled";
      break;
    case (1):
      value = "Submitted";
      break;
    case (2):
      value = "Follow Up";
      break;
    case (2):
      value = "Reviewed";
      break;
  }
  return value;
}
