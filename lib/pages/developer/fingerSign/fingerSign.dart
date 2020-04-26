import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

import 'package:image/image.dart' as img;

//void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.landscapeLeft]);
//  runApp(MyApp());
//}

class FingerSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
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

class _MyHomePageState extends State<MyHomePage> {
  Uint8List finalImgUint8List = null;
  // Image finalImage;
  ByteData _img = ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Signature(
                  color: color,
                  key: _sign,
                  onSign: () {
                    final sign = _sign.currentState;
                    debugPrint('${sign.points.length} points in the signature');
                  },
                  backgroundPainter: _WatermarkPaint("beer", "beers"),
                  strokeWidth: strokeWidth,
                ),
              ),
              color: Colors.black12,
            ),
          ),
          // _img.buffer.lengthInBytes == 0
          finalImgUint8List == null
              ? Container()
              : LimitedBox(
                  maxHeight: 200.0,
                  // child: Image.memory(_img.buffer.asUint8List())),
                  child: Image.memory(finalImgUint8List.buffer.asUint8List())),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: Colors.green,
                      onPressed: () async {
                        final sign = _sign.currentState;
                        print(sign);

//////////////////////////////////////////////////////////////////
                        var lineColor = img.getColor(0, 0, 0);
                        var backColor = img.getColor(255, 255, 255);
                        int imageWidth;
                        int imageHeight;
                        var yup = _sign.currentContext;
                        if (yup != null) {
                          var box = yup.findRenderObject() as RenderBox;
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

                        // encode the image to PNG
                        Image pngImage = Image.memory(
                            img.encodePng(signatureImage) as Uint8List);
                        // return pngImage;

                        //retrieve image data, do whatever you want with it (send to server, save locally...)
                        final image = await sign.getData();
                        print(image.toString());
                        print(image.runtimeType);
                        print("image data");
                        //////////////////////////////////////////////////////////////////////////////////////////
                        // var data = await image.toByteData(
                        //     // <-- This doesn't work on  web
                        //     format: ui.ImageByteFormat.png);
                        //////////////////////////////////////////////////////////////////////////////////////////
                        sign.clear();
                        // final encoded =
                        //     base64.encode(data.buffer.asUint8List());
                        setState(() {
                          // _img =
                          //     Image.memory(img.encodePng(signatureImage).); //data;
                          // finalImage = pngImage;
                          finalImgUint8List =
                              img.encodePng(signatureImage) as Uint8List;
                        });
                        debugPrint("onPressed "); // + encoded);
                      },
                      child: Text("Save")),
                  MaterialButton(
                      color: Colors.grey,
                      onPressed: () {
                        final sign = _sign.currentState;
                        sign.clear();
                        setState(() {
                          _img = ByteData(0);
                        });
                        debugPrint("cleared");
                      },
                      child: Text("Clear")),
                ],
              ),
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
          )
        ],
      ),
    );
  }
}
