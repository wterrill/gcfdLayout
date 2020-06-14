import 'package:auditor/Definitions/SiteClasses/Site.dart';
import 'package:hive/hive.dart';

part 'SiteList.g.dart';

@HiveType(typeId: 11)
class SiteList extends HiveObject {
  @HiveField(0)
  List<Site> siteList;

  SiteList({this.siteList}) {}

  String agencyNameFromAgencyNumber(String agencyNumber) {
    for (Site site in siteList) {
      if (site.agencyNumber == agencyNumber) {
        return site.agencyName;
      }
    }
    return "SITE NOT FOUND";
  }

  String agencyNameFromProgramNumber(String programNumber) {
    for (Site site in siteList) {
      if (site.programNumber == programNumber) {
        return site.agencyName;
      }
    }
    return "SITE NOT FOUND";
  }

  Site getSiteFromProgramNumber(String programNumber) {
    Site site;
    for (Site site in siteList) {
      if (site.programNumber == programNumber) {
        site = site;
        return site;
      }
    }
    if (site == null) {
      print("ERROR IN SITE");
    }
    return site;
  }

  Site getSiteFromAgencyNumber(String agencyNumber) {
    Site site;
    for (Site site in siteList) {
      if (site.agencyNumber == agencyNumber) {
        site = site;
        return site;
      }
    }
    if (site == null) {
      print("ERROR IN AGENCY NUMBER LOOKUP FOR SITE");
    }
    return site;
  }

  Site getSiteFromProgramORAgencyNumber(
      String programNumber, String agencyNumber) {
    Site site;
    site = getSiteFromProgramNumber(programNumber);
    if (site == null) {
      site = getSiteFromAgencyNumber(agencyNumber);
    }
    if (site == null) {
      print("ERROR IN PROGRAM LOOKUP FOR SITE");
    }
    return site;
  }
}
