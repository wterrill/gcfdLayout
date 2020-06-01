import 'package:hive/hive.dart';

part 'Site.g.dart';

@HiveType(typeId: 3)
class Site extends HiveObject {
  @HiveField(0)
  String siteName;
  @HiveField(1)
  String addressStreet;
  @HiveField(2)
  String city;
  @HiveField(3)
  String state;
  @HiveField(4)
  String zip;
  @HiveField(5)
  String phone;
  @HiveField(6)
  String hoursOfOperation;

  Site({this.siteName}) {
    this.siteName = "Manna";
    int index = sites.indexOf(siteName);
    city = cities[index];
    state = states[index];
    zip = zips[index];
    phone = phones[index];
    hoursOfOperation = hoursOfOperations[index];
    addressStreet = addressStreets[index];
  }
}

List<String> sites = [
  "Manna",
  "Marillac House",
  "Irving Park",
  "Ravenswood",
  "LakeView",
  "Casa Catalina",
  "St Cyprian's",
  "Chicago Hope",
  "Care for Real",
  "Common",
  "Care for Friends",
  "New Morning Star"
];

List<String> cities = [
  "Chicago",
  "Chicago",
  "Chicago",
  "Chicago",
  "Chicago",
  "Chicago",
  "Chicago",
  "Chicago",
  "Chicago",
  "Chicago",
  "Chicago",
  "Chicago"
];

List<String> states = [
  "IL",
  "IL",
  "IL",
  "IL",
  "IL",
  "IL",
  "IL",
  "IL",
  "IL",
  "IL",
  "IL",
  "IL"
];

List<String> zips = [
  "60601",
  "60602",
  "60603",
  "60604",
  "60605",
  "60606",
  "60607",
  "60608",
  "60609",
  "60610",
  "60611",
  "60612"
];

List<String> phones = [
  "(312)857-5309",
  "(773)857-5310",
  "(312)857-5311",
  "(773)857-5312",
  "(312)857-5313",
  "(773)857-5314",
  "(312)867-5315",
  "(773)867-5316",
  "(312)867-5317",
  "(773)867-5318",
  "(312)867-5319",
  "(773)867-5320"
];

List<String> hoursOfOperations = [
  "10am - 10pm",
  "1pm - 3pm",
  "4pm - 8pm",
  "8am - 4pm",
  "8am - 6pm",
  "1pm - 3pm",
  "8am - 4pm",
  "8am - 6pm",
  "10am - 10pm",
  "8am - 6pm",
  "10am - 10pm",
  "8am - 6pm"
];

List<String> addressStreets = [
  "123 Bear St.",
  "234 Elk St.",
  "345 Moose St.",
  "456 Deer St.",
  "567 Beaver St.",
  "678 Raccoon St.",
  "789 Muskrat St.",
  "8910 Turkey St.",
  "91011 Duck St.",
  "101112 Pheasant St.",
  "121314 Quail St.",
  "131415 Goose Ave."
];
