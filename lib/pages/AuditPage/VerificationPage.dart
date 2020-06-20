import 'package:auditor/Definitions/colorDefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'dart:math';
import 'dart:typed_data';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  Uint8List finalImage = null;
  var color = Colors.red;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/CMRI_top.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('''The Undersigned Agent of: 


Hereby warrants that as a representative of said agency he/she will receive assorted foods from the

Greater Chicago Food Depository

It is further agreed between the GREATER CHICAGO FOOD DEPOSITORTY and said CHARITABLE AGENCY that:

The food is accepted “as is.”
Greater Chicago Food Depository, Feeding America and the original donor expressly disclaim and implied warranties of merchantability of fitness for a particular use. There have been no expressed warrantees in relation to this gift of food.
It is the responsibility of the agency to inspect all goods received through the FOOD DEPOSITORY and withhold from distributing and food item that might be spoiled or inedible.
Said CHARITABLE AGENCY releases both the original donor, Feeding America and Greater Chicago Food Depository from any liability resulting from the condition of donated food, and further agrees to indemnify and hold Greater Chicago Food Depository, Feeding America and the original donor free and harmless against all and any liabilities, damages, losses claims whatsoever arising out of attributed to any action of said CHARITABLE AGENCY in connection with its storage, handling and use of donated food.
It is the responsibility of the CHARITABLE AGENCY to keep and maintain necessary records which show that goods received through the FOOD DEPOSITORY have been given to the needy in the Cook County Area without regard to race, religion, gender, age, sexual orientation or political affiliation.
Said CHARITABLE AGENCY will not sell or offer for sale. Said CHARITABLE AGENCY will not request donations, services, contributions, membership or membership fees from recipients, directly or indirectly for said food. Said CHARITABLE AGENCY agrees to serve and/or distribute all goods received without monetary charge or by any medium exchange.
If violations of the agreement above occur or non-compliance of Membership Eligibility Requirements, said CHARITABLE AGENCY may be suspended and/or terminated from membership of the Greater Chicago Food Depository.'''),
            ),
            Text('''Address ____
City ____
Pincode ___'''),
            Image(
              image: AssetImage('assets/images/CMRI_sign.png'),
            ),
            finalImage == null
                ? Container()
                : LimitedBox(
                    maxHeight: 200.0,
                    child: Image.memory(finalImage.buffer.asUint8List())),
            if (finalImage == null)
              Container(
                width: double.infinity,
                height: 400,
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
            if (finalImage == null)
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
                          finalImage =
                              img.encodePng(signatureImage) as Uint8List;
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
                          finalImage = null;
                        });
                        debugPrint("cleared");
                      },
                      child: Text("Clear")),
                ],
              ),
            if (finalImage == null)
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
