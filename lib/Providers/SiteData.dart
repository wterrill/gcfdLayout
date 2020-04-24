import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

import 'ExternalSiteData.dart';

class SiteData with ChangeNotifier {
  var rowsAsListOfValues;
  var headers;

  SiteData() {
    rowsAsListOfValues = CsvToListConverter().convert(csvData);
//    print(rowsAsListOfValues);
    headers = rowsAsListOfValues[0];
    rowsAsListOfValues = rowsAsListOfValues.sublist(1);
//    print(headers);
//    print(rowsAsListOfValues);
//    print("@@@@@@@@ finished sites @@@@@@@@");

    // print(rowsAsListOfValues);
  }
}
