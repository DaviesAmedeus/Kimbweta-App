import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kimbweta_app/components/our_material_icon_button.dart';
import 'package:kimbweta_app/screens/background_screens/document_view_screen.dart';
import 'package:kimbweta_app/screens/screen_tabs.dart';
import 'package:path_provider/path_provider.dart';
// import '../../components/our_button_round.dart';
import '../../components/button_round.dart';
import '../../components/our_pop_up_menu.dart';
import 'dart:io';
import 'package:kimbweta_app/components/progressHUD.dart';

import '../../constants/constants.dart';


class DiscussionScreen extends StatefulWidget {
  final String? gpId, name, code, description, created_at;

  DiscussionScreen({
    this.gpId,
    this.name,
    this.code,
    this.description,
    this.created_at,
});

  static String id = 'Discussion';

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  var userData;
  var rootid;
  var result;
  var status;

  var fileName;
  File? file;

  // late FilePickerResult result;
  // PlatformFile? pickedFile;

  // bool isApiCallProcess = false;
  // @override
  // Widget build(BuildContext context) {
  //   return ProgressHUD(child: _uiSetup(context),
  //     inAsyncCall: isApiCallProcess,
  //     opacity: 0.3,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name!),

        ///Side Drawer
        actions: const [
          OurPopOutMenu(),
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

                ///It should be active when document/whiteboard have been accessed
                ///Button for picking a file
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: OurMaterialIconButton(
                      icon: const Icon(
                        Icons.file_present, color: kMainWhiteColor,),
                      label: 'Pick A file',
                      onPressed: () {
                        // A f(x) that enable a file to be picked
                        pickAFile();
                        // setState(() {
                        //   Navigator.push(context, MaterialPageRoute(
                        //     builder: (context)=>DocumentViewScreen(
                        //       path: selectedFile,
                        //       // docName:pickedFile!.name
                        //     ),
                        //   ),
                        //   );
                        // });
                      },)),
                const SizedBox(height: 10,),

                ///Button for uploading a file
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: OurMaterialIconButton(
                      icon: const Icon(
                        Icons.upload_file, color: kMainWhiteColor,),
                      label: 'Upload file',
                      onPressed: () {
                        Navigator.pushNamed(context, ScreenTabs.id);
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
    ///My code (They did work perfectly but likely to test efficiency)
    // // Clear the cache directory before picking another file
    //
    // //Here we are picking a file
    // result = (await FilePicker.platform.pickFiles())!;
    // // print('XXXXX>>>>>>${result.files.single.path}<<<<<XXXXX');
    //
    // if (result != null) {
    //   try {
    //     //Here we are storing the adress of picked file into a cache
    //     selectedFile = File(result.files.single.path!);
    //       // print('>>>>>>>>>xxxxxxxx>>>>>>>>>${selectedFile}');
    //
    //   } catch (e) {
    //     print('Error occurred: $e');
    //   }
    //
    // } else {
    //   Navigator.pop(context);
    // }

    ///Michael Michael codes (With my modifications)
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result == null) {
      Navigator.pop(context);
    }
    else {
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

      Navigator.push(context, MaterialPageRoute(
        builder: (context)=>DocumentViewScreen(file: file),
      ),
      );


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
}







