// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:auditor/providers/WebData.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';

// class PdfLoaderSection extends StatefulWidget {
//   @override
//   PdfLoaderSectionState createState() => new PdfLoaderSectionState();
//   Uint8List pdfData;
//   PdfLoaderSection(this.pdfData);
// }

// class PdfLoaderSectionState extends State<PdfLoaderSection> {
//   // var option = 0;
//   // var mode = 2;

//   @override
//   Widget viewpdf() {
//     // super.initState();

//     PdfViewerConfig config = PdfViewerConfig(
//       nightMode: false, //option == 1,
//       enableSwipe: false, // option != 2,
//       swipeHorizontal: false, //option == 3,
//       autoSpacing: false, // option == 4,
//       pageFling: false, // option == 5,
//       pageSnap: false, // option == 6,
//       enableImmersive: false, // option == 7,
//       autoPlay: false, // option == 8,
//       forceLandscape: false, // option == 11,
//       slideShow: false, // option == 9,
//       // videoPages: videoPages,
//       // xorDecryptKey: key,
//       initialPage: null,
//       atExit: (pageIndex) {
//         print(">> atExit($pageIndex)");
//       },
//     );
// }

//     return PdfViewer.loadBytes(widget.pdfData, config: config);
//   }

//       Future<Uint8List> assetToBytes(String src) async {
//   final bytes = await rootBundle.load(src);
//   return bytes.buffer.asUint8List();

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         appBar: new AppBar(
//           title: const Text('Flutter PDF Viewer'),
//         ),
//         body: new Center(
//           child: ListView(
//             children: [
//               viewpdf(),
//               Container(
//                 margin: const EdgeInsets.all(10),
//                 height: 1,
//                 color: Colors.black,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
