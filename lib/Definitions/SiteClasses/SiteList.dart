import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:hive/hive.dart';
import 'dart:math';

part 'SiteList.g.dart';

@HiveType(typeId: 11)
class SiteList extends HiveObject {
  @HiveField(0)
  List<Site> siteList;

  SiteList({this.siteList}) {}

  String agencyNumberFromAgencyName(String agencyName) {
    for (Site site in siteList) {
      if (site.agencyName == agencyName) {
        return site.agencyNumber;
      }
    }
    return "SITE NOT FOUND: agencyNumberFromAgencyName";
  }

  String agencyNameFromAgencyNumber(String agencyNumber) {
    for (Site site in siteList) {
      if (site.agencyNumber == agencyNumber) {
        return site.agencyName;
      }
    }
    return "SITE NOT FOUND: agencyNameFromAgencyNumber";
  }

  String agencyNameFromProgramNumber(String programNumber) {
    for (Site site in siteList) {
      if (site.programNumber == programNumber) {
        return site.agencyName;
      }
    }
    return "SITE NOT FOUND agencyNameFromProgramNumber";
  }

  // Site getSiteFromProgramNumber(String programNumber) {
  //   Site site;
  //   for (Site site in siteList) {
  //     if (site.programNumber == programNumber) {
  //       site = site;
  //       return site;
  //     }
  //   }
  //   if (site == null) {
  //     print("ERROR IN SITE: getSiteFromProgramNumber");
  //   }
  //   return site;
  // }

  // Site getSiteFromAgencyNumber({String agencyNumber}) {
  //   Site site;
  //   for (Site site in siteList) {
  //     if (site.agencyNumber == agencyNumber) {
  //       site = site;
  //       return site;
  //     }
  //   }
  //   if (site == null) {
  //     print("ERROR IN AGENCY NUMBER LOOKUP FOR SITE getSiteFromAgencyNumber");
  //   }
  //   return site;
  // }

  Site getSiteFromProgramNumber({String programNumber}) {
    Site site;
    for (Site site in siteList) {
      if (site.programNumber == programNumber) {
        site = site;
        return site;
      }
    }
    if (site == null) {
      print("ERROR IN PROGRAM NUMBER LOOKUP FOR SITE getSiteFromProgramNumber");
    }
    return site;
  }

  Site getRandom() {
    Random random = Random();
    Site site = siteList[random.nextInt(siteList.length)];
    return site;
  }
}
