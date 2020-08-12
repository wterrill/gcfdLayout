import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/SiteClasses/SiteList.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/main.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:auditor/providers/SiteData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

void totalDataSync(BuildContext context) async {
  try {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network. or a wifi network
      print("######### CONNECTED upload pic list #########");
    } else {
      throw ("No internet connection found");
    }

    //// Site Data /////
    _showToast(context, "Syncing Data", Icon(Icons.sync));
    Provider.of<GeneralData>(context, listen: false).updateSyncMessage("Syncing");
    print("deviceid");
    String deviceid = Provider.of<GeneralData>(context, listen: false).deviceid;
    print("siteSync");
    try {
      await Provider.of<SiteData>(context, listen: false).siteSync();
    } catch (err) {
      print(err);
      // Dialogs.showMessage(
      //     context: navigatorKey.currentContext,
      //     message: "An error occurred while contacting the site data endpoint. Check internet connection",
      //     dismissable: true);
    }

    SiteList siteList = Provider.of<SiteData>(context, listen: false).siteList;

    print("ListCalendarData dataSync");
    await Provider.of<ListCalendarData>(context, listen: false)
        .dataSync(context: context, siteList: siteList, deviceid: deviceid, fullSync: false);

    print("AuditData dataSync");
    await Provider.of<AuditData>(context, listen: false)
        .dataSync(context: context, siteList: siteList, deviceid: deviceid, fullSync: false);

    /// Done with sync
    _showToast(context, "Synced Successfully", Icon(Icons.check));
  } catch (err) {
    print("failed");
    // Dialogs.showMessage(
    //     context: navigatorKey.currentContext,
    //     message: "An error occurred while contacting the site data endpoint. Check internet connection",
    //     dismissable: true);
  }
}

void _showToast(BuildContext context, String message, Icon icon) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: ColorDefs.colorAnotherDarkGreen,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        SizedBox(
          width: 12.0,
        ),
        Text(message, style: ColorDefs.textBodyWhite25),
      ],
    ),
  );

  FToast(context).showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );
}
