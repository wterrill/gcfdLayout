import 'package:flutter/material.dart';
import 'colorDefs.dart';

Color siteColorLookup(String site) {
  Color endColor;
  switch (site) {
    case ("Audit 1"):
      endColor = ColorDefs.colorAudit1;
      break;

    case ("Audit 2"):
      endColor = ColorDefs.colorAudit2;
      break;

    case ("Audit 3"):
      endColor = ColorDefs.colorAudit3;
      break;

    case ("Audit 4"):
      endColor = ColorDefs.colorAudit4;
      break;

    case ("Audit 5"):
      endColor = ColorDefs.colorAudit5;
      break;
  }
  return endColor;
}
