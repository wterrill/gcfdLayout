// List<String> audit1Sections = [
//   'Confirm Details',
//   'Intro',
//   'Signage',
//   'Distribution & Intake',
//   'Dry Storage',
//   'Cold Storage',
//   'Other',
//   'Complaints & Problems',
//   'Review',
//   'Verification'
// ];

List<Map<String, dynamic>> confirmDetails = [
  <String, dynamic>{'text': 'Date of Visit:', 'type': 'display'},
  <String, dynamic>{'text': 'Start Time:', 'type': 'display'},
  <String, dynamic>{'text': 'Type of Visit:', 'type': 'display'},
  <String, dynamic>{'text': 'Agency Name:', 'type': 'display'},
  <String, dynamic>{'text': 'Agency/Program Number:', 'type': 'display'},
  <String, dynamic>{'text': 'Site address:', 'type': 'display'},
  <String, dynamic>{'text': 'GCFD Monitor:', 'type': 'display'},
  <String, dynamic>{'text': 'Program Contact:', 'type': 'display'},
  <String, dynamic>{
    'text': 'Person Interviewed:',
    'type': 'fillInInterview',
    'databaseVar': 'PersonInterviewed',
    'databaseVarType': 'string'
  },
  <String, dynamic>{'text': 'Program Operating Hours:', 'type': 'display'},
  <String, dynamic>{'text': 'Service Area:', 'type': 'display'},
];

// Map<String, dynamic> audit1Section1 = <String, dynamic>{
//   'name': 'Pantry Policy/Procedure Checklist',
//   'questions': audit1Section1Questions,
//   'sectionName': 'Intro',
// };

List<Map<String, dynamic>> audit1Section1Questions = [
  <String, dynamic>{
    'text': 'Did the Food Depository establish the service area?',
    'type': 'yesNo',
    'databaseVar': 'GCFDEstablishedServiceArea',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GCFDEstablishedServiceAreaComments',
  },
  <String, dynamic>{
    'text': 'Does pantry serve outside this service area?',
    'type': 'yesNo',
    'databaseVar': 'PantryServesOutsideServiceArea',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PantryServesOutsideServiceAreaComments'
  },
  <String, dynamic>{
    'text': 'If yes, how many and from where do guests travel?',
    'type': 'fillIn',
    'databaseVar': 'HowManyGuestsTravel',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'How often can a guest receive food from the pantry?',
    'type': 'dropDown',
    'menuItems': [
      'Select',
      '1x per week',
      '2x per Month',
      '1x per Month',
      'Other'
    ],
    'happyPathResponse': [
      '1x per week',
      '2x per Month',
      '1x per Month',
      'Other'
    ],
    'databaseVar': 'HowOftenGuestsReceiveFood',
    'databaseVarType': 'string',
    'databaseOptCom': 'HowOftenGuestsReceiveFoodComments'
  },
  <String, dynamic>{
    'text':
        'Does the pantry allow guests to receive food at least once every 30 days?',
    'type': 'yesNo',
    'databaseVar': 'PantryAllowsFoodAtLeast30Days',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PantryAllowsFoodAtLeast30DaysComments',
  },
  <String, dynamic>{
    'text': 'Are referrals from an outside agency required to receive food?',
    'type': 'yesNo',
    'databaseVar': 'ReferralsRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ReferralsRequiredComments',
  },
  <String, dynamic>{
    'text': 'Are appointments required to receive food?',
    'type': 'yesNo',
    'databaseVar': 'AppointmentsRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AppointmentsRequiredComments',
  },
  <String, dynamic>{
    'text': 'Does the pantry require any documentation?',
    'type': 'yesNo',
    'databaseVar': 'DocumentationRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DocumentationRequiredComments',
  },
  <String, dynamic>{
    'text':
        'Describe the types of documentation requested and the purpose (only allowed to verify residency and identity):',
    'type': 'fillIn',
    'databaseVar': 'DocumentationDescription',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Does this pantry operate under the rural exemption?',
    'type': 'yesNo',
    'databaseVar': 'UnderRuralExemption',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnderRuralExemptionComments',
  },
  <String, dynamic>{
    'text': 'Does this food pantry also operate a soup kitchen?',
    'type': 'yesNo',
    'databaseVar': 'HasSoupKitchen',
    'databaseVarType': 'bool',
    'databaseOptCom': 'HasSoupKitchenComments'
  },
  <String, dynamic>{
    'text':
        'If yes, is the food properly separated and tracked for two programs?',
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'FoodProperlySeperatedAndTracked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FoodProperlySeperatedAndTrackedComments',
    'actionItem':
        'Ensure food is properly separated and tracked by each program '
  },
  <String, dynamic>{
    'text': 'Is Program on Food Rescue/Agency Enabled?',
    'type': 'yesNo',
    'databaseVar': 'OnFoodRescueAgencyEnabled',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OnFoodRescueAgencyEnabledComments',
  },
  <String, dynamic>{
    'text': 'Food Service Sanitation Manager Certificates',
    'type': 'fillIn',
    'databaseVar': 'FoodServiceSanitationManagerCerts',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Remove:',
    'type': 'fillIn',
    'databaseVar': 'RemoveField',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Last Order Date:',
    'type': 'date',
    'databaseVar': 'LastOrderDate',
    'databaseVarType': 'date',
    'databaseOptCom': 'LastOrderDateComments'
  },
  <String, dynamic>{
    'text': 'What is the number of deliveries per month?',
    'type': 'dropDown',
    'menuItems': ['Select', '1', '2', '3', '4', '5', 'Other'],
    'databaseVar': 'NumberOfDeliveriesPerMonth',
    'databaseOptCom': 'NumberOfDeliveriesPerMonthComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Has an order been placed from the menu in the past month?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'OrderHasBeenPlacedInLastMonth',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OrderHasBeenPlacedInLastMonthComments',
    'actionItem':
        'Ensure an order is placed at least once a month. Please provide an explanation why an order has not been placed within the past month'
  },
  <String, dynamic>{
    'text': 'Has an online intake system been used in the past month?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'IntakeSystemUsedInLastMonth',
    'databaseVarType': 'bool',
    'databaseOptCom': 'IntakeSystemUsedInLastMonthComments',
    'actionItem': 'Ensure appropriate intake and meal count system is utilized'
  },
  <String, dynamic>{
    'text': 'Is information on our Agency Locator accurate?',
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Yes',
      'No',
      'Closed Program',
    ],
    'happyPathResponse': ['Yes', 'No', 'Closed Program'],
    'databaseVar': 'AgencyLocatorAccurate',
    'databaseVarType': 'string',
    'databaseOptCom': 'AgencyLocatorAccurateComments',
  },
];

List<Map<String, dynamic>> audit1Section2Questions = [
  <String, dynamic>{
    'text': "Is entrance clearly marked?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'EntranceClearlyMarked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'EntranceClearlyMarkedComments',
    'actionItem':
        'Ensure entrance to program is clearly marked and visible to guests'
  },
  <String, dynamic>{
    'text': "Is there a sign posted outside with days and hours of operation?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'OperationHoursDaysPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OperationHoursDaysPostedComments',
    'actionItem':
        'Post established days / hours / service areas of operation to be viewed from outside of the building'
  },
  <String, dynamic>{
    'text':
        "Is there a sign posted with service requirements/guidelines visible to guests?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ServiceRequirementsPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ServiceRequirementsPostedComments',
    'actionItem':
        'Post guidelines for receiving service in an area visible to guests.'
  },
  <String, dynamic>{
    'text': "Is the Food Depository contact information posted?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'GCFDContactInfoPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GCFDContactInfoPostedComments',
    'actionItem': 'Post Food Depository’s contact information. '
  },
  <String, dynamic>{
    'text':
        "What types of public outreach and networking does the pantry use to make the general public aware of their services?",
    'type': 'fillIn',
    'databaseVar': 'TypeOfOutreachUsed',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text':
        "Are TEFAP posters accessible to guests?(Ex: Income Eligibility, Prohibited Activities, 'And Justice for All')",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'TEFAPPostersAccessible',
    'databaseVarType': 'bool',
    'databaseOptCom': 'TEFAPPostersAccessibleComments',
    'actionItem': 'Post appropriate USDA signage (if applicable).'
  },
];

List<Map<String, dynamic>> audit1Section3Questions = [
  <String, dynamic>{
    'text':
        "Are activities conducted that might be interpreted as requiring fees/donations/memberships?",
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'databaseVar': 'ActivitiesIndicatingFeesRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ActivitiesIndicatingFeesRequiredComments',
    'actionItem':
        'Comply with the Illinois Department of Human Services’ rules concerning client self-attestation for eligibility for service'
  },
  <String, dynamic>{
    'text': "Is an online intake system being utilized?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'OnlineIntakeUtilized',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OnlineIntakeUtilizedComments',
    'actionItem':
        'Appropriate intake and meal count system should be utilized. '
  },
  <String, dynamic>{
    'text': "If it is not being utilized, are DHS signature documents used?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'DHSSignatureDocsUsed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DHSSignatureDocsUsedComments',
    'actionItem': 'Ensure DHS document is utilized during intake'
  },
  <String, dynamic>{
    'text': "Does the guest sign his/her name upon receipt?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'GuestSignsName',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestSignsNameComments',
    'actionItem': 'Ensure guests signature is obtained during intake'
  },
  <String, dynamic>{
    'text': "Is the address recorded upon receipt?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'AddressRecordedUponReceipt',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AddressRecordedUponReceiptComments',
    'actionItem': 'Ensure address is recorded when applicable'
  },
  <String, dynamic>{
    'text': "Is the household size recorded upon receipt?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'HouseholdSizeRecordedUponReceipt',
    'databaseVarType': 'bool',
    'databaseOptCom': 'HouseholdSizeRecordedUponReceiptComments',
    'actionItem': 'Ensure household size is recorded during intake'
  },
  <String, dynamic>{
    'text':
        "Does the pantry have the guest sign even if only privately donated food is received?",
    'type': 'yesNo',
    'databaseVar': 'GuestSignsEvenForPrivateDonation',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestSignsEvenForPrivateDonationComments',
  },
  <String, dynamic>{
    'text':
        "Are original DHS signature documents and surveys submitted to the Food Depository monthly?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'OriginalDHSSigDocsSubmitted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OriginalDHSSigDocsSubmittedComments',
    'actionItem':
        'Ensure original DHS signature documents and surveys are submitted to the Food Depository '
  },
  <String, dynamic>{
    'text': "Is the TEFAP manual accessible to pantry staff and/or volunteers?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'TEFAPManualAccessible',
    'databaseVarType': 'bool',
    'databaseOptCom': 'TEFAPManualAccessibleComments',
    'actionItem':
        'When the TEFAP manual is not accessible to staff and volunteers, please explain what action takes place to remedy this. (Ex: a copy will be emailed to program contact)',
  },
  <String, dynamic>{
    'text': "Are proxy forms used?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'ProxyFormsUsed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxyFormsUsedComments',
    'actionItem': 'Please utilize proxy forms when appropriate'
  },
  <String, dynamic>{
    'text':
        "If yes, do they contain the original signature of the recipient getting food?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'ProxyFormsOriginalSignature',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxyFormsOriginalSignatureComments',
    'actionItem': 'Ensure original signatures are collected on Proxy forms'
  },

  <String, dynamic>{
    'text':
        "Does the proxy sign the proxy form in the presence of pantry personnel?",
    'type': 'yesNoNa',
    'databaseVar': 'ProxySignedInPresenceOfPantryPersonnel',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxySignedInPresenceOfPantryPersonnelComments',
  },
  <String, dynamic>{
    'text':
        "Do pantry personnel sign the proxy form at the time of distribution?",
    'type': 'yesNoNa',
    'databaseVar': 'ProxyFormSignedAtTimeOfDistribution',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxyFormSignedAtTimeOfDistributionComments',
  },
  <String, dynamic>{
    'text': "Are TANF commodities being distributed?",
    'type': 'yesNo',
    'databaseVar': 'TANFCommoditiesDistributed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'TANFCommoditiesDistributedComments'
  },

  <String, dynamic>{
    'text': "If yes, do guests complete the required TANF information?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'GuestsCompleteRequiredTANFInfo',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestsCompleteRequiredTANFInfoComments',
    'actionItem': 'Ensure that TANF information is completed'
  },
  <String, dynamic>{
    'text':
        "Are guests without children in the household completing TANF information?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'GuestsWithoutChildrenCompletingTANFInfo',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestsWithoutChildrenCompletingTANFInfoComments',
    'actionItem':
        'Ensure guests without children are completing the TANF information'
  },
  <String, dynamic>{
    'text': "Technology being used:	#of Tablets:",
    'type': 'fillInNum',
    'databaseVar': 'NumberOfTabletsBeingUsed',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': "#of Computers:",
    'type': 'fillInNum',
    'databaseVar': 'NumberOfComputersBeingUsed',
    'databaseVarType': 'int',
  },

  <String, dynamic>{
    'text': "Guest disposition",
    'type': 'fillIn',
    'databaseVar': 'GuestDisposition',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "Guests served during site visit:",
    'type': 'fillInNum',
    'databaseVar': 'GuestsServedDuringVisit',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': "Guests served each month:",
    'type': 'fillInNum',
    'databaseVar': 'GuestServedEachMonth',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': "Volunteer disposition:",
    'type': 'fillIn',
    'databaseVar': 'VolunteerDisposition',
    'databaseVarType': 'string',
  },

  <String, dynamic>{
    'text': "# of Intake Volunteers",
    'type': 'dropDown',
    'menuItems': ['Select', '1-10', '11-20', '21-30', '31-40', '41-50'],
    'happyPathResponse': ['1-10', '11-20', '21-30', '31-40', '41-50'],
    'databaseVar': 'NumberOfIntakeVolunteers',
    'databaseVarType': 'string',
    'databaseOptCom': 'NumberOfIntakeVolunteersComments'
  },

  <String, dynamic>{
    'text': "# of Distribution volunteers:",
    'type': 'dropDown',
    'menuItems': ['Select', '1-10', '11-20', '21-30', '31-40', '41-50'],
    'happyPathResponse': ['1-10', '11-20', '21-30', '31-40', '41-50'],
    'databaseVar': 'NumberOfDistributionVolunteers',
    'databaseVarType': 'string',
    'databaseOptCom': 'NumberOfDistributionVolunteersComments'
  },
  <String, dynamic>{
    'text': "How does the pantry recruit volunteers?",
    'type': 'fillIn',
    'databaseVar': 'HowDoesPantryRecruitVolunteers',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "Are other activities unrelated to TEFAP disrupting distribution?",
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'databaseVar': 'ActivitiesOtherThanTEFAPDisrupting',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ActivitiesOtherThanTEFAPDisruptingComments',
    'actionItem':
        'Ensure no other activities unrelated to TEFAP are conducted during distribution'
  },
  <String, dynamic>{
    'text': "Do all distribution activities appear to be appropriate?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DistributionActivitiesAreAppropriate',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DistributionActivitiesAreAppropriateComments',
    'actionItem':
        'Ensure activities pertaining to distribution are conducted only'
  },
  <String, dynamic>{
    'text':
        "Distribution style: (if not client choice, indicate why in the comments",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Client Choice',
      'Prepacked',
      'Partial Client Choice'
    ],
    'happyPathResponse': [
      'Client Choice',
      'Prepacked',
      'Partial Client Choice'
    ],
    'databaseVar': 'DistributionStyle',
    'databaseVarType': 'string',
    'databaseOptCom': 'DistributionStyleComments'
  },

  // <String, dynamic>{
  //   'text': "If not client choice, why?",
  //   'type': 'fillIn',
  //   'databaseVar': 'DistributionNotClientChoiceReason',
  //   'databaseVarType': 'string'
  // },
];

List<Map<String, dynamic>> audit1Section4Questions = [
  <String, dynamic>{
    'text': 'Are floors, pallets, and shelving clean?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'FloorsPalletsShelvesClean',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FloorsPalletsShelvesCleanComments',
    'actionItem': 'Clean and organize floors, pallets, and shelving'
  },
  <String, dynamic>{
    'text': 'Is storage area organized?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'StorageOrganized',
    'databaseVarType': 'bool',
    'databaseOptCom': 'StorageOrganizedComments',
    'actionItem': 'Clean and organize storage area'
  },
  <String, dynamic>{
    'text': 'Are pest proof containers utilized?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'PestProofContainersUsed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PestProofContainersUsedComments',
    'actionItem':
        'Acquire / Utilize pest-proof containers for packaged items such as pasta, cereal, rice, flour, beans, cornmeal, etc. Please submit receipt for pest-proof containers '
  },
  <String, dynamic>{
    'text': 'Are non-food items and toxic items stored separately?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'NonFoodItemsStoredSeparately',
    'databaseVarType': 'bool',
    'databaseOptCom': 'NonFoodItemsStoredSeparatelyComments',
    'actionItem':
        'Separate cleaning agents and other chemicals from stored food / contact surfaces'
  },
  <String, dynamic>{
    'text': 'Is dry food being rotated via FIFO?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryFoodRotatedFIFO',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodRotatedFIFOComments',
    'actionItem':
        'Ensure the “First in First Out” method is followed with dry food'
  },
  <String, dynamic>{
    'text': 'Is food 6 inches off floor?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryFoodSixInchesFromFloor',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodSixInchesFromFloorComments',
    'actionItem':
        'Remove all boxes of food (cardboard /paper) from the floor or at least 6” above the floor'
  },
  <String, dynamic>{
    'text':
        'Is food kept far enough away from walls and floor to permit good air circulation and to allow for pest control?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryFoodKeptFromWalls',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodKeptFromWallsComments',
    'actionItem':
        'Ensure adequate space is between food from walls and floor to permit good air circulation and pest control'
  },
  <String, dynamic>{
    'text': 'Are proper temperatures for dry food storage maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ProperTempForDryFood',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProperTempForDryFoodComments',
    'actionItem':
        'Acquire or Utilize Heater or AC to maintain proper temperature in dry storage area to maintain temperature between 50F and 70F. Please submit receipt for Heater or AC '
  },
  <String, dynamic>{
    'text':
        'Is the food stored in a secure location with adequate space? If no, explain:',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryFoodStoredSecurely',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodStoredSecurelyComments',
    'actionItem':
        'Acquire or Utilize locks to secure cold storage units and/or dry storage area. Please submit receipt for locks '
  },
  <String, dynamic>{
    'text': 'Is food clearly marked for use by food program only?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryFoodClearlyMarked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodClearlyMarkedComments',
    'actionItem':
        'Clearly label Program Food from food used for other purposes (i.e. personal use).'
  },
  <String, dynamic>{
    'text': 'Is storage area only for approved food program?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'StorageAreaOnlyForApprovedFood',
    'databaseVarType': 'bool',
    'databaseOptCom': 'StorageAreaOnlyForApprovedFoodComments',
    'actionItem': 'Ensure storage area is only used for approved program food'
  },
  <String, dynamic>{
    'text': 'Is equipment well maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryEquipmentWellMaintained',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryEquipmentWellMaintainedComments',
    'actionItem': 'Ensure dry food equipment is maintained and working properly'
  },
  <String, dynamic>{
    'text': 'Appropriate amount of food in inventory?',
    'type': 'yesNo',
    'databaseVar': 'AppropriateAmountOfFood',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AppropriateAmountOfFoodComments'
  },
  // <String, dynamic>{
  //   'text': '# of cases of dry food currently in inventory:',
  //   'type': 'fillInNum',
  //   'databaseVar': 'NumCasesOfDryFood',
  //   'databaseVarType': 'int',
  // },

  <String, dynamic>{
    'text': "# of cases of dry food currently in inventory:",
    'type': 'dropDown',
    'menuItems': ['Select', '1-300', '300-500', '500-1000'],
    'happyPathResponse': ['1-300', '300-500', '500-1000'],
    'databaseVar': 'NumCasesOfDryFood',
    'databaseVarType': 'string',
    'databaseOptCom': 'NumCasesOfDryFoodComments'
  },

  <String, dynamic>{
    'text': '# of cases of meat currently in inventory: ',
    'type': 'fillInNum',
    'databaseVar': 'NumCasesOfMeat',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': '# of cases of perishable items in inventory: ',
    'type': 'fillInNum',
    'databaseVar': 'NumCasesOfPerishableItems',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text':
        'Does the pantry have other foods to distribute with government commodities? (Please indicate other foods in the comments)',
    'type': 'yesNoNa',
    'databaseVar': 'PantryHasOtherFoodToDistribute',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PantryHasOtherFoodToDistributeComments'
  },
  <String, dynamic>{
    'text': 'Area 1: ',
    'type': 'fillIn',
    'databaseVar': 'AreaOneComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Area 2: ',
    'type': 'fillIn',
    'databaseVar': 'AreaTwoComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Area 3: ',
    'type': 'fillIn',
    'databaseVar': 'AreaThreeComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Area 4: ',
    'type': 'fillIn',
    'databaseVar': 'AreaFourComments',
    'databaseVarType': 'string',
  },
];

List<Map<String, dynamic>> audit1Section5Questions = [
  <String, dynamic>{
    'text': 'Are units clean?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsClean',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsCleanComments',
    'actionItem': 'Clean units. Please specify unit number'
  },
  <String, dynamic>{
    'text': 'Are units defrosted?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsDefrosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsDefrostedComments',
    'actionItem': 'Defrost units. Please specify unit number'
  },
  <String, dynamic>{
    'text': 'Are units organized?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsOrganized',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsOrganizedComments',
    'actionItem': 'Organize units.  Please specify unit number'
  },
  <String, dynamic>{
    'text': 'Is cold food being rotated via FIFO?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdFoodRotatedFIFO',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdFoodRotatedFIFOComments',
    'actionItem':
        'Ensure the “First in First Out” method is followed with cold food'
  },
  <String, dynamic>{
    'text': 'Do units have thermometers?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsHaveThermometers',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsHaveThermometersComments',
    'actionItem':
        "Acquire or Utilize thermometers for cold storage units. Please submit receipt for thermometers."
  },
  <String, dynamic>{
    'text': 'Are units only for approved food program?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsOnlyForApprovedPrograms',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsOnlyForApprovedProgramsComments',
    'actionItem': 'Utilize program unit for approved program food only'
  },
  <String, dynamic>{
    'text': 'Is food appropriately labeled?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdFoodAppropriatelyLabeled',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdFoodAppropriatelyLabeledComments',
    'actionItem':
        'Clearly label Program Food from food used for other purposes (i.e. personal use)'
  },
  <String, dynamic>{
    'text':
        'Is food appropriately stocked and not overstuffed in units? (Please indicate which units in the comments',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdFoodAppropriatelyStocked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdFoodAppropriatelyStockedComments',
    'actionItem':
        'Organize units and ensure they are not overstuffed. Indicate units: '
  },
  <String, dynamic>{
    'text': 'Are units numbered?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsNumbered',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsNumberedComments',
    'actionItem':
        'Number units.  (please specify units that need to be numbered in the comments)'
  },
  <String, dynamic>{
    'text': 'Is equipment well maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdEquipmentWellMaintained',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdEquipmentWellMaintainedComments',
    'actionItem':
        'Ensure cold food equipment is maintained and working properly'
  },
  <String, dynamic>{
    'text': 'Are cold storage units secured?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdStorageUnitsSecured',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdStorageUnitsSecuredComments',
    'actionItem':
        "Acquire or Utilize locks to secure cold storage units and/or dry storage area. Please submit receipt for locks "
  },
  <String, dynamic>{
    'text':
        'Are refrigerated items kept at temperatures between 35-40 degrees Fahrenheit?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'RefrigeratedItemsCorrectTemp',
    'databaseVarType': 'bool',
    'databaseOptCom': 'RefrigeratedItemsCorrectTempComments',
    'actionItem':
        'Ensure refrigerator temperature is maintained between 35°F and 40°F'
  },
  <String, dynamic>{
    'text':
        'Are frozen items kept at a temperature below zero degrees Fahrenheit?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'FrozenItemsCorrectTemp',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FrozenItemsCorrectTempComments',
    'actionItem': 'Ensure freezer temperature is maintained below zero'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 1 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitOneAndComments',
  //   'databaseVarType': 'string'
  // },

  <String, dynamic>{
    'text': "Cold Storage Unit 1 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitOne',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitOneComments'
  },

  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 2 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitTwoAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 2 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitTwo',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitTwoComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 3 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitThreeAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 3 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitThree',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitThreeComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 4 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitFourAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 4 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitFour',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitFourComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 5 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitFiveAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 5 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitFive',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitFiveComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 6 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitSixAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 6 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitSix',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitSixComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 7 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitSevenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 7 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitSeven',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitSevenComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 8 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitEightAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 8 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitEight',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitEightComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 9 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitNineAndComments',
  //   'databaseVarType': 'string'
  // },

  <String, dynamic>{
    'text': "Cold Storage Unit 9 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitNine',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitNineComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 10 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitTenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 10 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitTen',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitTenComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 11 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitElevenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 11 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitEleven',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitElevenComments'
  },

  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 12 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitTwelveAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 12 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitTwelve',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitTwelveComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 13 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitThirteenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 13 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitThirteen',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitThirteenComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 14 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitFourteenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 14 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitFourteen',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitFourteenComments'
  },
  // <String, dynamic>{
  //   'text': 'Cold Storage Unit 15 ºF',
  //   'type': 'fillIn',
  //   'databaseVar': 'ColdStorageUnitFifteenAndComments',
  //   'databaseVarType': 'string'
  // },
  <String, dynamic>{
    'text': "Cold Storage Unit 15 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'ColdStorageUnitFifteen',
    'databaseVarType': 'string',
    'databaseOptCom': 'ColdStorageUnitFifteenComments'
  },
  <String, dynamic>{
    'text': 'Walk in:',
    'type': 'dropDown',
    'menuItems': ['Select', 'Freezer', 'Cooler'],
    'databaseVar': 'WalkInFreezerCooler',
    'databaseVarType': 'string',
    'databaseOptCom': 'WalkInFreezerCoolerComments'
  },
  <String, dynamic>{
    'text': 'USDA Tag # ',
    'type': 'fillInNum',
    'databaseVar': 'USDATagNumberOne',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Serial # ',
    'type': 'fillInNum',
    'databaseVar': 'SerialNumberOne',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Type ',
    'type': 'fillIn',
    'databaseVar': 'TypeOne',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "Walk in Unit 1 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'TempOne',
    'databaseVarType': 'string',
    'databaseOptCom': 'TempOneComments'
  },

  <String, dynamic>{
    'text': 'USDA Tag # ',
    'type': 'fillInNum',
    'databaseVar': 'USDATagNumberTwo',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Serial # ',
    'type': 'fillInNum',
    'databaseVar': 'SerialNumberTwo',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Type ',
    'type': 'fillIn',
    'databaseVar': 'TypeTwo',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "Walk in Unit 2 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'TempTwo',
    'databaseVarType': 'string',
    'databaseOptCom': 'TempTwoComments'
  },
  <String, dynamic>{
    'text': 'USDA Tag # ',
    'type': 'fillInNum',
    'databaseVar': 'USDATagNumberThree',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Serial # ',
    'type': 'fillInNum',
    'databaseVar': 'SerialNumberThree',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Type ',
    'type': 'fillIn',
    'databaseVar': 'TypeThree',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "Walk in Unit 3 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'TempThree',
    'databaseVarType': 'string',
    'databaseOptCom': 'TempThreeComments'
  },
  <String, dynamic>{
    'text': 'USDA Tag # ',
    'type': 'fillInNum',
    'databaseVar': 'USDATagNumberFour',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Serial # ',
    'type': 'fillInNum',
    'databaseVar': 'SerialNumberFour',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Type ',
    'type': 'fillIn',
    'databaseVar': 'TypeFour',
    'databaseVarType': 'string',
  },

  <String, dynamic>{
    'text': "Walk in Unit 4 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'TempFour',
    'databaseVarType': 'string',
    'databaseOptCom': 'TempFourComments'
  },

  <String, dynamic>{
    'text': 'USDA Tag # ',
    'type': 'fillInNum',
    'databaseVar': 'USDATagNumberFive',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Serial # ',
    'type': 'fillInNum',
    'databaseVar': 'SerialNumberFive',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': 'Type ',
    'type': 'fillIn',
    'databaseVar': 'TypeFive',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "Walk in Unit 5 ºF",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'Over 41 (Danger zone)',
      "Temperature Unacceptable",
      "NA"
    ],
    'happyPathResponse': [
      'Under 0 (acceptable for freezer)',
      '0 – 41 (acceptable for cooler)',
      'NA'
    ],
    'databaseVar': 'TempFive',
    'databaseVarType': 'string',
    'databaseOptCom': 'TempFiveComments'
  },
  <String, dynamic>{
    'text': '*Units should not be shared with other programs ',
    'type': 'Display',
  },
];

List<Map<String, dynamic>> audit1Section6Questions = [
  <String, dynamic>{
    'text': 'Plumbing issues?',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'databaseVar': 'PlumbingIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PlumbingIssuesComments',
    'actionItem': 'Explain plumbing issues in comment field'
  },
  <String, dynamic>{
    'text': 'Sewage issues?',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'databaseVar': 'SewageIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'SewageIssuesComments',
    'actionItem': 'Explain issues with sewage and action items'
  },
  <String, dynamic>{
    'text': 'Garbage and refuse disposal',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'databaseVar': 'GarbageRefusalDisposalIssues', // <--------
    'databaseVarType': 'bool', // <--------
    'databaseOptCom': 'GarbageRefusalDisposalIssuesComments', // <---------
    'actionItem':
        'Explain issues with Garbage and refuse disposal and action items'
  },
  <String, dynamic>{
    'text':
        'Was the site able to provide a pest control log/exterminator’s report?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'PestControlReport',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PestControlReportComments',
    'actionItem':
        'Submit a copy of current/most recent Pest Control Log/Exterminator’s Report'
  },
  <String, dynamic>{
    'text': 'Name of Pest Control Company:',
    'type': 'fillIn',
    'databaseVar': 'PestControlCompany',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Last Pest Control Service Date:',
    'type': 'date',
    'databaseVar': 'PestControlServiceDate',
    'databaseVarType': 'date',
    'databaseOptCom': 'PestControlServiceDateComments'
  },
  <String, dynamic>{
    'text':
        'Are floors, doors, windows, and roofs well sealed to prevent pest entry and water damage?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'BuildingWellSealed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'BuildingWellSealedComments',
    'actionItem':
        'Repair roofs, floors, walls, ceilings, windows and doors to prevent pest entry and water damage'
  },
  <String, dynamic>{
    'text': 'Appropriate Lighting issues?',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'databaseVar': 'AppropriateLightingIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AppropriateLightingIssuesComments',
    'actionItem': 'Please explain lighting issues and action items:'
  },

  <String, dynamic>{
    'text': 'Ventilation Issues?',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'databaseVar': 'VentilationIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'VentilationIssuesComments',
    'actionItem':
        'Please explain ventilation issues and action items in comments'
  },
  <String, dynamic>{
    'text':
        'Issues with access to all pertinent areas of food program (dry storage, cold storage, intake, distribution)',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'databaseVar': 'AccessToAllPertinentAreasIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AccessToAllPertinentAreasIssuesComments',
    'actionItem':
        'Please explain issues with access to all pertinent areas of food program, and action items:'
  },
  <String, dynamic>{
    'text':
        'Evidence of Rodents/ Insects (Includes fruit and house flies) Please leave specifics in comments:',
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'databaseVar': 'EvidenceOfPests',
    'databaseVarType': 'bool',
    'databaseOptCom': 'EvidenceOfPestsComments',
    'actionItem':
        'Clean and disinfect area where evidence of rodents/insects were seen'
  },

  // <String, dynamic>{
  //   'text': 'If yes, details:',
  //   'type': 'fillIn',
  //   'databaseVar': 'EvidenceOfPestsComments',
  //   'databaseVarType': 'string',
  // },
];

List<Map<String, dynamic>> audit1Section7Questions = [
  <String, dynamic>{
    'text': 'Have there been any discrimination complaints in the past year?',
    'type': 'yesNo',
    'databaseVar': 'DiscriminationComplaints',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DiscriminationComplaintsComments',
  },
  <String, dynamic>{
    'text':
        'Does the program know what to do if there is a discrimination complaint?',
    'type': 'yesNo',
    'databaseVar': 'PantryKnowsResolutionDiscriminationComplaint',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PantryKnowsResolutionDiscriminationComplaintComments',
  },
  <String, dynamic>{
    'text':
        'If there have been any discrimination complaints, have they been forwarded to the Food Depository?',
    'type': 'yesNoNa',
    'databaseVar': 'DiscriminationComplaintForwardedToGCFD',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DiscriminationComplaintForwardedToGCFDComments',
  },
  <String, dynamic>{
    'text':
        'If the pantry has questions or problems, what is the name and phone number of their Food Depository contact person?',
    'type': 'fillIn',
    'hideNa': 'true',
    'databaseVar': 'PantryHasFoodDepositoryContactInfoComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Issues from last site visit?',
    'type': 'fillIn',
    'databaseVar': 'IssuesFromLastSiteVisit',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Distribution Site Staff Comments: ',
    'type': 'fillIn',
    'databaseVar': 'DistributionSiteStaffComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Food Depository Comments',
    'type': 'fillIn',
    'databaseVar': 'FoodDepositoryComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Donors',
    'type': 'fillIn',
    'databaseVarType': 'string',
    'databaseVar': 'Donors',
  },
  <String, dynamic>{
    'text': 'Date Tax Exemption Verified',
    'type': 'date',
    'databaseVarType': 'date',
    'databaseVar': 'DateTaxExemptionVerified',
  },
  <String, dynamic>{
    'text': 'Re-verified by:',
    'type': 'fillIn',
    'databaseVarType': 'string',
    'databaseVar': 'ReVerifiedBy',
  },
  <String, dynamic>{
    'text': 'GCFD Monitor',
    'type': 'fillIn',
    'databaseVarType': 'string',
    'databaseVar': 'GCFDMonitor',
  },
  <String, dynamic>{
    'text': 'Reviewed by',
    'type': 'fillIn',
    'databaseVarType': 'string',
    'databaseVar': 'ReviewedBy',
  },
  <String, dynamic>{
    'text': 'Findings Found:',
    'type': 'yesNo',
    'databaseVarType': 'bool',
    'databaseVar': 'FindingsFound',
    'databaseOptCom': 'FindingsFoundComments'
  },
];

List<Map<String, dynamic>> photoData = [
  <String, dynamic>{"filler": "material"}
];

List<Map<String, dynamic>> reviewData = [
  <String, dynamic>{"filler": "material"}
];

List<Map<String, dynamic>> verificationData = [
  <String, dynamic>{"filler": "material"}
];

List<Map<String, dynamic>> developerData = [
  <String, dynamic>{"filler": "material"}
];

List<Map<String, List<Map<String, dynamic>>>> pantryAuditSectionsQuestions = [
  <String, List<Map<String, dynamic>>>{"Confirm Details": confirmDetails},
  <String, List<Map<String, dynamic>>>{"Intro": audit1Section1Questions},
  <String, List<Map<String, dynamic>>>{"Signage": audit1Section2Questions},
  <String, List<Map<String, dynamic>>>{
    "Distribution & Intake": audit1Section3Questions
  },
  <String, List<Map<String, dynamic>>>{"Dry Storage": audit1Section4Questions},
  <String, List<Map<String, dynamic>>>{"Cold Storage": audit1Section5Questions},
  <String, List<Map<String, dynamic>>>{"Other": audit1Section6Questions},
  <String, List<Map<String, dynamic>>>{
    "Complaints & Problems": audit1Section7Questions
  },
  <String, List<Map<String, dynamic>>>{"Photos": photoData},
  <String, List<Map<String, dynamic>>>{"Review": reviewData},
  <String, List<Map<String, dynamic>>>{"Verification": verificationData},
  <String, List<Map<String, dynamic>>>{"*Developer*": developerData},
];
