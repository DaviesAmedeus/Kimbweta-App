import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kimbweta_app/components/our_material_icon_button.dart';
import 'package:kimbweta_app/screens/background_screens/document_view_screen.dart';
import 'package:kimbweta_app/screens/background_screens/admin_uploaded_files_screen.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import '../../api/api.dart';
import '../../components/our_pop_up_menu.dart';
import '../../components/snackbar.dart';
import '../../constants/constants.dart';
import '../authentication_screens/sign_in_screen.dart';

class AdminDiscussionScreen extends StatefulWidget {
  final String? gpId, name, code, description, createdAt;

  const AdminDiscussionScreen({
    super.key,
    this.gpId,
    this.name,
    this.code,
    this.description,
    this.createdAt,
  });

  static String id = 'Discussion';

  @override
  State<AdminDiscussionScreen> createState() => _AdminDiscussionScreenState();
}

class _AdminDiscussionScreenState extends State<AdminDiscussionScreen> {
  var userData, rootid, result, status;
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name!),

        ///Side Drawer
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.file_copy),
                  title: const Text('Files You Uploaded'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AdminUploadedFilesScreen(
                          id: widget.gpId,
                          name: widget.name,
                          code: widget.code,
                          description: widget.description,
                          createdAt: widget.createdAt,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blueGrey,
                Colors.black,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "To start a discussion you should pick a file first \u{1F447}",
                    style: TextStyle(color: kMainWhiteColor),
                    textAlign: TextAlign.center,
                  ),
                ),

                ///It should be active when document/whiteboard have been accessed
                ///Button for picking a file
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: OurMaterialIconButton(
                      icon: const Icon(
                        Icons.file_present,
                        color: kMainWhiteColor,
                      ),
                      label: 'Pick A file',
                      onPressed: () {
                        // A f(x) that enable a file to be picked
                        pickAFile();
                      },
                    )),
                const SizedBox(
                  height: 40,
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "For later references by group members, you should upload a file \u{1F447}",
                    style: TextStyle(color: kMainWhiteColor),
                    textAlign: TextAlign.center,
                  ),
                ),

                ///Button for uploading a file
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: OurMaterialIconButton(
                      icon: const Icon(
                        Icons.upload_file,
                        color: kMainWhiteColor,
                      ),
                      label: 'Upload file',
                      onPressed: () {
                        selectFileToUploadFile();
                      },
                    )),

                ///Test Button
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Function for picking a file
  void pickAFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null) {
      file = File(result.files.single.path!);

      // List<File> files = result.paths.map((path) => File(path!)).toList();
      // print(result.files.single.path);
      print('>>>>PRINTING FILE:>>>$file');

      setState(() {
        // file = File(path);
        // uploadFilePhaseZero();
      });

      print("file============$file");
      print("path============${file!.path}");
      // print("file============"+file!);

      // uploadFilePhaseOneDio();

      //   Navigator.of(this.context).push(
      //       MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)));
      // }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DocumentViewScreen(file: file),
        ),
      );
    } else {
      showSnack(context, 'Nothing was selected!');
    }

    Future<void> clearCacheDirectory() async {
      // Get the cache directory path
      Directory cacheDir = await getTemporaryDirectory();

      // Get all the files in the cache directory
      List<FileSystemEntity> files = cacheDir.listSync(recursive: true);

      // Delete each file in the cache directory
      for (var file in files) {
        if (file is File) {
          await file.delete();
        }
      }
    }
  }

  ///Function for uploading a file to a server
  void selectFileToUploadFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) {
      return;
    } else {
      file = File(result.files.single.path!);

      String fileName = path.basename(file!.path);
      // List<File> files = result.paths.map((path) => File(path!)).toList();
      // print(result.files.single.path);

      setState(() {
        // file = File(path);
        uploadFile(file, fileName);
      });

      // print("file============" + file.toString());
      // print("path============" + file!.path.toString());
      // print("file============"+file!);

      // uploadFilePhaseOneDio();
    }
    if (file!.path == null) {}
  }

  uploadFile(File? uploadedfile, String filedName) async {
    // String filename = path.basename(file!.path);

    print(
        "---------------------------PRINTING FILE NAME-------------------------------\n\n\n");
    print(filedName);
    print(
        "\n\n\n------------------------------------------------------------------------");
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        uploadedfile!.path,
        filename: filedName,

        // contentType:  MediaType("image", "jpg"), //add this
      ),
      'group_id': widget.gpId,
    });

    var res =
        await CallApi().authenticatedUploadRequest(formData, 'upload_file');
    if (res != null) {
      try {
        // print("------------------------PRINTING FILE STATUS CODE-------------------------\n\n\n");
        // print(res.statusCode);
        // print("\n\n\n------------------------------------------------------------------------");
        print(
            "------------------------XXXXXXXXXXXXXXXX-------------------------\n\n\n");

        if (res!.body == null) {
          print('RESPONSE is NULL');
        } else {
          print('RESPONSE is NOT ULL');
        }

        print(
            "------------------------XXXXXXXXXXXXXXXXX-------------------------\n\n\n");

        var body = json.decode(res!.body);

        print(
            "------------------------PRINTING FILE >BODY RESPONSE-------------------------\n\n\n");
        print(body);
        print(
            "\n\n\n------------------------------------------------------------------------");

        if (res.statusCode == 200) {
          showSnack(context, 'File Uploaded Successfully');

          setState(() {});
        } else if (res.statusCode == 400) {
          print('hhh');
          // setState(() {
          //   _isLoading = false;
          //   _not_found = true;
          // });
        } else {}
      } catch (e) {
        print(e);
      }
    } else {
      // setState(() {
      //   _isLoading = false;
      //   // _not_found = true;
      // });
      // showSnack(context, 'No Network!');
      print(
          "------------------------PRINTING FILE STATUS CODE-------------------------\n\n\n");
      print(res.statusCode);
      print("\n\n\n------------------------------------------------------------------------");
    }
  }
}
