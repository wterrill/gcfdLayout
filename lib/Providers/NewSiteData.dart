import 'package:auditor/Definitions/NewSite.dart';
import 'package:auditor/Definitions/SiteList.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:flutter/material.dart';

import 'package:auditor/Definitions/ExternalSiteData.dart';
import 'package:csv/csv.dart';

List<List<dynamic>> rowsAsListOfValues;
List<dynamic> headers;

class NewSiteData with ChangeNotifier {
  List<List<dynamic>> rowsAsListOfValues;
  List<dynamic> headers;
  SiteList siteList;

  NewSiteData() {
    initialize();
    initializeFakeSiteData();
  }

  void initializeFakeSiteData() {
    rowsAsListOfValues = CsvToListConverter().convert(csvDataNew);
    headers = rowsAsListOfValues[0];
    rowsAsListOfValues = rowsAsListOfValues.sublist(1);
    print("headers type: ${headers.runtimeType}");
    print("rowsAsListOfValues type: ${rowsAsListOfValues.runtimeType}");
  }

  void initialize() {
    //TODO get siteData database ready
  }

  void siteSync() async {
    print("sync");
    dynamic result = await SiteComms.getSites();
    print(result);
    siteList = SiteList(siteList: result as List<NewSite>);
    print(siteList);
  }
}
