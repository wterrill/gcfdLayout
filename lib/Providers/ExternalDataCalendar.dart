List<String> sites = [
  "Manna",
  "Marillac House",
  "Irving Park",
  "Ravenswood",
  "LakeView",
  "Casa Catalina",
  "St Cyprian's",
  "Chicago Hope",
  "Care for Real",
  "Common",
  "Care for Friends",
  "New Morning Star"
];

List<String> auditTypes = [
  "Annual",
  "Bi-annual",
  "Complaint",
  "Grant",
  "CEDA",
  "Food Rescue",
  "Follow up"
];

List<String> programTypes = [
  "Pantry Audit",
  "Senior Adults Program",
  "Healthy Students Program",
  "Congregate"
];

List<String> programNum = [
  "PY00278",
  "PY00731",
  "PY00167",
  "PY00252",
  "PY00395",
  "PY00079",
  "PY00228",
  "PY00658",
  "PY00364",
  "PY00030",
  "PY00126",
  "PY00225",
  "PY00168",
  "PY00802",
  "PY00814",
  "PY00035",
  "PY00104",
  "PY00358",
];

List<String> programType = [
  "Older Adults",
  "Pantry",
  "Congregate",
  "Healthy Student Market"
];

List<String> auditor = ["Sarah Connor", "Kyle Reese"];

List<String> status = ["Scheduled", "Completed"];

List<Map<String, String>> masterDayEvents = [
  {
    'startTime': '2020-04-10 11:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[6],
    'programNum': programNum[0],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-11 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[1],
    'auditType': auditTypes[5],
    'programNum': programNum[1],
    'programType': programType[1],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-11 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[2],
    'auditType': auditTypes[4],
    'programNum': programNum[2],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-14 10:00:00.000',
    'message': 'insert message here',
    'agency': sites[3],
    'auditType': auditTypes[3],
    'programNum': programNum[3],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-14 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[4],
    'auditType': auditTypes[6],
    'programNum': programNum[4],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-15 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[5],
    'auditType': auditTypes[0],
    'programNum': programNum[5],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 07:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[1],
    'programNum': programNum[6],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 09:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[2],
    'programNum': programNum[7],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 14:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[3],
    'programNum': programNum[8],
    'programType': programType[1],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 15:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[4],
    'programNum': programNum[9],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-17 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[7],
    'auditType': auditTypes[0],
    'programNum': programNum[10],
    'programType': programType[1],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-17 20:00:00.000',
    'message': 'insert message here',
    'agency': sites[8],
    'auditType': auditTypes[1],
    'programNum': programNum[9],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-18 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[9],
    'auditType': auditTypes[2],
    'programNum': programNum[8],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-18 20:00:00.000',
    'message': sites[10],
    'agency': sites[10],
    'auditType': auditTypes[3],
    'programNum': programNum[7],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-20 08:00:00.000',
    'message': sites[11],
    'agency': sites[11],
    'auditType': auditTypes[4],
    'programNum': programNum[6],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-20 19:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[0],
    'programNum': programNum[5],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-21 11:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[1],
    'programNum': programNum[4],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-22 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[1],
    'auditType': auditTypes[5],
    'programNum': programNum[6],
    'programType': programType[1],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-22 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[2],
    'auditType': auditTypes[4],
    'programNum': programNum[7],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-23 10:00:00.000',
    'message': 'insert message here',
    'agency': sites[3],
    'auditType': auditTypes[3],
    'programNum': programNum[8],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-23 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[4],
    'auditType': auditTypes[6],
    'programNum': programNum[9],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-24 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[5],
    'auditType': auditTypes[5],
    'programNum': programNum[10],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-25 07:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[1],
    'programNum': programNum[11],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-25 09:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[2],
    'programNum': programNum[12],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-25 14:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[3],
    'programNum': programNum[13],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-25 15:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[4],
    'programNum': programNum[14],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-26 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[7],
    'auditType': auditTypes[0],
    'programNum': programNum[13],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-26 20:00:00.000',
    'message': 'insert message here',
    'agency': sites[8],
    'auditType': auditTypes[1],
    'programNum': programNum[4],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-27 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[9],
    'auditType': auditTypes[2],
    'programNum': programNum[0],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-27 20:00:00.000',
    'message': sites[10],
    'agency': sites[10],
    'auditType': auditTypes[3],
    'programNum': programNum[2],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-28 08:00:00.000',
    'message': sites[11],
    'agency': sites[11],
    'auditType': auditTypes[4],
    'programNum': programNum[3],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-28 19:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[0],
    'programNum': programNum[5],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-10 11:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[6],
    'programNum': programNum[0],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-11 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[1],
    'auditType': auditTypes[5],
    'programNum': programNum[1],
    'programType': programType[1],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-11 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[2],
    'auditType': auditTypes[4],
    'programNum': programNum[2],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-14 10:00:00.000',
    'message': 'insert message here',
    'agency': sites[3],
    'auditType': auditTypes[3],
    'programNum': programNum[3],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-14 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[4],
    'auditType': auditTypes[6],
    'programNum': programNum[4],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-15 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[5],
    'auditType': auditTypes[0],
    'programNum': programNum[5],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 07:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[1],
    'programNum': programNum[6],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 09:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[2],
    'programNum': programNum[7],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 14:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[3],
    'programNum': programNum[8],
    'programType': programType[1],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 15:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[4],
    'programNum': programNum[9],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-17 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[7],
    'auditType': auditTypes[0],
    'programNum': programNum[10],
    'programType': programType[1],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-17 20:00:00.000',
    'message': 'insert message here',
    'agency': sites[8],
    'auditType': auditTypes[1],
    'programNum': programNum[9],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-18 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[9],
    'auditType': auditTypes[2],
    'programNum': programNum[8],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-18 20:00:00.000',
    'message': sites[10],
    'agency': sites[10],
    'auditType': auditTypes[3],
    'programNum': programNum[7],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-20 08:00:00.000',
    'message': sites[11],
    'agency': sites[11],
    'auditType': auditTypes[4],
    'programNum': programNum[6],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-20 19:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[0],
    'programNum': programNum[5],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-21 11:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[1],
    'programNum': programNum[4],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-22 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[1],
    'auditType': auditTypes[5],
    'programNum': programNum[6],
    'programType': programType[1],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-22 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[2],
    'auditType': auditTypes[4],
    'programNum': programNum[7],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-23 10:00:00.000',
    'message': 'insert message here',
    'agency': sites[3],
    'auditType': auditTypes[3],
    'programNum': programNum[8],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-23 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[4],
    'auditType': auditTypes[6],
    'programNum': programNum[9],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-24 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[5],
    'auditType': auditTypes[5],
    'programNum': programNum[10],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-25 07:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[1],
    'programNum': programNum[11],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-25 09:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[2],
    'programNum': programNum[12],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-25 14:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[3],
    'programNum': programNum[13],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-25 15:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[4],
    'programNum': programNum[14],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-26 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[7],
    'auditType': auditTypes[0],
    'programNum': programNum[13],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-26 20:00:00.000',
    'message': 'insert message here',
    'agency': sites[8],
    'auditType': auditTypes[1],
    'programNum': programNum[4],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-27 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[9],
    'auditType': auditTypes[2],
    'programNum': programNum[0],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-27 20:00:00.000',
    'message': sites[10],
    'agency': sites[10],
    'auditType': auditTypes[3],
    'programNum': programNum[2],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-28 08:00:00.000',
    'message': sites[11],
    'agency': sites[11],
    'auditType': auditTypes[4],
    'programNum': programNum[3],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-28 19:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[0],
    'programNum': programNum[5],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-10 11:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[6],
    'programNum': programNum[0],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-11 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[1],
    'auditType': auditTypes[5],
    'programNum': programNum[1],
    'programType': programType[1],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-11 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[2],
    'auditType': auditTypes[4],
    'programNum': programNum[2],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-14 10:00:00.000',
    'message': 'insert message here',
    'agency': sites[3],
    'auditType': auditTypes[3],
    'programNum': programNum[3],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-14 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[4],
    'auditType': auditTypes[6],
    'programNum': programNum[4],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-15 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[5],
    'auditType': auditTypes[0],
    'programNum': programNum[5],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 07:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[1],
    'programNum': programNum[6],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 09:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[2],
    'programNum': programNum[7],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 14:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[3],
    'programNum': programNum[8],
    'programType': programType[1],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-16 15:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[4],
    'programNum': programNum[9],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-17 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[7],
    'auditType': auditTypes[0],
    'programNum': programNum[10],
    'programType': programType[1],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-17 20:00:00.000',
    'message': 'insert message here',
    'agency': sites[8],
    'auditType': auditTypes[1],
    'programNum': programNum[9],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-18 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[9],
    'auditType': auditTypes[2],
    'programNum': programNum[8],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-18 20:00:00.000',
    'message': sites[10],
    'agency': sites[10],
    'auditType': auditTypes[3],
    'programNum': programNum[7],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-20 08:00:00.000',
    'message': sites[11],
    'agency': sites[11],
    'auditType': auditTypes[4],
    'programNum': programNum[6],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-20 19:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[0],
    'programNum': programNum[5],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-21 11:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[1],
    'programNum': programNum[4],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-22 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[1],
    'auditType': auditTypes[5],
    'programNum': programNum[6],
    'programType': programType[1],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-22 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[2],
    'auditType': auditTypes[4],
    'programNum': programNum[7],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-23 10:00:00.000',
    'message': 'insert message here',
    'agency': sites[3],
    'auditType': auditTypes[3],
    'programNum': programNum[8],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-23 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[4],
    'auditType': auditTypes[6],
    'programNum': programNum[9],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-24 12:00:00.000',
    'message': 'insert message here',
    'agency': sites[5],
    'auditType': auditTypes[5],
    'programNum': programNum[10],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[0]
  },
  {
    'startTime': '2020-04-25 07:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[1],
    'programNum': programNum[11],
    'programType': programType[2],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-25 09:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[2],
    'programNum': programNum[12],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[0]
  },
  {
    'startTime': '2020-04-25 14:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[3],
    'programNum': programNum[13],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-25 15:00:00.000',
    'message': 'insert message here',
    'agency': sites[6],
    'auditType': auditTypes[4],
    'programNum': programNum[14],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-26 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[7],
    'auditType': auditTypes[0],
    'programNum': programNum[13],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-26 20:00:00.000',
    'message': 'insert message here',
    'agency': sites[8],
    'auditType': auditTypes[1],
    'programNum': programNum[4],
    'programType': programType[0],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-27 08:00:00.000',
    'message': 'insert message here',
    'agency': sites[9],
    'auditType': auditTypes[2],
    'programNum': programNum[0],
    'programType': programType[0],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-27 20:00:00.000',
    'message': sites[10],
    'agency': sites[10],
    'auditType': auditTypes[3],
    'programNum': programNum[2],
    'programType': programType[3],
    'auditor': auditor[0],
    'status': status[1]
  },
  {
    'startTime': '2020-04-28 08:00:00.000',
    'message': sites[11],
    'agency': sites[11],
    'auditType': auditTypes[4],
    'programNum': programNum[3],
    'programType': programType[3],
    'auditor': auditor[1],
    'status': status[1]
  },
  {
    'startTime': '2020-04-28 19:00:00.000',
    'message': 'insert message here',
    'agency': sites[0],
    'auditType': auditTypes[0],
    'programNum': programNum[5],
    'programType': programType[2],
    'auditor': auditor[1],
    'status': status[1]
  },
];
