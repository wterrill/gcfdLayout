import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ntlm/ntlm.dart';

// Future<List<Result>> fetchResults(http.Client client) async {
//   final response =
//       await client.get('https://jsonplaceholder.typicode.com/comments');

//   // Use the compute function to run parseResults in a separate isolate
//   return compute(parseResults, response.body);
// }

// // A function that will convert a response body into a List<Result>
// List<Result> parseResults(String responseBody) {
//   final dynamic parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

//   return parsed
//       .map<Result>((Map<String, dynamic> json) => Result.fromJson(json))
//       .toList() as List<Result>;
// }

// Future<http.Response> fetchAlbum() {
//   return http.get('https://jsonplaceholder.typicode.com/albums/1');
// }

// Future<http.Response> fetchSiteInfo() async {
//   return http.get('http://12.216.81.220:88/api/SiteInfo');
// }

// http://12.216.81.220:88/api/SiteInfo

class testAuthentication extends StatelessWidget {
  const testAuthentication({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NTLMClient client = new NTLMClient(
      domain: "",
      workstation: "LAPTOP",
      username: "MXOTestAud1",
      password: "Password1",
    );

    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () async {
                //TODO: need to turn of CORS headers in the server
                // client
                http
                    .get(
                  "http://12.216.81.220:88/api/AuthenticateUser",
                  // headers: {
                  //   "Access-Control-Allow-Origin":
                  //       "*", // Required for CORS support to work
                  //   "Access-Control-Allow-Credentials":
                  //       "true", // Required for cookies, authorization headers with HTTPS
                  //   "Access-Control-Allow-Headers":
                  //       "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
                  //   "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
                  // },
                )
                    .then((res) {
                  print(res.body);
                });
              },
              child: Text("Authenticate"),
            ),
            RaisedButton(
              onPressed: () {
                // client
                http.get("http://12.216.81.220:88/api/SiteInfo").then((res) {
                  print(res.body);
                });
              },
              child: Text("siteInfo"),
            ),
            RaisedButton(
              onPressed: () {
                // client.post("http://12.216.81.220:88/api/SiteInfo").then((res) {
                //   print(res.body);
                // });
                print(jsonEncode(<String, dynamic>{
                  'AED': 'A',
                  'AgencyNumber': 'A99999',
                  'ProgramNumber': 'PY99999',
                  'ProgramType': 2,
                  'Auditor': 'WillTerrill',
                  'AuditType': 2,
                  'StartTime': '2020-06-15T12:00:00.000Z',
                  'DeviceId': 'abc123'
                }));
                // client
                http
                    .post(
                        'https://cors-anywhere.herokuapp.com/http://12.216.81.220:88/api/Audit/Schedule',
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                          'X-Requested-With': 'XMLHttpRequest',
                        },
                        // body: beer
                        body: jsonEncode(<String, dynamic>{
                          'AED': 'A',
                          'AgencyNumber': 'A00091',
                          'ProgramNumber': 'PY00005',
                          'ProgramType': 1,
                          'Auditor': 'MXOTestAud1',
                          'AuditType': 1,
                          'StartTime': '2020-06-15T12:00:00.000Z',
                          'DeviceId': 'abc123'
                        }))
                    .then((res) {
                  print(res.body);
                });
              },
              child: Text("schedule audit"),
            ),
          ],
        ),
      ),
    );
  }
}

String beer = """ 
{
“AED” : “A”
"AgencyNumber": "A99999",
"ProgramNumber": "PY99999",
"ProgramType": 2,
"Auditor": "WillTerrill",
"AuditType": 2,
"StartTime": "2020-06-15T12:00:00.000Z",
"DeviceId": “abc123”
}
""";

class Post {
  final String userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as String,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userId"] = userId;
    map["title"] = title;
    map["body"] = body;

    return map;
  }
}

// Field Name	Field Type	Nullable	Desc	Example
// AED	string(1)	No	"A: Create
// E: Edit (not use for now)
// D: Delete"

// Auditor	string	No	Users under AppAudit Groups

// AuditType	int	No	"1: Annual
// 2: Food Rescue
// 3: CEDA
// 4: Bi-Annual
// 5: Complaint
// 6: Follow Up
// 7: Grant"

// ProgramType	int	No	"1: Pantry
// 2: Congregate
// 3: Older Adults
// 4: Healthy Student Market"

// AgencyNumber	string	No

// ProgramNumber	string	No

// StartTime	Datetime	No	Start Date + Start Time

// "{
// 	""AgencyNumber"": ""A00091"",
// 	""ProgramNumber"": ""PY00005"",
// 	""ProgramType"": 1,
// 	""Auditor"": ""jchang"",
// 	""AuditType"": 1,
// 	""StartTime"": ""2020-06-05T13:00:00.000Z"",
// 	""DeviceId"": ""xxxyyyzzz"",
// 	PantryDetail:
// 	{
// 		DateOfSiteVisit:""2020-05-29"",
// 		StartOfAudit:""13:00:00.000"",
// 		EndOfAudit:""14:00:00.000"",
// 		GCFDAuditorID:""jchang"",
// 		ProgramContact:""Emily"",
// 		PersonInterviewed:""Nicky"",
// 		ServiceArea:""60607"",
// 		GCFDEstablishedServiceArea:""true"",
// 		GCFDEstablishedServiceAreaComments:"""",
// 		PantryServesOutsideServiceArea:""true"",
// 		PantryServesOutsideServiceAreaComments:"""",
// 		HowManyGuestsTravel:"""",
// 		HowOftenGuestsReceiveFood:""true"",
// 		PantryAllowsFoodAtLeast30Days:""true"",
// 		PantryAllowsFoodAtLeast30DaysComments:"""",
// 		ReferralsRequired:""false"",
// 		ReferralsRequiredComments:""testing"",
// 		AppointmentsRequired:"""",
// 		AppointmentsRequiredComments:"""",
// 		DocumentationRequired:"""",
// 		DocumentationRequiredComments:"""",
// 		DocumentationDescription:"""",
// 		UnderRuralExemption:""true"",
// 		UnderRuralExemptionComments:"""",
// 		HasSoupKitchen:"""",
// 		HasSoupKitchenComments:"""",
// 		FoodProperlySeperatedAndTracked:"""",
// 		FoodProperlySeperatedAndTrackedComments:"""",
// 		OnFoodRescueAgencyEnabled:"""",
// 		OnFoodRescueAgencyEnabledComments:"""",
// 		FoodServiceSanitationManagerCerts:"""",
// 		RemoveField:"""",
// 		LastOrderDate:"""",
// 		NumberOfDeliveriesPerMonth:"""",
// 		OrderHasBeenPlacedInLastMonth:"""",
// 		OrderHasBeenPlacedInLastMonthComments:"""",
// 		IntakeSystemUsedInLastMonth:"""",
// 		IntakeSystemUsedInLastMonthComments:"""",
// 		AgencyLocatorAccurate:"""",
// 		EntranceClearlyMarked:"""",
// 		EntranceClearlyMarkedComments:"""",
// 		OperationHoursDaysPosted:"""",
// 		OperationHoursDaysPostedComments:"""",
// 		ServiceRequirementsPosted:"""",
// 		ServiceRequirementsPostedComments:"""",
// 		GCFDContactInfoPosted:"""",
// 		GCFDContactInfoPostedComments:"""",
// 		TypeOfOutreachUsed:""false"",
// 		TEFAPPostersAccessible:"""",
// 		TEFAPPostersAccessibleComments:"""",
// 		ActivitiesIndicatingFeesRequired:"""",
// 		ActivitiesIndicatingFeesRequiredComments:"""",
// 		OnlineIntakeUtilized:"""",
// 		OnlineIntakeUtilizedComments:"""",
// 		DHSSignatureDocsUsed:"""",
// 		DHSSignatureDocsUsedComments:"""",
// 		GuestSignsName:"""",
// 		GuestSignsNameComments:"""",
// 		AddressRecordedUponReceipt:""false"",
// 		AddressRecordedUponReceiptComments:"""",
// 		HouseholdSizeRecordedUponReceipt:"""",
// 		HouseholdSizeRecordedUponReceiptComments:"""",
// 		GuestSignsEvenForPrivateDonation:"""",
// 		GuestSignsEvenForPrivateDonationComments:"""",
// 		OriginalDHSSigDocsSubmitted:"""",
// 		OriginalDHSSigDocsSubmittedComments:"""",
// 		TEFAPManualAccessible:"""",
// 		TEFAPManualAccessibleComments:"""",
// 		ProxyFormsUsed:"""",
// 		ProxyFormsUsedComments:"""",
// 		ProxyFormsOriginalSignature:"""",
// 		ProxyFormsOriginalSignatureComments:"""",
// 		ProxySignedInPresenceOfPantryPersonnel:"""",
// 		ProxySignedInPresenceOfPantryPersonnelComments:"""",
// 		ProxyFormSignedAtTimeOfDistribution:"""",
// 		ProxyFormSignedAtTimeOfDistributionComments:"""",
// 		TANFCommoditiesDistributed:"""",
// 		TANFCommoditiesDistributedComments:"""",
// 		GuestsCompleteRequiredTANFInfo:"""",
// 		GuestsCompleteRequiredTANFInfoComments:"""",
// 		GuestsWithoutChildrenCompletingTANFInfo:"""",
// 		GuestsWithoutChildrenCompletingTANFInfoComments:"""",
// 		NumberOfTabletsBeingUsed:"""",
// 		NumberOfComputersBeingUsed:"""",
// 		GuestDisposition:"""",
// 		GuestsServedDuringVisit:"""",
// 		GuestServedEachMonth:"""",
// 		VolunteerDispotion:"""",
// 		NumberOfIntakeVolunteers:"""",
// 		NumberOfDistributionVolunteers:"""",
// 		HowDoesPantryRecruitVolunteers:"""",
// 		ActivitiesOtherThanTEFAPDisruping:"""",
// 		ActivitiesOtherThanTEFAPDisrupingComments:""Good"",
// 		DistributionActivitiesAreAppropriate:"""",
// 		DistributionActivitiesAreAppropriateComments:"""",
// 		DistributionStyle:"""",
// 		DistributionNotClientChoiceReason:"""",
// 		FloorsPalletsShelvesClean:"""",
// 		FloorsPalletsShelvesCleanComments:"""",
// 		StorageOrganized:"""",
// 		StorageOrganizedComments:"""",
// 		PestProofContainersUsed:"""",
// 		PestProofContainersUsedComments:"""",
// 		NonFoodItemsStoredSeparately:"""",
// 		NonFoodItemsStoredSeparatelyCommments:"""",
// 		DryFoodRotatedFIFO:"""",
// 		DryFoodRotatedFIFOComments:"""",
// 		DryFoodSixInchesFromFloor:"""",
// 		DryFoodSixInchesFromFloorComments:"""",
// 		DryFoodKeptFromWalls:"""",
// 		DryFoodKeptFromWallsComments:"""",
// 		ProperTempForDryFood:"""",
// 		ProperTempForDryFoodComments:"""",
// 		DryFoodStoredSecurely:"""",
// 		DryFoodStoredSecurelyComments:"""",
// 		DryFoodClearlyMarked:"""",
// 		DryFoodClearlyMarkedComments:"""",
// 		StorageAreaOnlyForApprovedFood:"""",
// 		StorageAreaOnlyForApprovedFoodComments:"""",
// 		DryEquipmentWellMaintained:"""",
// 		DryEquipmentWellMaintainedComments:"""",
// 		AppropriateAmountOfFood:"""",
// 		AppropriateAmountOfFoodComments:"""",
// 		NumCasesOfDryFood:"""",
// 		NumCasesOfMeat:"""",
// 		NumCasesOfPerishableItems:"""",
// 		PantryHasOtherFoodToDistribute:"""",
// 		PantryHasOtherFoodToDistributeComments:"""",
// 		AreaOneComments:"""",
// 		AreaTwoComments:"""",
// 		AreaThreeComments:"""",
// 		AreaFourComments:"""",
// 		UnitsClean:"""",
// 		UnitsCleanComments:"""",
// 		UnitsDefrosted:"""",
// 		UnitsDefrostedComments:"""",
// 		UnitsOrganized:"""",
// 		UnitsOrganizedComments:"""",
// 		ColdFoodRotatedFIFO:"""",
// 		ColdFoodRotatedFIFOComments:"""",
// 		UnitsHaveThermometers:"""",
// 		UnitsHaveThermometersComments:"""",
// 		UnitsOnlyForApprovedPrograms:"""",
// 		UnitsOnlyForApprovedProgramsComments:"""",
// 		ColdFoodAppropriatelyLabeled:"""",
// 		ColdFoodAppropriatelyLabeledComments:"""",
// 		ColdFoodAppropriatelyStocked:"""",
// 		ColdFoodAppropriatelyStockedComments:"""",
// 		UnitsNumbered:"""",
// 		UnitsNumberedComments:"""",
// 		ColdEquipmentWellMaintained:"""",
// 		ColdEquipmentWellMaintainedComments:"""",
// 		RefrigeratedItemsCorrectTemp:"""",
// 		RefrigeratedItemsCorrectTempComments:"""",
// 		FrozenItemsCorrectTemp:"""",
// 		FrozenItemsCorrectTempComments:"""",
// 		ColdStorageUnitOneComments:"""",
// 		ColdStorageUnitOneTemp:"""",
// 		ColdStorageUnitTwoComments:"""",
// 		ColdStorageUnitTwoTemp:"""",
// 		ColdStorageUnitThreeComments:"""",
// 		ColdStorageUnitThreeTemp:"""",
// 		ColdStorageUnitFourComments:"""",
// 		ColdStorageUnitFourTemp:"""",
// 		ColdStorageUnitFiveComments:"""",
// 		ColdStorageUnitFiveTemp:"""",
// 		ColdStorageUnitSixComments:"""",
// 		ColdStorageUnitSixTemp:"""",
// 		ColdStorageUnitSevenComments:"""",
// 		ColdStorageUnitSevenTemp:"""",
// 		ColdStorageUnitEightComments:"""",
// 		ColdStorageUnitEightTemp:"""",
// 		ColdStorageUnitNineComments:"""",
// 		ColdStorageUnitNineTemp:"""",
// 		ColdStorageUnitTenComments:"""",
// 		ColdStorageUnitTenTemp:"""",
// 		WalkInFreezerCoolerComments:"""",
// 		USDATagNumberOne:"""",
// 		SerialNumberOne:"""",
// 		TypeOne:"""",
// 		USDATagNumberTwo:"""",
// 		SerialNumberTwo:"""",
// 		TypeTwo:"""",
// 		USDATagNumberThree:"""",
// 		SerialNumberThree:"""",
// 		TypeThree:"""",
// 		USDATagNumberFour:"""",
// 		SerialNumberFour:"""",
// 		TypeFour:"""",
// 		PlumbingComments:"""",
// 		SewageComments:"""",
// 		GarbageRefusalDisposalComments:"""",
// 		PestControlReportComments:"""",
// 		BuildingWellSealed:"""",
// 		BuildingWellSealedComments:"""",
// 		AppropriateLightingComments:"""",
// 		VentilationComments:"""",
// 		AccessToAllPertinentAreasComments:"""",
// 		PestControlCompany:"""",
// 		EvidenceOfPests:"""",
// 		EvidenceOfPestsComments:"""",
// 		DiscriminationComplaints:"""",
// 		DiscriminationComplaintsComments:"""",
// 		PantryKnowsResolutionDiscriminationComplaint:"""",
// 		PantryKnowsResolutionDiscriminationComplaintComments:"""",
// 		PantryHasFoodDepositoryContactInfoComments:"""",
// 		IssuesFromLastSiteVisit:"""",
// 		DistributionSiteStaffComments:"""",
// 		FoodDepositoryComments:"""",
// 		Donors:"""",
// 		DateTaxExemptionVerified:"""",
// 		ReVerifiedBy:"""",
// 		GCFDMonitor:"""",
// 		ReviewedBy:"""",
// 		FindingsFound:"""",
// 		CorrectiveActionPlanDueDate:""2020/6/30"",
// 		SiteRepresentativeSignature:""2020/6/6"",
// 		FollowUpRequired:""false"",
// 		FollowUpItems:"""",

// 	},

// }
// "

// DeviceId	string(500)	Yes

// Field Name	Field Type
// IsSucc	bool
// ErrMsg	string
