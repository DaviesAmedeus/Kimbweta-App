import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kimbweta_app/constants/constants.dart';
import 'package:kimbweta_app/screens/document_view_screen.dart';
import 'package:kimbweta_app/screens/screen_tabs.dart';
import 'package:kimbweta_app/screens/whiteboard_screen.dart';
import '../components/our_button_round.dart';
import '../components/our_pop_up_menu.dart';
import 'dart:io';

import '../components/our_round_button.dart';

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
  PlatformFile? pickedFile;
  bool isLoading= false;

  @override
  Widget build(BuildContext context) {
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
                      pickAFile();
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>DocumentViewScreen(
                              path: selectedFile,
                              docName:pickedFile!.name),
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
                SizedBox(height: 10,),




              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickAFile() async{
    result = (await FilePicker.platform.pickFiles())!;
    if(result == null){
      Navigator.pop(context);
    } else{

      setState(() {
        selectedFile = File(result.files.single.path!);
        print('>>>>>>>>>>>>>>>>>>${selectedFile}');
        pickedFile = result.files.single;



      });



    }

  }
}





