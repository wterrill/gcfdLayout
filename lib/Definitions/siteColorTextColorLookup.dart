// import 'package:flutter/material.dart';
import 'colorDefs.dart';

Map<String, dynamic> siteColorTextColorLookup(String site) {
  Map<String, dynamic> endColorText;
  switch (site) {
    case ("Audit 1"):
      endColorText = <String, dynamic>{
        'color': ColorDefs.colorAudit1,
        'text': ColorDefs.textBodyWhite20
      };
      break;

    case ("Audit 2"):
      endColorText = <String, dynamic>{
        'color': ColorDefs.colorAudit2,
        'text': ColorDefs.textBodyBlack20
      };
      break;

    case ("Audit 3"):
      endColorText = <String, dynamic>{
        'color': ColorDefs.colorAudit3,
        'text': ColorDefs.textBodyWhite20
      };
      break;

    case ("Audit 4"):
      endColorText = <String, dynamic>{
        'color': ColorDefs.colorAudit4,
        'text': ColorDefs.textBodyWhite20
      };
      break;

    case ("Audit 5"):
      endColorText = <String, dynamic>{
        'color': ColorDefs.colorAudit5,
        'text': ColorDefs.textBodyBlack20
      };
      break;
  }
  return endColorText;
}
