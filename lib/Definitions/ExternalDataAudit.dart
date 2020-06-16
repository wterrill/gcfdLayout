List<String> audit1Sections = [
  'Confirm Details',
  'Intro',
  'Signage',
  'Distribution & Intake',
  'Dry Storage',
  'Cold Storage',
  'Other',
  'Complaints & Problems',
  'Review',
  'Verification'
];

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
    'type': 'fillIn',
    'databaseVar': 'PersonInterviewed',
    'databaseVarType': 'string'
  },
  <String, dynamic>{'text': 'Program Operating Hours:', 'type': 'display'},
  <String, dynamic>{'text': 'Service Area:', 'type': 'display'},
];

Map<String, dynamic> audit1Section1 = <String, dynamic>{
  'name': 'Pantry Policy/Procedure Checklist',
  'questions': audit1Section1Questions,
  'sectionName': 'Intro',
};

List<Map<String, dynamic>> audit1Section1Questions = [
  <String, dynamic>{
    'text': 'Did the Food Depository establish the service area?',
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'databaseVar': 'GCFDEstablishedServiceArea',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GCFDEstablishedServiceAreaComments'
  },
  <String, dynamic>{
    'text': 'Does pantry serve outside this service area?',
    'type': 'yesNo',
    'databaseVar': 'PantryServesOutsideServiceArea',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PantryServesOutsideServiceAreaComments'
  },

  // TODO this needs to somehow be linked to the question above so that it can be blank, but still show up as completed, if the question above is "no"
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
      'Daily',
      'Weekly',
      'Bi-Monthly',
      'Monthly',
      'Unlimited',
      'Other'
    ],
    'happyPathResponse': [
      'daily',
      'weekly',
      'bi-monthly',
      'monthly',
      'unlimited',
      'other'
    ],
    'databaseVar': 'HowOftenGuestsReceiveFood',
    'databaseVarType': 'string',
    'databaseOptCom': 'HowOftenGuestsReceiveFoodComments'
  },
  <String, dynamic>{
    'text':
        'Does the pantry allow guests to receive food at least once every 30 days?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'PantryAllowsFoodAtLeast30Days',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PantryAllowsFoodAtLeast30DaysComments'
  },
  <String, dynamic>{
    'text': 'Are referrals from an outside agency required to receive food?',
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'databaseVar': 'ReferralsRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ReferralsRequiredComments',
//TODO This needs to be linked to the question before
  },
  <String, dynamic>{
    'text': 'Are appointments required to receive food?',
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'databaseVar': 'AppointmentsRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AppointmentsRequiredComments'
  },
  <String, dynamic>{
    'text': 'Does the pantry require any documentation?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DocumentationRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DocumentationRequiredComments'
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
    'happyPathResponse': ['No'],
    'databaseVar': 'UnderRuralExemption',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnderRuralExemptionComments'
  },
  <String, dynamic>{
    'text': 'Does this food pantry also operate a soup kitchen?',
    'type': 'yesNo',
    'databaseVar': 'HasSoupKitchen',
    'databaseVarType': 'bool',
    'databaseOptCom': 'HasSoupKitchenComments'
  },
  //TODO: this below question needs to be linked to the above question
  <String, dynamic>{
    'text':
        'If yes, is the food properly separated and tracked for two programs?',
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'FoodProperlySeperatedAndTracked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FoodProperlySeperatedAndTrackedComments'
  },
  // <String, dynamic>{
  //   'text':
  //       'If yes, is the food properly separated and tracked for two programs?',
  //   'type': 'yesNo'
  // },

  <String, dynamic>{
    'text': 'Is Program on Food Rescue/Agency Enabled?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'OnFoodRescueAgencyEnabled',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OnFoodRescueAgencyEnabledComments'
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
    'databaseVar': 'Remove',
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
    'type': 'fillInNum',
    'databaseVar': 'NumberOfDeliveriesPerMonth',
    'databaseVarType': 'int',
  },

  <String, dynamic>{
    'text': 'Has an order been placed from the menu in the past month?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'OrderHasBeenPlacedInLastMonth',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OrderHasBeenPlacedInLastMonthComments'
  },
  <String, dynamic>{
    'text': 'Has an online intake system been used in the past month?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'IntakeSystemUsedInLastMonth',
    'databaseVarType': 'bool',
    'databaseOptCom': 'IntakeSystemUsedInLastMonthComments'
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
    'happyPathResponse': ['Yes', 'closed program'],
    'databaseVar': 'AgencyLocatorAccurate',
    'databaseVarType': 'string',
    'databaseOptCom': 'AgencyLocatorAccurateComments'
  },
];

List<Map<String, dynamic>> audit1Section2Questions = [
  <String, dynamic>{
    'text': "Is entrance clearly marked?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'EntranceClearlyMarked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'EntranceClearlyMarkedComments'
  },
  <String, dynamic>{
    'text': "Is there a sign posted outside with days and hours of operation?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'OperationHoursDaysPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'EntranceClearlyMarkedComments'
  },
  <String, dynamic>{
    'text':
        "Is there a sign posted with service requirements/guidelines visible to guests?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ServiceRequirementsPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ServiceRequirementsPostedComments'
  },
  <String, dynamic>{
    'text': "Is the Food Depository contact information posted?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'GCFDContactInfoPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GCFDContactInfoPostedComments'
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
        "Are TEFAP posters accessible to guests?(Ex: Income Eligibility, Notice to Program Participants, Prohibited Activities, /“And Justice for All/”)",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'TEFAPPostersAccessible',
    'databaseVarType': 'bool',
    'databaseOptCom': 'TEFAPPostersAccessibleComments'
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
    'databaseOptCom': 'ActivitiesIndicatingFeesRequiredComments'
  },
  <String, dynamic>{
    'text': "Is an online intake system being utilized?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'OnlineIntakeUtilized',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OnlineIntakeUtilizedComments'
  },
  <String, dynamic>{
    'text': "If it is not being utilized, are DHS signature documents used?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'DHSSignatureDocsUsed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DHSSignatureDocsUsedComments'
  },
  <String, dynamic>{
    'text': "Does the guest sign his/her name upon receipt?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'GuestSignsName',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestSignsNameComments'
  },
  <String, dynamic>{
    'text': "Is the address recorded upon receipt?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'AddressRecordedUponReceipt',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AddressRecordedUponReceiptComments'
  },
  <String, dynamic>{
    'text': "Is the household size recorded upon receipt?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'HouseholdSizeRecordedUponReceipt',
    'databaseVarType': 'bool',
    'databaseOptCom': 'HouseholdSizeRecordedUponReceiptComments'
  },
  <String, dynamic>{
    'text':
        "Does the pantry have the guest sign even if only privately donated food is received?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'GuestSignsEvenForPrivateDonation',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestSignsEvenForPrivateDonationComments'
  },
  <String, dynamic>{
    'text':
        "Are original DHS signature documents and surveys submitted to the Food Depository monthly?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'OriginalDHSSigDocsSubmitted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'OriginalDHSSigDocsSubmittedComments'
  },
  <String, dynamic>{
    'text': "Is the TEFAP manual accessible to pantry staff and/or volunteers?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'TEFAPManualAccessible',
    'databaseVarType': 'bool',
    'databaseOptCom': 'TEFAPManualAccessibleComments'
  },
  <String, dynamic>{
    'text': "Are proxy forms used?",
    'type': 'yesNo',
    'databaseVar': 'ProxyFormsUsed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxyFormsUsedComments'
  },
//TODO The above question needs to be linked to the below question
  <String, dynamic>{
    'text':
        "If yes, do they contain the original signature of the recipient getting food?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'ProxyFormsOriginalSignature',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxyFormsOriginalSignatureComments'
  },

  <String, dynamic>{
    'text':
        "Does the proxy sign the proxy form in the presence of pantry personnel?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'ProxySignedInPresenceOfPantryPersonnel',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxySignedInPresenceOfPantryPersonnelComments'
  },
  <String, dynamic>{
    'text':
        "Do pantry personnel sign the proxy form at the time of distribution?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'ProxyFormSignedAtTimeOfDistribution',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProxyFormSignedAtTimeOfDistributionComments'
  },
  <String, dynamic>{
    'text': "Are TANF commodities being distributed?",
    'type': 'yesNo',
    'databaseVar': 'TANFCommoditiesDistributed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'TANFCommoditiesDistributedComments'
  },
  //TODO the answer from the above question should be linked to the below question,
  //if yes above, it should be yes below
  <String, dynamic>{
    'text': "If yes, do guests complete the required TANF information?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'GuestsCompleteRequiredTANFInfo',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestsCompleteRequiredTANFInfoComments'
  },
  <String, dynamic>{
    'text':
        "Are guests without children in the household completing TANF information?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'GuestsWithoutChildrenCompletingTANFInfo',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GuestsWithoutChildrenCompletingTANFInfoComments'
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
    'text': "# of Intake volunteers:",
    'type': 'fillInNum',
    'databaseVar': 'NumberOfIntakeVolunteers',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': "# of Distribution volunteers:",
    'type': 'fillInNum',
    'databaseVar': 'NumberOfDistributionVolunteers',
    'databaseVarType': 'int',
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
    'databaseOptCom': 'ActivitiesOtherThanTEFAPDisruptingComments'
  },
  <String, dynamic>{
    'text': "Do all distribution activities appear to be appropriate?",
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DistributionActivitiesAreAppropriate',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DistributionActivitiesAreAppropriateComments'
  },
  <String, dynamic>{
    'text': "Distribution style: Cafeteria Restaurant Other",
    'type': 'dropDown',
    'menuItems': [
      'Select',
      'Client Choice',
      'Prepacked',
      'Partial Client Choice'
    ],
    'happyPathResponse': [
      'client choice',
      'prepacked',
      'partial client choice'
    ],
    'databaseVar': 'DistributionStyle',
    'databaseVarType': 'string',
    'databaseOptCom': 'DistributionStyleComments'
  },
//TODO: The below question needs to be linked to the above question
  <String, dynamic>{
    'text': "If not client choice, why?",
    'type': 'fillIn',
    'databaseVar': 'DistributionNotClientChoiceReason',
    'databaseVarType': 'string'
  },
];

List<Map<String, dynamic>> audit1Section4Questions = [
  <String, dynamic>{
    'text': 'Are floors, pallets, and shelving clean?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'FloorsPalletsShelvesClean',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FloorsPalletsShelvesCleanComments'
  },
  <String, dynamic>{
    'text': 'Is storage area organized?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'StorageOrganized',
    'databaseVarType': 'bool',
    'databaseOptCom': 'StorageOrganizedComments'
  },
  <String, dynamic>{
    'text': 'Are pest proof containers utilized?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'PestProofContainersUsed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PestProofContainersUsedCommments'
  },
  <String, dynamic>{
    'text': 'Are non-food items and toxic items stored separately?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'NonFoodItemsStoredSeparately',
    'databaseVarType': 'bool',
    'databaseOptCom': 'NonFoodItemsStoredSeparatelyComments'
  },
  <String, dynamic>{
    'text': 'Is food being rotated via FIFO?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryFoodRotatedFIFO',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodRotatedFIFOComments'
  },
  <String, dynamic>{
    'text': 'Is food 6 inches off floor?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryFoodSixInchesFromFloor',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodSixInchesFromFloorComments'
  },

  <String, dynamic>{
    'text':
        'Is food kept far enough away from walls and floor to permit good air circulation and to allow for pest control?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryFoodKeptFromWalls',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodKeptFromWallsComments'
  },
  <String, dynamic>{
    'text': 'Are proper temperatures for dry food storage maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ProperTempForDryFood',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProperTempForDryFoodComments'
  },
  //TODO: Make comment mandatory
  <String, dynamic>{
    'text':
        'Is the food stored in a secure location with adequate space? If no, explain:',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryFoodStoredSecurely',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodStoredSecurelyComments'
  },
  <String, dynamic>{
    'text': 'Is food clearly marked for use by food program only?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryFoodClearlyMarked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryFoodClearlyMarkedComments'
  },
  <String, dynamic>{
    'text': 'Is storage area only for approved food program?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'StorageAreaOnlyForApprovedFood',
    'databaseVarType': 'bool',
    'databaseOptCom': 'StorageAreaOnlyForApprovedFoodComments'
  },
  <String, dynamic>{
    'text': 'Is equipment well maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DryEquipmentWellMaintained',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DryEquipmentWellMaintainedComments'
  },
  <String, dynamic>{
    'text': 'Appropriate amount of food in inventory?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'AppropriateAmountOfFood',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AppropriateAmountOfFoodComments'
  },
  <String, dynamic>{
    'text': '# of cases of dry food currently in inventory:',
    'type': 'fillInNum',
    'databaseVar': 'NumCasesOfDryFood',
    'databaseVarType': 'int',
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
        'Does the pantry have other foods to distribute with government commodities?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
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
    'databaseOptCom': 'UnitsCleanComments'
  },
  <String, dynamic>{
    'text': 'Are units defrosted?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsDefrosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsDefrostedComments'
  },
  <String, dynamic>{
    'text': 'Are units organized?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsOrganized',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsOrganizedComments'
  },
  <String, dynamic>{
    'text': 'Is food being rotated via FIFO?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdFoodRotatedFIFO',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdFoodRotatedFIFOComments'
  },
  <String, dynamic>{
    'text': 'Do units have thermometers?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsHaveThermometers',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsHaveThermometersComments'
  },
  <String, dynamic>{
    'text': 'Are units only for approved food program?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsOnlyForApprovedPrograms',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsOnlyForApprovedProgramsComments'
  },
  <String, dynamic>{
    'text': 'Is food appropriately labeled?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdFoodAppropriatelyLabeled',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdFoodAppropriatelyLabeledComments'
  },
  <String, dynamic>{
    'text': 'Is food appropriately stocked and not overstuffed in units?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdFoodAppropriatelyStocked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdFoodAppropriatelyStockedComments'
  },
  <String, dynamic>{
    'text': 'Are units numbered?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsNumbered',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsNumberedComments'
  },
  <String, dynamic>{
    'text': 'Is equipment well maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdEquipmentWellMaintained',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdEquipmentWellMaintainedComments'
  },
  <String, dynamic>{
    'text': 'Are cold storage units secured?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdStorageUnitsSecured',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdStorageUnitsSecuredComments'
  },
  <String, dynamic>{
    'text':
        'Are refrigerated items kept at temperatures between 35-40 degrees Fahrenheit?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'RefrigeratedItemsCorrectTemp',
    'databaseVarType': 'bool',
    'databaseOptCom': 'RefrigeratedItemsCorrectTempComments'
  },
  <String, dynamic>{
    'text':
        'Are frozen items kept at a temperature below zero degrees Fahrenheit?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'FrozenItemsCorrectTemp',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FrozenItemsCorrectTempComments'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 1 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitOneTempAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 2 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitTwoTempAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 3 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitThreeTempAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 4 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitFourTempAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 5 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitFiveTempAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 6 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitSixTempAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 7 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitSevenTempAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 8 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitEightTempAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 9 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitNineTempAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 10 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitTenTempAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Walk in:',
    'type': 'dropDown',
    'menuItems': ['Select', 'Freezer', 'Cooler'],
    'databaseVar': 'WalkInFreezerCoolerComments',
    'databaseVarType': 'string',
    'databaseOptCom': 'FrozenItemsCorrectTempComments'
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
    'text': '*Units should not be shared with other programs ',
    'type': 'Display',
  },
];

List<Map<String, dynamic>> audit1Section6Questions = [
  <String, dynamic>{
    'text': 'Plumbing',
    'type': 'fillIn',
    'databaseVar': 'PlumbingComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Sewage',
    'type': 'fillIn',
    'databaseVar': 'SewageComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Garbage and refuse disposal',
    'type': 'fillIn',
    'databaseVar': 'GarbageRefusalDisposalComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Pest control log/exterminator’s report',
    'type': 'fillIn',
    'databaseVar': 'PestControlReportComments',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text':
        'Are floors, doors, windows, and roofs well sealed to prevent pest entry and water damage?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'BuildingWellSealed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'BuildingWellSealedComments'
  },
  <String, dynamic>{
    'text': 'Appropriate Lighting',
    'type': 'fillIn',
    'databaseVar': 'AppropriateLightingComments',
    'databaseVarType': 'string'
  },

  <String, dynamic>{
    'text': 'Ventilation',
    'type': 'fillIn',
    'databaseVar': 'VentilationComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text':
        'Access to all pertinent areas of food program (dry storage, cold storage, intake, distribution)',
    'type': 'fillIn',
    'databaseVar': 'AccessToAllPertinentAreasComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Pest Control Company:',
    'type': 'fillIn',
    'databaseVar': 'PestControlCompany',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Evidence of Rodents/ Insects (Includes fruit and house flies):',
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'databaseVar': 'EvidenceOfPests',
    'databaseVarType': 'bool',
    'databaseOptCom': 'EvidenceOfPestsComments'
  },
  //TODO the below question should be linked to the above question
  <String, dynamic>{
    'text': 'If yes, details:',
    'type': 'fillIn',
    'databaseVar': 'EvidenceOfPestsComments',
    'databaseVarType': 'string',
  },
];

List<Map<String, dynamic>> audit1Section7Questions = [
  <String, dynamic>{
    'text': 'Have there been any discrimination complaints in the past year?',
    'type': 'yesNo',
    'databaseVar': 'EvidenceOfPests',
    'databaseVarType': 'bool',
    'databaseOptCom': 'EvidenceOfPestsComments'
  },
  <String, dynamic>{
    'text':
        'Does the program know what to do if there is a discrimination complaint?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'PantryKnowsResolutionDiscriminationComplaint',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PantryKnowsResolutionDiscriminationComplaintComments'
  },
  <String, dynamic>{
    'text':
        'If there have been any discrimination complaints, have they been forwarded to the Food Depository?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DiscriminationComplaintForwardedToGCFD',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DiscriminationComplaintForwardedToGCFDComment'
  },
  <String, dynamic>{
    'text':
        'If the pantry has questions or problems, what is the name and phone number of their Food Depository contact person?',
    'type': 'fillIn',
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
    'text': 'Distribution Stie Staff Comments: ',
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
];

//TODO: FollowUpRequired,  CorrectiveActionPlanDueDate,  SiteRepresentativeSignature   -> varchar 50, date, varchar(max)
