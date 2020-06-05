////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

// Date of Visit: _____________________________		Start Time: 1pm___________   End Time: ____________
// Type of Visit: ☐ Annual  ☐ Bi-Annual  ☐ Complaint  ☐ Grant  ☐ CEDA  ☐  Food Rescue  ☐ Follow Up
// Agency Name: _________________________________________	Agency/Program Number: _______________________
// Site Address: __________________________________________	GCFD Monitor: _____________________________________

// Program Contact: ________________________________________________________________________________
// Person interviewed: ______________________________________________________________________________
// Program Operating Hours: _________________________________________________________________________
// Service Area: ____________________________________________________________________________________

List<Map<String, dynamic>> confirmDetails = [
  <String, dynamic>{'text': 'Date of Visit:', 'type': 'display'},
  <String, dynamic>{'text': 'Start Time: ', 'type': 'display'},
  <String, dynamic>{'text': 'End Time: ', 'type': 'display'},
  <String, dynamic>{
    'text': 'Type of Visit: Annual Complaint Grant CEDA Food Rescue Follow Up',
    'type': 'display'
  },
  <String, dynamic>{'text': 'Agency Name: ', 'type': 'display'},
  <String, dynamic>{'text': 'Agency/Program Number: ', 'type': 'display'},
  <String, dynamic>{'text': 'Site address: ', 'type': 'display'},
  <String, dynamic>{'text': 'GCFD Monitor: ', 'type': 'display'},
  <String, dynamic>{'text': 'Program Contact: ', 'type': 'display'},
  <String, dynamic>{'text': 'Person Interviewed: ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Program Operating Hours: ', 'type': 'display'},
  <String, dynamic>{'text': 'Service Area: ', 'type': 'display'},
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
    'happyPathResponse': ['no']
  },
  <String, dynamic>{
    'text': 'Does pantry serve outside this service area?',
    'type': 'yesNo',
  },

  // TODO this needs to somehow be linked to the question above so that it can be blank, but still show up as completed, if the question above is "no"
  <String, dynamic>{
    'text': 'If yes, how many and from where do guests travel?',
    'type': 'fillIn',
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
    ]
  },
  <String, dynamic>{
    'text':
        'Does the pantry allow guests to receive food at least once every 30 days?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Are referrals from an outside agency required to receive food?',
    'type': 'yesNo',
    'happyPathResponse': ['no']
  },
  <String, dynamic>{
    'text': 'Are appointments required to receive food?',
    'type': 'yesNo',
    'happyPathResponse': ['no']
  },
  <String, dynamic>{
    'text': 'Does the pantry require any documentation?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text':
        'Describe the types of documentation requested and the purpose (only allowed to verify residency and identity):',
    'type': 'fillIn',
  },
  <String, dynamic>{
    'text': 'Does this pantry operate under the rural exemption?',
    'type': 'yesNo',
    'happyPathResponse': ['no']
  },
  <String, dynamic>{
    'text': 'Does this food pantry also operate a soup kitchen?',
    'type': 'yesNo',
  },
  //TODO: this below question needs to be linked to the above question
  <String, dynamic>{
    'text':
        'If yes, is the food properly separated and tracked for two programs?',
    'type': 'yesNoNa',
    'happyPathResponse': ['yes', 'na']
  },
  <String, dynamic>{
    'text':
        'If yes, is the food properly separated and tracked for two programs?',
    'type': 'yesNo'
  },

  <String, dynamic>{
    'text': 'Is Program on Food Rescue/Agency Enabled?',
    'type': 'yesNo',
    'happyPathResponse': ['yes', 'na']
  },
  <String, dynamic>{
    'text': 'Food Service Sanitation Manager Certificates',
    'type': 'fillIn'
  },
  <String, dynamic>{'text': 'Remove:', 'type': 'fillIn'},

  <String, dynamic>{'text': 'Last Order Date:', 'type': 'date'},

  <String, dynamic>{
    'text': 'What is the number of deliveries per month?',
    'type': 'fillIn'
  },

  <String, dynamic>{
    'text': 'Has an order been placed from the menu in the past month?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Has an online intake system been used in the past month?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
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
    'happyPathResponse': ['yes', 'closed program']
  },
];

List<Map<String, dynamic>> audit1Section2Questions = [
  <String, dynamic>{
    'text': "Is entrance clearly marked?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': "Is there a sign posted outside with days and hours of operation?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text':
        "Is there a sign posted with service requirements/guidelines visible to guests?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': "Is the Food Depository contact information posted?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text':
        "What types of public outreach and networking does the pantry use to make the general public aware of their services?",
    'type': 'fillIn'
  },
  <String, dynamic>{
    'text':
        "Are TEFAP posters accessible to guests?(Ex: Income Eligibility, Notice to Program Participants, Prohibited Activities, /“And Justice for All/”)",
    'type': 'yesNoNa',
    'happyPathResponse': ['yes', 'na']
  },
];

List<Map<String, dynamic>> audit1Section3Questions = [
  <String, dynamic>{
    'text':
        "Are activities conducted that might be interpreted as requiring fees/donations/memberships?",
    'type': 'yesNo',
    'happyPathResponse': ['no']
  },
  <String, dynamic>{
    'text': "Is an online intake system being utilized?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': "If it is not being utilized, are DHS signature documents used?",
    'type': 'yesNoNa',
    'happyPathResponse': ['yes', 'na']
  },
  <String, dynamic>{
    'text': "Does the guest sign his/her name upon receipt?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': "Is the address recorded upon receipt?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': "Is the household size recorded upon receipt?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text':
        "Does the pantry have the guest sign even if only privately donated food is received?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text':
        "Are original DHS signature documents and surveys submitted to the Food Depository monthly?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': "Is the TEFAP manual accessible to pantry staff and/or volunteers?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': "Are proxy forms used?",
    'type': 'yesNo',
  },
//TODO The above question needs to be linked to the below question
  <String, dynamic>{
    'text':
        "If yes, do they contain the original signature of the recipient getting food?",
    'type': 'yesNoNa',
    'happyPathResponse': ['yes', 'na']
  },

  <String, dynamic>{
    'text':
        "Does the proxy sign the proxy form in the presence of pantry personnel?",
    'type': 'yesNoNa',
    'happyPathResponse': ['yes', 'na']
  },
  <String, dynamic>{
    'text':
        "Do pantry personnel sign the proxy form at the time of distribution?",
    'type': 'yesNoNa',
    'happyPathResponse': ['yes', 'na']
  },
  <String, dynamic>{
    'text': "Are TANF commodities being distributed?",
    'type': 'yesNo'
  },
  //TODO the answer from the above question should be linked to the below question,
  //if yes above, it should be yes below
  <String, dynamic>{
    'text': "If yes, do guests complete the required TANF information?",
    'type': 'yesNoNa',
    'happyPathResponse': ['yes', 'na']
  },
  <String, dynamic>{
    'text':
        "Are guests without children in the household completing TANF information?",
    'type': 'yesNoNa',
    'happyPathResponse': ['yes', 'na']
  },
  <String, dynamic>{
    'text': "Technology being used:	#of Tablets:",
    'type': 'fillIn'
  },
  <String, dynamic>{'text': "#of Computers:", 'type': 'fillIn'},

  <String, dynamic>{'text': "Guest disposition", 'type': 'fillIn'},
  <String, dynamic>{
    'text': "Guests served during site visit:",
    'type': 'fillIn'
  },
  <String, dynamic>{'text': "Guests served each month:", 'type': 'fillIn'},
  <String, dynamic>{'text': "Volunteer disposition:", 'type': 'fillIn'},
  <String, dynamic>{'text': "# of Intake volunteers:", 'type': 'fillIn'},
  <String, dynamic>{'text': "# of Distribution volunteers:", 'type': 'fillIn'},
  <String, dynamic>{
    'text': "How does the pantry recruit volunteers?",
    'type': 'fillIn'
  },
  <String, dynamic>{
    'text': "Are other activities unrelated to TEFAP disrupting distribution?",
    'type': 'yesNo',
    'happyPathResponse': ['no']
  },
  <String, dynamic>{
    'text': "Do all distribution activities appear to be appropriate?",
    'type': 'yesNo',
    'happyPathResponse': ['yes']
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
    'happyPathResponse': ['client choice', 'prepacked', 'partial client choice']
  },
//TODO: The below question needs to be linked to the above question
  <String, dynamic>{'text': "If not client choice, why?", 'type': 'fillIn'},
];

List<Map<String, dynamic>> audit1Section4Questions = [
  <String, dynamic>{
    'text': 'Are floors, pallets, and shelving clean?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Is storage area organized?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Are pest proof containers utilized?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Are non-food items and toxic items stored separately?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Is food being rotated via FIFO?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Is food 6 inches off floor?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text':
        'Is food kept far enough away from walls and floor to permit good air circulation and to allow for pest control?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Are proper temperatures for dry food storage maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  //TODO: Make comment mandatory
  <String, dynamic>{
    'text':
        'Is the food stored in a secure location with adequate space? If no, explain:',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Is food clearly marked for use by food program only?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Is storage area only for approved food program?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Is equipment well maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Appropriate amount of food in inventory?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': '# of cases of dry food currently in inventory:',
    'type': 'fillIn'
  },
  <String, dynamic>{
    'text': '# of cases of meat currently in inventory: ',
    'type': 'fillIn'
  },
  <String, dynamic>{
    'text': '# of cases of perishable items in inventory: ',
    'type': 'fillIn'
  },
  <String, dynamic>{
    'text':
        'Does the pantry have other foods to distribute with government commodities?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{'text': 'Area 1: ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Area 2: ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Area 3: ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Area 4: ', 'type': 'fillIn'},
];

List<Map<String, dynamic>> audit1Section5Questions = [
  <String, dynamic>{
    'text': 'Are units clean?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Are units defrosted?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Are units organized?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Is food being rotated via FIFO?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Do units have thermometers?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Are units only for approved food program?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Is food appropriately labeled?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Is food appropriately stocked and not overstuffed in units?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Are units numbered?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Is equipment well maintained?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text': 'Are cold storage units secured?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text':
        'Are refrigerated items kept at temperatures between 35-40 degrees Fahrenheit?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text':
        'Are frozen items kept at a temperature below zero degrees Fahrenheit?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{'text': 'Cold Storage Unit 1 ºF', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Cold Storage Unit 2 ºF', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Cold Storage Unit 3 ºF', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Cold Storage Unit 4 ºF', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Cold Storage Unit 5 ºF', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Cold Storage Unit 6 ºF', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Cold Storage Unit 7 ºF', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Cold Storage Unit 8 ºF', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Cold Storage Unit 9 ºF', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Cold Storage Unit 10 ºF', 'type': 'fillIn'},
  <String, dynamic>{
    'text': 'Walk in:',
    'type': 'dropDown',
    'menuItems': ['Select', 'Freezer', 'Cooler']
  },
  <String, dynamic>{'text': 'USDA Tag # ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Serial # ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Type ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'USDA Tag # ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Serial # ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Type ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'USDA Tag # ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Serial # ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Type ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'USDA Tag # ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Serial # ', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Type ', 'type': 'fillIn'},
  <String, dynamic>{
    'text': '*Units should not be shared with other programs ',
    'type': 'Display',
  },
];

List<Map<String, dynamic>> audit1Section6Questions = [
  <String, dynamic>{'text': 'Plumbing', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Sewage', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Garbage and refuse disposal', 'type': 'fillIn'},
  <String, dynamic>{
    'text': 'Pest control log/exterminator’s report',
    'type': 'fillIn'
  },
  <String, dynamic>{
    'text':
        'Are floors, doors, windows, and roofs well sealed to prevent pest entry and water damage?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{'text': 'Appropriate Lighting', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Ventilation', 'type': 'fillIn'},
  <String, dynamic>{
    'text':
        'Access to all pertinent areas of food program (dry storage, cold storage, intake, distribution)',
    'type': 'fillIn'
  },
  <String, dynamic>{'text': 'Pest Control Company:', 'type': 'fillIn'},
  <String, dynamic>{
    'text': 'Evidence of Rodents/ Insects (Includes fruit and house flies):',
    'type': 'yesNo',
    'happyPathResponse': ['no']
  },
  //TODO the below question should be linked to the above question
  <String, dynamic>{'text': 'If yes, details:', 'type': 'fillIn'},
];

List<Map<String, dynamic>> audit1Section7Questions = [
  <String, dynamic>{
    'text': 'Have there been any discrimination complaints in the past year?',
    'type': 'yesNo'
  },
  <String, dynamic>{
    'text':
        'Does the program know what to do if there is a discrimination complaint?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text':
        'If there have been any discrimination complaints, have they been forwarded to the Food Depository?',
    'type': 'yesNo',
    'happyPathResponse': ['yes']
  },
  <String, dynamic>{
    'text':
        'If the pantry has questions or problems, what is the name and phone number of their Food Depository contact person?',
    'type': 'fillIn'
  },
  <String, dynamic>{'text': 'Issues from last site visit?', 'type': 'fillIn'},
  <String, dynamic>{
    'text': 'Distribution Stie Staff Comments: ',
    'type': 'fillIn'
  },
  <String, dynamic>{'text': 'Food Depository Comments', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Donors', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Date Tax Exemption Verified', 'type': 'date'},
  <String, dynamic>{'text': 'Re-verified by:', 'type': 'fillIn'},
  <String, dynamic>{'text': 'GCFD Monitor', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Reviewed by', 'type': 'fillIn'},
  <String, dynamic>{'text': 'Findings Found:', 'type': 'yesNo'},
];

List<Map<String, List<Map<String, dynamic>>>> auditSectionsQuestions = [
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
