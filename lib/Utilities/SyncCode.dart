import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void totalDataSync(BuildContext context) async {
  Provider.of<GeneralData>(context, listen: false).toggleSyncInProgressOn();
  //// Site Data /////
  // Dialogs.showMessage(
  //     context: context, message: "Syncing Site Data", dismissable: false);
  Provider.of<GeneralData>(context, listen: false)
      .updateSyncMessage("Syncing Site Data");
  print("deviceid");
  String deviceid = Provider.of<GeneralData>(context, listen: false).deviceid;
  print("siteSync");
  await Provider.of<SiteData>(context, listen: false).siteSync();

  SiteList siteList = Provider.of<SiteData>(context, listen: false).siteList;
  // Navigator.of(context).pop();

  /// Schedule data ///
  // Dialogs.showMessage(
  //     context: context,
  //     message: "Syncing Scheduling data: upload and download",
  //     dismissable: false);
  Provider.of<GeneralData>(context, listen: false)
      .updateSyncMessage("Syncing Calendar Data");
  print("ListCalendarData dataSync");
  await Provider.of<ListCalendarData>(context, listen: false).dataSync(
      context: context,
      siteList: siteList,
      deviceid: deviceid,
      fullSync: false);
  // Navigator.of(context).pop();

  /// Audit Data ///
  // Navigator.of(context).pop();
  // Dialogs.showMessage(
  //     context: context,
  //     message: "Syncing Audit calendar data: upload and download",
  //     dismissable: false);

  Provider.of<GeneralData>(context, listen: false)
      .updateSyncMessage("Syncing Audit Data");
  print("AuditData dataSync");
  await Provider.of<AuditData>(context, listen: false).dataSync(
      context: context,
      siteList: siteList,
      deviceid: deviceid,
      fullSync: false);
  // Navigator.of(context).pop();

  /// Done with sync
  Provider.of<GeneralData>(context, listen: false).toggleSyncInProgressOff();
}
