import 'package:auditor/Definitions/ExternalSiteData.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

class SiteData with ChangeNotifier {
  List<List<dynamic>> rowsAsListOfValues;
  List<dynamic> headers;

  SiteData() {
    rowsAsListOfValues = CsvToListConverter().convert(csvDataNew);
//    print(rowsAsListOfValues);
    headers = rowsAsListOfValues[0];
    rowsAsListOfValues = rowsAsListOfValues.sublist(1);
    print("headers type: ${headers.runtimeType}");
    print("rowsAsListOfValues type: ${rowsAsListOfValues.runtimeType}");
//    print(headers);
//    print(rowsAsListOfValues);
//    print("@@@@@@@@ finished sites @@@@@@@@");

    // print(rowsAsListOfValues);
  }
}
