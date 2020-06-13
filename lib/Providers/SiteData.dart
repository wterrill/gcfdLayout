import 'package:auditor/Definitions/ExternalSiteData.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

class SiteData with ChangeNotifier {
  List<List<dynamic>> rowsAsListOfValues;
  List<dynamic> headers;

  SiteData() {
    rowsAsListOfValues = CsvToListConverter().convert(csvDataNew);
    headers = rowsAsListOfValues[0];
    rowsAsListOfValues = rowsAsListOfValues.sublist(1);
    print("headers type: ${headers.runtimeType}");
    print("rowsAsListOfValues type: ${rowsAsListOfValues.runtimeType}");
  }
}

Map<String, dynamic> exampleFromEndpoint = <String, dynamic>{
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
    }
  ]
};
