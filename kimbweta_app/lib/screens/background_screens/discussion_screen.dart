import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kimbweta_app/screens/background_screens/document_view_screen.dart';
import 'package:kimbweta_app/screens/screen_tabs.dart';
import 'package:path_provider/path_provider.dart';
import '../../components/our_button_round.dart';
import '../../components/our_pop_up_menu.dart';
import 'dart:io';
import 'package:kimbweta_app/components/progressHUD.dart';


class DiscussionScreen extends StatefulWidget {
  String dName;
  DiscussionScreen({super.key, required this.dName});

  static String id = 'Discussion';

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  late FilePickerResult result;
  File selectedFile = File('');
  // PlatformFile? pickedFile;

  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dName),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ButtonRound(
                    onPressed: (){
                      // await clearCacheDirectory();

                      pickAFile();
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>DocumentViewScreen(
                              path: selectedFile,
                              // docName:pickedFile!.name
                          ),
                        ),
                        );
                      });
                    },
                    icon: Icon(Icons.file_present),
                    iconWidth: 10,
                    btnText: "Pick a file",

                  ),
                ),
               const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ButtonRound(
                    onPressed: (){
                      Navigator.pushNamed(context, ScreenTabs.id);
                    },
                    icon: Icon(Icons.upload_file),
                    iconWidth: 5,
                    btnText: "Upload file",

                  ),
                ),





              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Function for picking a file
  void pickAFile() async {
    // Clear the cache directory before picking another file

    //Here we are picking a file
    result = (await FilePicker.platform.pickFiles())!;
    // print('XXXXX>>>>>>${result.files.single.path}<<<<<XXXXX');

    if (result != null) {
      try {
        //Here we are storing the adress of picked file into a cache
        selectedFile = File(result.files.single.path!);
          // print('>>>>>>>>>xxxxxxxx>>>>>>>>>${selectedFile}');

      } catch (e) {
        print('Error occurred: $e');
      }

    } else {
      Navigator.pop(context);
    }
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





