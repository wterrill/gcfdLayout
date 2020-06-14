import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:flutter/material.dart';

import 'package:auditor/Definitions/ExternalSiteData.dart';
import 'package:csv/csv.dart';
import 'package:hive/hive.dart';

List<List<dynamic>> rowsAsListOfValues;
List<dynamic> headers;

class SiteData with ChangeNotifier {
  List<List<dynamic>> rowsAsListOfValues;
  List<dynamic> headers;
  SiteList siteList;
  Box siteListBox;
  bool siteListInitialized = false;

  SiteData() {
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
    initHive();
  }

  void initHive() {
    Future siteListFuture = Hive.openBox<SiteList>('siteListBox');

    Future.wait<dynamic>([siteListFuture]).then((List<dynamic> value) {
      print("siteList HIVE INTIALIZED");
      print(value);
      print(value.runtimeType);
      siteListBox = Hive.box<SiteList>('siteListBox');
      siteListInitialized = true;
      siteList = siteListBox.get('siteList') as SiteList;
      notifyListeners();
    });
  }

  void siteSync() async {
    print("sync");
    dynamic result = await SiteComms.getSites();
    print(result);
    siteList = SiteList(siteList: result as List<Site>);
    print(siteList);
    siteListBox.put('siteList', siteList);
    print(siteList);
    notifyListeners();
  }
}
