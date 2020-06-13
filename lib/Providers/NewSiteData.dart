import 'package:auditor/Definitions/NewSite.dart';
import 'package:auditor/Definitions/SiteList.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:flutter/material.dart';

class NewSiteData with ChangeNotifier {
  List<List<dynamic>> rowsAsListOfValues;
  List<dynamic> headers;
  SiteList siteList;

  NewSiteData() {
    initialize();
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
