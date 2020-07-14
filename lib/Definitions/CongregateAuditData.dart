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
    'type': 'fillIn',
    'databaseVar': 'PersonInterviewed',
    'databaseVarType': 'string'
  },
  <String, dynamic>{'text': 'Program Operating Hours:', 'type': 'display'},
  <String, dynamic>{'text': 'Service Area:', 'type': 'display'},
];

// Map<String, dynamic> audit2Section1 = <String, dynamic>{
//   'name': 'Pantry Policy/Procedure Checklist',
//   'questions': audit2Section1Questions,
//   'sectionName': 'Intro',
// };

List<Map<String, dynamic>> audit2Section1Questions = [
  <String, dynamic>{
    'text': 'Does this soup kitchen also operate a food pantry?',
    'type': 'yesNo',
    'databaseVar': 'AlsoOperatesAsFoodPantry',
    'databaseVarType': 'bool',
  },
  <String, dynamic>{
    'text':
        'If yes, is the food properly separated and tracked for the two programs?',
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'Na'],
    'databaseVar': 'FoodSeparatedForTwoPrograms',
    'databaseVarType': 'bool',
    'actionItem':
        'Ensure food is properly separated and tracked by each program '
  },
  <String, dynamic>{
    'text': 'How long do guests remain in the shelter?',
    'type': 'fillIn',
    'databaseVar': 'HowLongGuestsRemainInShelter',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'How many beds are there?',
    'type': 'fillIn',
    'databaseVar': 'HowManyBeds',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text':
        'Is the facility restricted to a specific population such as elderly, children, or drug or alcohol treatment customers?',
    'type': 'yesNo',
    'databaseVar': 'FacilityForSpecificPopulations',
    'databaseVarType': 'bool',
  },
  <String, dynamic>{
    'text': 'If yes, describe the population served:',
    'type': 'fillIn',
    'databaseVar': 'PopulationServed',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text':
        'How do you count the number of meals served as reported to the Food Depository?',
    'type': 'fillIn',
    'databaseVar': 'MealCountMethod',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text':
        'Does the shelter receive funding from the DHS Emergency Food and Shelter Program?',
    'type': 'yesNo',
    'databaseVar': 'ShelterReceivesDHSFunding',
    'databaseVarType': 'bool',
  },
  <String, dynamic>{
    'text': 'Is Program on Food Rescue/Agency Enabled?',
    'type': 'yesNo',
    'databaseVar': 'OnFoodRescueAgencyEnabled',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProgramOnFoodRescue',
  },
  <String, dynamic>{
    'text':
        'Food Service Sanitation Manager Certificates (at least two are required)',
    'type': 'fillIn',
    'databaseVar': 'FoodServiceSanitationManagerCertificate',
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
    'menuItems': ['Select', '1', '2', '3', '4', '5'],
    'databaseVar': 'NumberOfDeliveriesPerMonth',
    'databaseOptCom':
        'NumberOfDeliveriesPerMonthComments', //not finding a comment field on the Congregate Audit data def but format is same as Pantry which does have this on the configuration file
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': 'Has an order been placed from the menu in the past month?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'OrderHasBeenPlacedInLastMonth',
    'databaseVarType': 'bool',
    'databaseOptCom':
        'OrderHasBeenPlacedInLastMonthComments', //not finding a comment field on the Congregate Audit data def but format is same as Pantry which does have this on the configuration file
    'actionItem':
        'Ensure an order is placed at least once a month. Please provide an explanation why an order has not been placed within the past month'
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
    'happyPathResponse': ['Yes', 'Closed Program'],
    'databaseVar': 'AgencyLocatorAccurate',
    'databaseVarType': 'string',
    'databaseOptCom': 'AgencyLocatorAccurateComments',
    'actionItem': 'No action item needed'
  },
];

List<Map<String, dynamic>> audit2Section2Questions = [
  <String, dynamic>{
    'text': "Is entrance clearly marked?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'EntranceClearlyMarked',
    'databaseVarType': 'bool',
    'databaseOptCom': 'EntranceClearlyMarkedComments',
    'actionItem':
        'Ensure entrance to program is clearly marked and visible to guests'
  },
  <String, dynamic>{
    'text': "Is there a sign posted outside with days and hours of operation?",
    'type': 'yesNoNa',
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
        "What types of public outreach and networking does the soup kitchen use to make the general public aware of their services? (Not applicable to homeless shelters)",
    'type': 'fillIn',
    'databaseVar': 'TypeOfOutreachUsed',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "Is the 'And Justice for All' poster accesible to guests?",
    'type': 'yesNoNa',
    'happyPathResponse': ['Yes', 'NA'],
    'databaseVar': 'AndJusticeForAllPostersAccessible',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AndJusticeForAllPostersAccessibleComments',
    'actionItem': 'Post appropriate USDA signage (if applicable).'
  },
];

List<Map<String, dynamic>> audit2Section3Questions = [
  <String, dynamic>{
    'text': "Are fees/donations/memberships required of the guests?",
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'databaseVar': 'AreFeesRequired',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AreFeesRequiredComments',
    'actionItem':
        'Ensure no fees / donations / memberships are collected / asked for during distribution'
  },
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
    'text': "Are other activities unrelated to TEFAP disrupting distribution?",
    'type': 'yesNo',
    'happyPathResponse': ['No'],
    'databaseVar': 'ActivitiesOtherThanTEFAPDisrupting',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ActivitiesOtherThanTEFAPDisruptingComments',
    'actionItem':
        'Ensure no other activities unrelated to TEFAP are conducted during distribution '
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
    'text': "Guest disposition",
    'type': 'fillIn',
    'databaseVar': 'GuestDisposition',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "Guests served during the site visit:",
    'type': 'fillInNum',
    'databaseVar': 'GuestServedDuringVisit',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': "Is an approved meal count tally used? What is it?",
    'type': 'yesNo',
    'databaseVar': 'ApprovedMealCountTally',
    'databaseVarType': 'bool',
    'happyPathResponse': ['Yes'],
    'databaseOptCom': 'ApprovedMealCountTallyComments',
    'actionItem':
        'Ensure approved meal count tally is utilized to keep track of meals served'
  },

  <String, dynamic>{
    'text': "What meal count tally is used?",
    'type': 'dropDown',
    'menuItems': ['Select', 'Sign in Sheets', 'Tally Sheets', 'Plate count'],
    'happyPathResponse': ['Sign in Sheets', 'Tally Sheets', 'Plate count'],
    'databaseVar': 'MealCountTallyUsed',
    'databaseVarType': 'string',
    'databaseOptCom': 'MealCountTallyUsedComments'
  },
  <String, dynamic>{
    'text': "Guests served each month:",
    'type': 'fillInNum',
    'databaseVar': 'GuestServedEachMonth',
    'databaseVarType': 'int',
  },
  <String, dynamic>{
    'text': "Volunteer disposition",
    'type': 'fillIn',
    'databaseVar': 'VolunteerDisposition', //<------->
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "# of Intake Volunteers",
    'type': 'dropDown',
    'menuItems': ['Select', '1-10', '11-20', '21-30', '31-40', '41-50'],
    'happyPathResponse': ['1-10', '11-20', '21-30', '31-40', '41-50'],
    'databaseVar': 'NumberOfIntakeVolunteers',
    'databaseVarType': 'string',
  },
  // <String, dynamic>{
  //   'text': "# of Meal Distribution volunteers:",
  //   'type': 'fillInNum',
  //   'databaseVar': 'NumberOfDistributionVolunteers',
  //   'databaseVarType': 'int',
  // },

  <String, dynamic>{
    'text': "# of Meal Distribution volunteers:",
    'type': 'dropDown',
    'menuItems': ['Select', '1-10', '11-20', '21-30', '31-40', '41-50'],
    'happyPathResponse': ['1-10', '11-20', '21-30', '31-40', '41-50'],
    'databaseVar': 'NumberOfDistributionVolunteers',
    'databaseVarType': 'string',
    'databaseOptCom': 'NumberOfDistributionVolunteersComments'
  },

  <String, dynamic>{
    'text': "Today's meal",
    'type': 'fillIn',
    'databaseVar': 'TodaysMeal', //<-----
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': "Distribution style:",
    'type': 'dropDown',
    'menuItems': ['Select', 'Cafeteria', 'Restaurant', 'Other'],
    'happyPathResponse': ['Cafeteria', 'Restaurant', 'Other'],
    'databaseVar': 'DistributionStyle',
    'databaseVarType': 'string',
    'databaseOptCom': 'DistributionStyleOther'
  },
];
///////////////////////////////////////////////////////////////////////////////
List<Map<String, dynamic>> audit2Section4Questions = [
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
        'Ensure the “First in First Out” method is followed for dry food'
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
    'happyPathResponse': ['Yes'],
    'databaseVar': 'AppropriateAmountOfFood',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AppropriateAmountOfFoodComments',
    'actionItem': 'No action item required'
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
  }
];
////////////////////////////////////////////////////////////////////////////////

List<Map<String, dynamic>> audit2Section5Questions = [
  <String, dynamic>{
    'text': 'Are units clean?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsClean',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsCleanComments',
    'actionItem': 'Clean units. Please specify units in comments'
  },
  <String, dynamic>{
    'text': 'Are units defrosted?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsDefrosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsDefrostedComments',
    'actionItem': 'Defrost units. Please specify unit number in comments'
  },
  <String, dynamic>{
    'text': 'Are units organized?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'UnitsOrganized',
    'databaseVarType': 'bool',
    'databaseOptCom': 'UnitsOrganizedComments',
    'actionItem': 'Organize units.  Please specify unit number in comments'
  },
  <String, dynamic>{
    'text': 'Is cold food being rotated via FIFO?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ColdFoodRotatedFIFO',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ColdFoodRotatedFIFOComments',
    'actionItem':
        'Ensure the “First in First Out” method is followed for cold food'
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
    'text': 'Is food appropriately stocked and not overstuffed in units?',
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
  <String, dynamic>{
    'text': 'Cold Storage Unit 1 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitOneAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 2 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitTwoAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 3 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitThreeAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 4 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitFourAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 5 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitFiveAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 6 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitSixAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 7 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitSevenAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 8 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitEightAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 9 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitNineAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 10 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitTenAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 11 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitElevenAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 12 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitTwelveAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 13 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitThirteenAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 14 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitFourteenAndComments',
    'databaseVarType': 'string'
  },
  <String, dynamic>{
    'text': 'Cold Storage Unit 15 ºF',
    'type': 'fillIn',
    'databaseVar': 'ColdStorageUnitFifteenAndComments',
    'databaseVarType': 'string'
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
    'text': 'Temperature for Cooler/Freezer ',
    'type': 'fillIn',
    'databaseVar': 'TempOne',
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
    'text': 'Temperature for Cooler/Freezer ',
    'type': 'fillIn',
    'databaseVar': 'TempTwo',
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
    'text': 'Temperature for Cooler/Freezer ',
    'type': 'fillIn',
    'databaseVar': 'TempThree',
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
    'text': 'Temperature for Cooler/Freezer ',
    'type': 'fillIn',
    'databaseVar': 'TempFour',
    'databaseVarType': 'string',
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
    'text': 'Temperature for Cooler/Freezer ',
    'type': 'fillIn',
    'databaseVar': 'TempFive',
    'databaseVarType': 'string',
  },
  <String, dynamic>{
    'text': '*Units should not be shared with other programs ',
    'type': 'Display',
  },
];
////////////////////////////////////////////////////////////////////////////////

List<Map<String, dynamic>> audit2Section6Questions = [
  <String, dynamic>{
    'text': 'Is a Food Service Sanitation Manager present?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'FoodServiceSanitationManagerPresent',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FoodServiceSanitationManagerPresentComments',
    'actionItem':
        'Ensure that at least one Food Service Sanitation Manager is on site during preparation, cooking, and serving of meals'
  },
  <String, dynamic>{
    'text':
        'Are current Food Service Sanitation Manager Certificates posted in the kitchen?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'FoodServiceSanitationCertsPresent',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FoodServiceSanitationCertsPresentComments',
    'actionItem':
        'Site must post current Food Service Sanitation Manager Certificates in kitchen'
  },
  <String, dynamic>{
    'text': 'Are meals being prepared by staff or volunteers?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'MealsPreparedByStaff',
    'databaseVarType': 'bool',
    'databaseOptCom': 'MealsPreparedByStaffComments',
    'actionItem':
        'Ensure only Food Service Sanitation Managers are preparing meals'
  },
  <String, dynamic>{
    'text': 'Is there a 3 Step dishwashing sink or dishwasher in the kitchen?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ThreeStepDishwashingSinkPresent',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ThreeStepDishwashingSinkPresentComments',
    'actionItem':
        'Acquire a 3-Tiered Deep Sink or Industrial Dishwasher and submit receipt. '
  },
  <String, dynamic>{
    'text': 'Is there a 3-step dish washing sign posted?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ThreeStepDishwashingSignPosted', //<--------
    'databaseVarType': 'bool',
    'databaseOptCom': 'ThreeStepDishwashingSignPostedComments', //<--------
    'actionItem': 'Post a 3-step dish washing sign'
  },
  <String, dynamic>{
    'text': 'Are dial-stem thermometer(s) on hand?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'DialStemThermometersOnHandComment',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DialStemThermometersOnHandComment',
    'actionItem':
        ' Acquire / Utilize a dial-stem thermometer for testing food temperature while preparing & serving and submit receipt for thermometers.'
  },
  <String, dynamic>{
    'text': 'Is a temperature chart posted?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'TemperatureChartPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'TemperatureChartPostedComment',
    'actionItem': ' Post Temperature Chart'
  },
  <String, dynamic>{
    'text':
        'Are appropriate temperatures maintained during preparation of food?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'AppropriateTemperatureMaintained',
    'databaseVarType': 'bool',
    'databaseOptCom': 'AppropriateTemperatureMaintainedComment',
    'actionItem':
        'Ensure proper temperatures are maintained during the preparation of food'
  },
  <String, dynamic>{
    'text': 'Is food being thawed appropriately?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'FoodThawedAppropriately',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FoodThawedAppropriatelyComment',
    'actionItem':
        'Ensure food is thawed out correctly, safely and appropriately'
  },
  <String, dynamic>{
    'text':
        'Is the preparation area clean and free of any type of insect, dust, or other foreign matter that could contaminate the food?',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'PrepAreaClean',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PrepAreaCleanComment',
    'actionItem':
        'Ensure preparation area is maintained clean and free of any type of insect, dust or other foreign matter that could contaminate the food'
  },
  <String, dynamic>{
    'text': 'Is cross contamination avoided during preparation? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'CrossContaminationAvoided',
    'databaseVarType': 'bool',
    'databaseOptCom': 'CrossContaminationAvoidedComment',
    'actionItem':
        'Ensure cross contamination is avoided during the preparation of meals'
  },
  <String, dynamic>{
    'text': 'Is smoking prohibited in the food preparation area? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'SmokingProhibited',
    'databaseVarType': 'bool',
    'databaseOptCom': 'SmokingProhibitedComment',
    'actionItem': 'Ensure smoking is not practiced in the food preparation area'
  },
  <String, dynamic>{
    'text':
        'Are staff and volunteers required to empty their shirt pockets and remove jewelry to prevent objects from falling into the food? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'StaffEmptiesShirtPocketAndJewelry',
    'databaseVarType': 'bool',
    'databaseOptCom': 'StaffEmptiesShirtPocketAndJewelryComments',
    'actionItem':
        'Ensure staff and volunteers empty their shirt pockets and remove any jewelry to prevent objects from falling in to the food'
  },
  <String, dynamic>{
    'text': 'Is the serving area clean? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ServingAreaClean',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ServingAreaCleanComments',
    'actionItem': 'Ensure serving area is maintained clean'
  },
  <String, dynamic>{
    'text': 'Are appropriate food temperatures maintained during serving? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'ProperTempMaintainedDuringServing',
    'databaseVarType': 'bool',
    'databaseOptCom': 'ProperTempMaintaintedDuringServingComments ',
    'actionItem':
        'Ensure proper food temperatures are maintained during the serving of meals'
  },
  <String, dynamic>{
    'text': 'Is food being served immediately? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'FoodServedImmediately',
    'databaseVarType': 'bool',
    'databaseOptCom': 'FoodServedImmediatelyComments ',
    'actionItem': 'Ensure food/meals are being served immediately'
  },
  <String, dynamic>{
    'text': 'Is the eating area clean and well maintained? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'EatingAreaClean',
    'databaseVarType': 'bool',
    'databaseOptCom': 'EatingAreaCleanComments ',
    'actionItem': ' Ensure eating area is kept clean and well maintained'
  },
  <String, dynamic>{
    'text': 'Does the program use non-porous countertops? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'NonPorousCountertopsUsed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'NonPorousCountertopsUsedComments ',
    'actionItem': 'Ensure non-porous countertops are obtained and utilized'
  },
  <String, dynamic>{
    'text': 'Does the program disinfect all counter tops and utensils? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'CounterTopsDisinfected',
    'databaseVarType': 'bool',
    'databaseOptCom': 'CounterTopsDisinfectedComments ',
    'actionItem':
        'Ensure all countertops and utensils are disinfected immediately'
  },
  <String, dynamic>{
    'text': 'Is their cookware clean and stored appropriately? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'CookwareCleanedAndStored',
    'databaseVarType': 'bool',
    'databaseOptCom': 'CookwareCleanedAndStoredComments ',
    'actionItem': 'Ensure cookware is maintained clean and stored properly'
  },
  <String, dynamic>{
    'text': 'Are there clean wiping cloths, hair nets, and gloves available? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'CleanClothsHairNetsGloves',
    'databaseVarType': 'bool',
    'databaseOptCom': 'CleanClothsHairNetsGlovesComments ',
    'actionItem':
        'Ensure the use of hairnets/ disposable gloves during preparing, cooking, and serving of meals'
  },
  <String, dynamic>{
    'text':
        'Does the program use new or properly sanitized reusable food storage containers? (Plastic bags may not be reused) ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'NewOrSanitizedFoodStorageContainers',
    'databaseVarType': 'bool',
    'databaseOptCom': 'NewOrSanitizedFoodStorageContainersComments ',
    'actionItem':
        'Ensure only New or properly sanitized reusable food storage containers are utilized (Plastic bags may not be reused)'
  },
  <String, dynamic>{
    'text':
        'Are single service items used once and discarded? (ex: chips, bread, salsa)? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'SingleServiceItemsDiscarded',
    'databaseVarType': 'bool',
    'databaseOptCom': 'SingleServiceItemsDiscardedComments ',
    'actionItem':
        'Ensure single service items are used only once and then discarded'
  },
  <String, dynamic>{
    'text': 'Are staff and volunteers wearing clean clothes/aprons? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'StaffWearingCleanClothes',
    'databaseVarType': 'bool',
    'databaseOptCom': 'StaffWearingCleanClothesComments ',
    'actionItem': 'Ensure the use of clean clothes/aprons '
  },
  <String, dynamic>{
    'text': 'Are staff and volunteers restricted if ill? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'StaffRestrictedIfIll',
    'databaseVarType': 'bool',
    'databaseOptCom': 'StaffRestrictedIfIllComments ',
    'actionItem': 'Ensure volunteers/staff are restricted if ill'
  },
  <String, dynamic>{
    'text':
        'Are staff and volunteers required to wash their hands after returning from the bathroom or a smoking break? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'StaffRequiredToWashHands',
    'databaseVarType': 'bool',
    'databaseOptCom': 'StaffRequiredToWashHandsComments ',
    'actionItem':
        'Ensure staff and volunteers wash their hands after returning from the bathroom or a smoke break'
  },
  <String, dynamic>{
    'text': 'Are hands being washed properly? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'HandsAreAppropriatelyWashed',
    'databaseVarType': 'bool',
    'databaseOptCom': 'HandsAreAppropriatelyWashedComments ',
    'actionItem': 'Ensure hands are washed properly'
  },
  <String, dynamic>{
    'text': 'Is there a Handwashing sign posted? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'HandwashingSignPosted',
    'databaseVarType': 'bool',
    'databaseOptCom': 'HandwashingSignPosted ',
    'actionItem': 'Post Hand Washing sign'
  },
  <String, dynamic>{
    'text': 'Is all equipment in good condition? ',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'EquipmentInGoodCondition',
    'databaseVarType': 'bool',
    'databaseOptCom': 'EquipmentInGoodConditionComments ',
    'actionItem': 'Indicate equipment that is not in good condition:'
  },
];

List<Map<String, dynamic>> audit2Section7Questions = [
  <String, dynamic>{
    'text': 'Plumbing issues?',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'databaseVar': 'PlumbingIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PlumbingIssuesComments',
    'actionItem': 'Explain issue and action item for plumbing issues: '
  },
  <String, dynamic>{
    'text': 'Sewage issues?',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'databaseVar': 'SewageIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'SewageIssuesComments',
    'actionItem': 'Explain issue and action item for Sewage issues: '
  },
  <String, dynamic>{
    'text': 'Garbage and refuse disposal',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'databaseVar': 'GarbageRefusalDisposalIssues',
    'databaseVarType': 'bool',
    'databaseOptCom': 'GarbageRefusalDisposalIssuesComments',
    'actionItem':
        'Explain issue and action item for garbage and refuse disposal issues: '
  },
  <String, dynamic>{
    'text':
        'Was the site able to provide a pest control log/exterminator’s report? (please provide the name of the company and date last serviced',
    'type': 'yesNo',
    'happyPathResponse': ['Yes'],
    'databaseVar': 'PestControlReport',
    'databaseVarType': 'bool',
    'databaseOptCom': 'PestControlReportComments',
    'actionItem':
        'Submit a copy of current/most recent Pest Control Log/Exterminator’s Report'
  },
  <String, dynamic>{
    'text': 'Current fire extinguisher',
    'type': 'issuesNoIssues',
    'happyPathResponse': ['No Issues'],
    'databaseVar': 'CurrentFireExt', //<-----
    'databaseVarType': 'bool',
    'databaseOptCom': 'CurrentFireExtComments', //<-----
    'actionItem': 'Explain action items for the fire extinguisher: '
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
        'Please explain ventilatin issues and action items in comments'
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
        'Please explain issues with access to all pertinent areas of food program action items:'
  },
  <String, dynamic>{
    'text': 'Pest Control Company:',
    'type': 'fillIn',
    'databaseVar': 'PestControlCompany',
    'databaseVarType': 'string'
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
];

List<Map<String, dynamic>> audit2Section8Questions = [
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
    'type': 'yesNo',
    'databaseVar': 'DiscriminationComplaintForwardedToGCFD',
    'databaseVarType': 'bool',
    'databaseOptCom': 'DiscriminationComplaintForwardedToGCFDComments',
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

List<Map<String, List<Map<String, dynamic>>>> congregateAuditSectionsQuestions =
    [
  <String, List<Map<String, dynamic>>>{"Confirm Details": confirmDetails},
  <String, List<Map<String, dynamic>>>{"Intro": audit2Section1Questions},
  <String, List<Map<String, dynamic>>>{"Signage": audit2Section2Questions},
  <String, List<Map<String, dynamic>>>{
    "Distribution & Intake": audit2Section3Questions
  },
  <String, List<Map<String, dynamic>>>{"Dry Storage": audit2Section4Questions},
  <String, List<Map<String, dynamic>>>{"Cold Storage": audit2Section5Questions},
  <String, List<Map<String, dynamic>>>{
    "Meal Prep & Servicing": audit2Section6Questions
  },
  <String, List<Map<String, dynamic>>>{"Other": audit2Section7Questions},
  <String, List<Map<String, dynamic>>>{
    "Complaints & Problems": audit2Section8Questions
  },
  <String, List<Map<String, dynamic>>>{"Photos": photoData},
  <String, List<Map<String, dynamic>>>{"Review": reviewData},
  <String, List<Map<String, dynamic>>>{"Verification": verificationData},
  <String, List<Map<String, dynamic>>>{"*Developer*": developerData},
];
