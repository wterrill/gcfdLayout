import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:io';
import 'dart:typed_data';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key key, this.activeAudit}) : super(key: key);
  final Audit activeAudit;

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  Uint8List pickedImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("THIS SECTION IS UNDER CONSTRUCTION"),
          Container(
            child: RaisedButton(
                onPressed: () async {
                  // File _image;
                  final picker = ImagePicker();
                  PickedFile fromPicker =
                      await picker.getImage(source: ImageSource.gallery);
                  pickedImage = await fromPicker.readAsBytes();
                  widget.activeAudit.photoList.add(pickedImage);
                  setState(() {});
                  print(widget.activeAudit.photoList.length);
                },
                child: Text("Choose picture")),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: widget.activeAudit.photoList?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    4), //(orientation == Orientation.portrait) ? 2 : 3),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: LimitedBox(
                    maxHeight: 100.0,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              width: 2.0, color: Colors.lightBlue.shade900),
                        )),
                        child: Image.memory(widget
                            .activeAudit.photoList[index].buffer
                            .asUint8List()))),
              );
            },
          ),
          // (pickedImage == null)
          //     ? Container()
          //     : Container(
          //         child: LimitedBox(
          //             maxHeight: 100.0,
          //             child: Container(
          //                 decoration: BoxDecoration(
          //                     border: Border(
          //                   bottom: BorderSide(
          //                       width: 2.0, color: Colors.lightBlue.shade900),
          //                 )),
          //                 child: Image.memory(widget
          //                     .activeAudit.photoList[0].buffer
          //                     .asUint8List()))),
          //       ),
        ],
      ),
    );
  }
}
