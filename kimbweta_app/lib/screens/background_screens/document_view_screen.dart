import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kimbweta_app/components/whiteboard.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../constants/constants.dart';
class DocumentViewScreen extends StatefulWidget {

  File? path;
  // String? docName;

  DocumentViewScreen({this.path});

  @override
  State<DocumentViewScreen> createState() => _DocumentViewScreenState();
}

class _DocumentViewScreenState extends State<DocumentViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.docName.toString()),
        title: Text('Document Name'),

        ///Side Drawer
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.screen_share)),
          PopupMenuButton(itemBuilder: (BuildContext context)=><PopupMenuEntry>[

            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.draw_outlined),
                title: const Text('whiteBoard'),
                onTap: (){
                  Navigator.pushNamed(context, WhiteboardScreen.id);

                },
              ),
            ),
          ],
          )
        ],
      ),
      body: Center(
        child:
     widget.path != null
          ? SfPdfViewer.file(widget.path!)
          : Text('An Error Occured Try Again'),
      )

    );
  }
}
