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
import 'member_uploaded_files_screen.dart';

class MemberDiscussionScreen extends StatefulWidget {
  final String? gpId, name, code, description, createdAt;

  const MemberDiscussionScreen({
    super.key,
    this.gpId,
    this.name,
    this.code,
    this.description,
    this.createdAt,
  });

  @override
  State<MemberDiscussionScreen> createState() => _JoinedDiscussionScreen();
}

class _JoinedDiscussionScreen extends State<MemberDiscussionScreen> {
  var userData, rootid, result, status, fileName;
  File? file;
  bool sharedScreenStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('${widget.name!}'),

        ///Side Drawer
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.file_copy),
                  title: const Text('Files Uploaded'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MemberUploadedFilesScreen(
                            id: widget.gpId,
                            name: widget.name,
                            code: widget.code,
                            description: widget.description,
                            createdAt: widget.createdAt
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
            child: Text(
              'Waiting for connection...',
              style: TextStyle(color: kMainWhiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
