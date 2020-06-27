import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/AuditClasses/Question.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'dart:typed_data';

import 'ReviewSection/FollowupActionItems2.dart';
import 'ReviewSection/FollowupCitationsSections.dart';

class VerificationBadPage extends StatefulWidget {
  const VerificationBadPage({Key key, this.activeAudit}) : super(key: key);
  final Audit activeAudit;

  @override
  _VerificationBadPageState createState() => _VerificationBadPageState();
}

class _VerificationBadPageState extends State<VerificationBadPage> {
  // Uint8List finalImage = null;
  // Uint8List finalImage2 = null;
  var color = Colors.red;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();
  final _sign2 = GlobalKey<SignatureState>();
  Uint8List siteRepresentativeSignature = null;
  Uint8List foodDepositoryMonitorSignature = null;
  List<String> actionItems;

  DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    bool flaggedCitationsExist(List<Question> citations) {
      bool exists = false;
      for (Question citation in citations) {
        if (!citation.unflagged) {
          exists = true;
          return exists;
        }
      }
      return exists;
    }

    List<Question> citations = Provider.of<AuditData>(context).citations;
    selectedDate = widget.activeAudit?.correctiveActionPlanDueDate;
    try {
      foodDepositoryMonitorSignature =
          widget.activeAudit?.photoSig['foodDepositoryMonitorSignature'];
    } catch (err) {}
    try {
      siteRepresentativeSignature =
          widget.activeAudit?.photoSig['siteRepresentativeSignature'];
    } catch (err) {}

    return Container(
      child: Expanded(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text("CITATIONS", style: ColorDefs.textBodyBlack30),
            Container(
              height: 350,
              child: FollowupCitationsSections(
                  // activeAudit: widget.activeAudit,
                  ),
            ),
            if (flaggedCitationsExist(citations))
              Text("ACTION ITEMS", style: ColorDefs.textBodyBlack30),
            // Container(
            //   height: 350,
            //   child: FollowupActionItems(
            //     activeAudit: widget.activeAudit,
            //   ),
            // ),
            // Text("ACTION ITEMS Ver 2", style: ColorDefs.textBodyBlack30),
            if (flaggedCitationsExist(citations))
              Container(
                height: 350,
                child: FollowupActionItems2(
                    // activeAudit: widget.activeAudit,
                    ),
              ),

            Row(
              children: [
                Text("These Compliance Requirements must be completed by: "),
                RaisedButton(
                  child: Text((selectedDate != null)
                      ? DateFormat('MM-dd-yyyy').format(selectedDate)
                      : "Select Date"),
                  onPressed: () async {
                    selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    widget.activeAudit.correctiveActionPlanDueDate =
                        selectedDate;
                    setState(() {});
                  },
                )
              ],
            ),

            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            // child:
            Text('''
In order to be fully certified and in good standing with the Greater Chicago Food Depository. Failure to comply with the requirements listed below will result in corrective action up to, and including, suspension and/or termination of membership. We appreciate your prompt attention to this matter to ensure your community does not suffer an interruption of services.'''),
            Row(
              children: [
                Text('Program is being placed on immediate hold:'),
                if (widget.activeAudit.putProgramOnImmediateHold == null ||
                    widget.activeAudit.putProgramOnImmediateHold == true)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.activeAudit.putProgramOnImmediateHold = true;
                        });
                      },
                      child: Container(
                        color: ColorDefs.colorButtonNeutral,
                        height: 50,
                        width: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.done,
                              color: Colors.red,
                            ),
                            Text("Yes")
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.activeAudit.putProgramOnImmediateHold == null ||
                    widget.activeAudit.putProgramOnImmediateHold == false)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.activeAudit.putProgramOnImmediateHold = false;
                      });
                    },
                    child: Container(
                      color: ColorDefs.colorButtonNeutral,
                      height: 50,
                      width: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.clear, color: Colors.green),
                          Text("No")
                        ],
                      ),
                    ),
                  )
              ],
            ),
            Text(
                '''Submit a dated and SIGNED Letter of Compliance regarding above issues on your agency letterhead.  Please do not submit pictures of documents as the quality is not legible when Printed  
 '''),
            // ),

            if (foodDepositoryMonitorSignature == null)
              Text("Food Depository Monitor"),

            foodDepositoryMonitorSignature == null
                ? Container()
                : Container(
                    child: LimitedBox(
                        maxHeight: 100.0,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: 2.0, color: Colors.lightBlue.shade900),
                            )),
                            child: Image.memory(foodDepositoryMonitorSignature
                                .buffer
                                .asUint8List()))),
                  ),

            if (foodDepositoryMonitorSignature == null)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: ColorDefs.colorUserAccent, width: 1.0),
                ),
                child: Signature(
                  color: color,
                  key: _sign,
                  onSign: () {
                    final sign = _sign.currentState;
                    debugPrint('${sign.points.length} points in the signature');
                  },
                  backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                  strokeWidth: strokeWidth,
                ),
              ),
            if (foodDepositoryMonitorSignature == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: Colors.green,
                      onPressed: () async {
                        SignatureState sign = _sign.currentState;
                        int lineColor =
                            img.getColor(color.red, color.green, color.blue);
                        int backColor = img.getColor(255, 255, 255);
                        int imageWidth;
                        int imageHeight;
                        BuildContext currentContext = _sign.currentContext;
                        if (currentContext != null) {
                          var box =
                              currentContext.findRenderObject() as RenderBox;
                          imageWidth = box.size.width.toInt();
                          imageHeight = box.size.height.toInt();
                        }

                        // create the image with the given size
                        img.Image signatureImage =
                            img.Image(imageWidth, imageHeight);

                        // set the image background color
                        // remove this for a transparent background
                        img.fill(signatureImage, backColor);

                        for (int i = 0; i < sign.points.length - 1; i++) {
                          if (sign.points[i] != null &&
                              sign.points[i + 1] != null) {
                            img.drawLine(
                                signatureImage,
                                sign.points[i].dx.toInt(),
                                sign.points[i].dy.toInt(),
                                sign.points[i + 1].dx.toInt(),
                                sign.points[i + 1].dy.toInt(),
                                lineColor,
                                thickness: 3);
                          } else if (sign.points[i] != null &&
                              sign.points[i + 1] == null) {
                            // draw the point to the image
                            img.drawPixel(
                                signatureImage,
                                sign.points[i].dx.toInt(),
                                sign.points[i].dy.toInt(),
                                lineColor);
                          }
                        }

                        sign.clear();
                        setState(() {
                          foodDepositoryMonitorSignature =
                              img.encodePng(signatureImage) as Uint8List;
                          Provider.of<AuditData>(context, listen: false)
                                  .foodDepositoryMonitorSignature =
                              foodDepositoryMonitorSignature;
                          widget.activeAudit
                                  .photoSig['foodDepositoryMonitorSignature'] =
                              foodDepositoryMonitorSignature;
                          Provider.of<AuditData>(context, listen: false)
                              .notifyTheListeners();
                        });
                        debugPrint("onPressed ");
                      },
                      child: Text("Save")),
                  MaterialButton(
                      color: Colors.grey,
                      onPressed: () {
                        final sign = _sign.currentState;
                        sign.clear();
                        setState(() {
                          foodDepositoryMonitorSignature = null;
                        });
                        debugPrint("cleared");
                      },
                      child: Text("Clear")),
                ],
              ),
            if (foodDepositoryMonitorSignature == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          color =
                              color == Colors.green ? Colors.red : Colors.green;
                        });
                        debugPrint("change color");
                      },
                      child: Text("Change color")),
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          int min = 1;
                          int max = 10;
                          int selection = min + (Random().nextInt(max - min));
                          strokeWidth = selection.roundToDouble();
                          debugPrint("change stroke width to $selection");
                        });
                      },
                      child: Text("Change stroke width")),
                ],
              ),
//////////////  END FIRST SIGNATURE /////////////////////////////
            if (foodDepositoryMonitorSignature != null)
              Text("Food Depository Monitor"),
            if (siteRepresentativeSignature == null)
              Text("Agency Representative"),
//////////////  SECOND SIGNATURE /////////////////////////////
            siteRepresentativeSignature == null
                ? Container()
                : LimitedBox(
                    maxHeight: 100.0,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              width: 2.0, color: Colors.lightBlue.shade900),
                        )),
                        child: Image.memory(
                            siteRepresentativeSignature.buffer.asUint8List()))),
            if (siteRepresentativeSignature != null)
              Text("Agency Representative"),
            if (siteRepresentativeSignature == null)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: ColorDefs.colorUserAccent, width: 1.0),
                ),
                child: Signature(
                  color: color,
                  key: _sign2,
                  onSign: () {
                    final sign = _sign2.currentState;
                    debugPrint('${sign.points.length} points in the signature');
                  },
                  backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                  strokeWidth: strokeWidth,
                ),
              ),
            if (siteRepresentativeSignature == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: Colors.green,
                      onPressed: () async {
                        SignatureState sign = _sign2.currentState;
                        int lineColor =
                            img.getColor(color.red, color.green, color.blue);
                        int backColor = img.getColor(255, 255, 255);
                        int imageWidth;
                        int imageHeight;
                        BuildContext currentContext = _sign2.currentContext;
                        if (currentContext != null) {
                          var box =
                              currentContext.findRenderObject() as RenderBox;
                          imageWidth = box.size.width.toInt();
                          imageHeight = box.size.height.toInt();
                        }

                        // create the image with the given size
                        img.Image signatureImage =
                            img.Image(imageWidth, imageHeight);

                        // set the image background color
                        // remove this for a transparent background
                        img.fill(signatureImage, backColor);

                        for (int i = 0; i < sign.points.length - 1; i++) {
                          if (sign.points[i] != null &&
                              sign.points[i + 1] != null) {
                            img.drawLine(
                                signatureImage,
                                sign.points[i].dx.toInt(),
                                sign.points[i].dy.toInt(),
                                sign.points[i + 1].dx.toInt(),
                                sign.points[i + 1].dy.toInt(),
                                lineColor,
                                thickness: 3);
                          } else if (sign.points[i] != null &&
                              sign.points[i + 1] == null) {
                            // draw the point to the image
                            img.drawPixel(
                                signatureImage,
                                sign.points[i].dx.toInt(),
                                sign.points[i].dy.toInt(),
                                lineColor);
                          }
                        }
                        sign.clear();
                        setState(() {
                          siteRepresentativeSignature =
                              img.encodePng(signatureImage) as Uint8List;
                          Provider.of<AuditData>(context, listen: false)
                                  .siteRepresentativeSignature =
                              siteRepresentativeSignature;
                          widget.activeAudit
                                  .photoSig['siteRepresentativeSignature'] =
                              siteRepresentativeSignature;
                          Provider.of<AuditData>(context, listen: false)
                              .notifyTheListeners();
                        });
                        debugPrint("onPressed ");
                      },
                      child: Text("Save")),
                  MaterialButton(
                      color: Colors.grey,
                      onPressed: () {
                        final sign = _sign2.currentState;
                        sign.clear();
                        setState(() {
                          siteRepresentativeSignature = null;
                        });
                        debugPrint("cleared");
                      },
                      child: Text("Clear")),
                ],
              ),
            if (siteRepresentativeSignature == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          color =
                              color == Colors.green ? Colors.red : Colors.green;
                        });
                        debugPrint("change color");
                      },
                      child: Text("Change color")),
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          int min = 1;
                          int max = 10;
                          int selection = min + (Random().nextInt(max - min));
                          strokeWidth = selection.roundToDouble();
                          debugPrint("change stroke width to $selection");
                        });
                      },
                      child: Text("Change stroke width")),
                ],
              ),
          ],
        ),
      )),
    );
  }
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8,
        Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WatermarkPaint &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}
