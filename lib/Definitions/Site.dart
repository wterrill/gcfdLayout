import 'package:hive/hive.dart';

part 'Site.g.dart';

@HiveType(typeId: 3)
class Site extends HiveObject {
  @HiveField(0)
  String siteName;
  @HiveField(1)
  String addressStreet;
  @HiveField(2)
  String city;
  @HiveField(3)
  String state;
  @HiveField(4)
  String zip;
  @HiveField(5)
  String phone;
  @HiveField(6)
  String hoursOfOperation;

  Site({this.siteName}) {
    //TODO: the sitename needs to be constructed here

    city = "Chicago";
    state = "IL";
    zip = "60606";
    phone = "(312)867-5309";
    hoursOfOperation = "M-F 8am-5pm";
    addressStreet = "130 S. Canal";
  }
}

var beer = {
  "IsSucc": true,
  "ErrMsg": "",
  "Result": [
    {
      "ProgramNumber": "PY00002",
      "ProgramName": "PROGRESSIVE LIFE GIVING  DNU",
      "ProgramDisplayName": "PROGRESSIVE DNU - PY00002",
      "AgencyNumber": "A00078",
      "AgencyName": "PROGRESSIVE DNU",
      "Address1": "P.O. BOX 1059",
      "Address2": "C/O Deacon Carl Hale",
      "City": "Maywood",
      "State": null,
      "Zip": null,
      "Contact": "Deacon Carl Hale",
      "OperateHours": "",
      "ServiceArea": null
    },
    {
      "ProgramNumber": "PY00005",
      "ProgramName": "SECOND BAPTIST CHURCH: MAYWOOD",
      "ProgramDisplayName": "SECOND BAPTIST CHURCH: MAYWOOD - PY00005",
      "AgencyNumber": "A00091",
      "AgencyName": "SECOND BAPTIST CHURCH: MAYWOOD",
      "Address1": "436 S 13TH AVE",
      "Address2": null,
      "City": "MAYWOOD",
      "State": null,
      "Zip": null,
      "Contact": "Robert Sykes",
      "OperateHours": "",
      "ServiceArea":
          "N: St. Charles Rd - S: Harrison; E: 9th Ave - W: 21st Ave Include South of the Railroad Tracks"
    },
    {
      "ProgramNumber": "PY00028",
      "ProgramName": "DO NOT USE",
      "ProgramDisplayName": "ROSELAND CHRISTIAN MINISTRIES - PY00028",
      "AgencyNumber": "A00052",
      "AgencyName": "ROSELAND CHRISTIAN MINISTRIES",
      "Address1": null,
      "Address2": null,
      "City": null,
      "State": null,
      "Zip": null,
      "Contact": null,
      "OperateHours": "",
      "ServiceArea": null
    },
    {
      "ProgramNumber": "PY00030",
      "ProgramName": "DNU",
      "ProgramDisplayName": "ST. ELIZABETH CATHOLIC DNU - PY00030",
      "AgencyNumber": "A00009",
      "AgencyName": "ST. ELIZABETH CATHOLIC DNU",
      "Address1": null,
      "Address2": null,
      "City": null,
      "State": null,
      "Zip": null,
      "Contact": null,
      "OperateHours": "",
      "ServiceArea": null
    },
    {
      "ProgramNumber": "PY00035",
      "ProgramName": "DO NOT USE",
      "ProgramDisplayName": "TSA: TOM SEAY CENTER PY - PY00035",
      "AgencyNumber": "A00015",
      "AgencyName": "TSA: TOM SEAY CENTER PY",
      "Address1": null,
      "Address2": null,
      "City": null,
      "State": null,
      "Zip": null,
      "Contact": null,
      "OperateHours": "",
      "ServiceArea": null
    },
    {
      "ProgramNumber": "PY00049",
      "ProgramName": " DNU",
      "ProgramDisplayName": "SVDP: DAYCAREDNU - PY00049",
      "AgencyNumber": "A00032",
      "AgencyName": "SVDP: DAYCAREDNU",
      "Address1": null,
      "Address2": null,
      "City": null,
      "State": null,
      "Zip": null,
      "Contact": null,
      "OperateHours": "",
      "ServiceArea": null
    },
    {
      "ProgramNumber": "PY00062",
      "ProgramName": "MT. CARMEL PARISH (CASA)",
      "ProgramDisplayName": "MT. CARMEL PARISH (CASA) - PY00062",
      "AgencyNumber": "A00090",
      "AgencyName": "MT. CARMEL PARISH (CASA)",
      "Address1": "1101 N 23RD AVE",
      "Address2": null,
      "City": "Melrose Park",
      "State": null,
      "Zip": null,
      "Contact": "John Battisto",
      "OperateHours": "",
      "ServiceArea": "Zip code 60160, Melrose Park and Stone Park"
    },
    {
      "ProgramNumber": "PY00067",
      "ProgramName": "AMERICAN INDIAN CENTER",
      "ProgramDisplayName": "AMERICAN INDIAN CENTER DNU - PY00067",
      "AgencyNumber": "A00020",
      "AgencyName": "AMERICAN INDIAN CENTER DNU",
      "Address1": "1630 W WILSON AVE",
      "Address2": null,
      "City": "Chicago",
      "State": null,
      "Zip": null,
      "Contact": "Cyndee Fox-Starr",
      "OperateHours": "",
      "ServiceArea": "Zip Code: 60640"
    },
    {
      "ProgramNumber": "PY00071",
      "ProgramName": "HISPANIC LUTHERAN  DNU",
      "ProgramDisplayName": "HISPANIC LUTHERAN DNU - PY00071",
      "AgencyNumber": "A00079",
      "AgencyName": "HISPANIC LUTHERAN DNU",
      "Address1": "3455 WEST NORTH AVENUE",
      "Address2": null,
      "City": "CHICAGO",
      "State": null,
      "Zip": null,
      "Contact": "DAHANA DEBESA",
      "OperateHours": "",
      "ServiceArea": null
    },
    {
      "ProgramNumber": "PY00072",
      "ProgramName": "PALOS UNITED METHODIST",
      "ProgramDisplayName": "PALOS UNITED METHODIST - PY00072",
      "AgencyNumber": "A00088",
      "AgencyName": "PALOS UNITED METHODIST",
      "Address1": "12101 S HARLEM AVE",
      "Address2": null,
      "City": "Palos Heights",
      "State": null,
      "Zip": null,
      "Contact": "Susan Greer",
      "OperateHours": "",
      "ServiceArea": "N: 79th St - S: 135th St, E: Cicero - W: La Grange Ave"
    }
  ]
};

// List<String> sites = [
//   "Manna",
//   "Marillac House",
//   "Irving Park",
//   "Ravenswood",
//   "LakeView",
//   "Casa Catalina",
//   "St Cyprian's",
//   "Chicago Hope",
//   "Care for Real",
//   "Common",
//   "Care for Friends",
//   "New Morning Star"
// ];

// List<String> cities = [
//   "Chicago",
//   "Chicago",
//   "Chicago",
//   "Chicago",
//   "Chicago",
//   "Chicago",
//   "Chicago",
//   "Chicago",
//   "Chicago",
//   "Chicago",
//   "Chicago",
//   "Chicago"
// ];
