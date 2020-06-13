import 'package:auditor/Definitions/NewSite.dart';
import 'package:hive/hive.dart';

part 'SiteList.g.dart';

@HiveType(typeId: 11)
class SiteList extends HiveObject {
  @HiveField(0)
  final List<NewSite> siteList;

  SiteList({this.siteList}) {}

  String lookupAgencyName(String agencyNumber) {
    // String agencyName;
    for (NewSite site in siteList) {
      if (site.agencyNumber == agencyNumber) {
        return site.agencyName;
      }
    }
    return "SITE NOT FOUND";
  }
}
