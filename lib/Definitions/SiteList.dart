import 'package:auditor/Definitions/Site.dart';
import 'package:hive/hive.dart';

part 'SiteList.g.dart';

@HiveType(typeId: 11)
class SiteList extends HiveObject {
  @HiveField(0)
  List<Site> siteList;

  SiteList({this.siteList}) {}

  String agencyNameFromAgencyNumber(String agencyNumber) {
    // String agencyName;
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
}
