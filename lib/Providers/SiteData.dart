import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

import 'ExternalSiteData.dart';

class SiteData with ChangeNotifier {
  var rowsAsListOfValues;

  SiteData() {
    rowsAsListOfValues = CsvToListConverter().convert(csvData);

    // print(rowsAsListOfValues);
  }
}
