import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kimbweta_app/api/api.dart';
import 'package:kimbweta_app/screens/authentication_screens/sign_in_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/snackbar.dart';
import '../../constants/constants.dart';

class MemberUploadedFilesScreen extends StatefulWidget {
  final String? id, name, code, description, createdAt;

  const MemberUploadedFilesScreen({super.key,
    this.id,
    this.name,
    this.code,
    this.description,
    this.createdAt,
  });

  @override
  State<MemberUploadedFilesScreen> createState() => _MemberUploadedFilesScreenState();
}

class _MemberUploadedFilesScreenState extends State<MemberUploadedFilesScreen> {
  var userData, next;
  List<GroupDocument_Item>? group_document_data;
  // List<JoinGroup_Item>? join_group_data;

  @override
  void initState() {
    checkLoginStatus();
    _getUserInfo();

    super.initState();
  }


  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.pushNamed(context, SignInScreen.id);
    }
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
    print(userData);
    fetchDocumentData();
  }

  fetchDocumentData() async {
    // var customer = userData['id'].toString();
    String url = 'group_files/' + widget.id!;
    // if (next != null) {
    //   url = url_format(next);
    // }
    var res = await CallApi().authenticatedGetRequest(url, context: context);

    print(res);
    if (res != null) {
      var body = json.decode(res.body);
      print("-----------------------------------------");
      print(body);
      var group_documentItensJson = body;
      List<GroupDocument_Item> _group_document_items = [];
      if (next != null) {
        _group_document_items = group_document_data!;
      }

      for (var f in group_documentItensJson) {
        GroupDocument_Item group_document_items = GroupDocument_Item(
          f['id'].toString(),
          f['book'].toString().replaceAll('uploaded/', '').replaceAll('_', ' '),
          f['file'].toString(),
        );
        _group_document_items.add(group_document_items);
      }
      print(_group_document_items.length);
      // setState(() {
      //   loading = false;
      // });

      setState(() {
        group_document_data = _group_document_items;
      });
    } else {
      showSnack(context, 'No network');
      return [];
    }
  }

  void _view_document_API() async {
    var data = {
      // 'username': userEmailController.text,
      // 'password': userPasswordController.text,
    };

    print(data);

    var res = await CallApi().authenticatedPostRequest(data, 'auth/login');
    if (res == null) {
      // setState(() {
      //   _isLoading = false;
      //   // _not_found = true;
      // });
      // showSnack(context, 'No Network!');
    } else {
      var body = json.decode(res!.body);
      print(body);

      if (res.statusCode == 200) {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else if (res.statusCode == 400) {
        print('hhh');
      } else {}
    }
  }

  Future<void> downloadFile(String url, String savePath) async {
    print(savePath);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final file = File(savePath);
      await file.writeAsBytes(response.bodyBytes);
      print('File downloaded successfully');
    } else {
      print('Failed to download file. Error code: ${response.statusCode}');
    }
  }

  bool isDowloaded = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          elevation: 0,
          title: const Text(
            'Uploaded Files',
            style: TextStyle(),
          ),

          actions: <Widget>[
            PopupMenuButton<int>(
              // onSelected: (item) => onSelected(context, item),
                icon: const Icon(
                  Icons.more_vert,
                  // color: Colors.black,
                ),
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 0,
                    child: Text(
                      'Upload File',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      'View All Document',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ])
          ]),

      body: SafeArea(
          child: Column(
            children: [
              Expanded(child: my_document_Component()),
            ],
          )),
    );
  }

  my_document_Component() {
    if (group_document_data == null) {
      return const Center(
        child: Text('No Network or Connection...'),
      );
    } else if (group_document_data != null &&
        group_document_data!.isEmpty) {

      return const Center(
        child: Text('No Data or No Group yet...'),
      );
    } else {

      return ListView.builder(
          itemCount: group_document_data!.length,
          itemBuilder: (context, index){

            return Card(
              // color: Colors.transparent,
              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              elevation: 1,
              child: InkWell(
                child: ListTile(

                  title: Text(
                    group_document_data![index].name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),


                  leading: Image.asset('images/file.png'),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.download,
                      color: kMainThemeAppColor,
                    ),
                    onPressed: () async {
                      // String fileUrl =
                      //     await CallApi.media_url + group_document_data![index].name;
                      // String filename = group_document_data![index].name.split("/")[1];
                      // String savePath =
                      //     await getExternalStoragePath() + '/$filename';


                      // _download(context, fileUrl, savePath);


                     int unStringId = int.parse(group_document_data![index].id);
                     print('ID DATA TYPE>>>  ${unStringId.runtimeType}');
                      _download(context, unStringId, group_document_data![index].name);

                      setState(() {
                        isDowloaded = true;
                      });

                    },
                  )
                ),
              ),
            );

          });
    }
  }

  Future<String> getExternalStoragePath() async {
    final directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  _download(BuildContext context, int fileId, String name) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            // title: const Text('Join Group'),
            content: Column(
              children: [
                // _contentServices(context),

                const SizedBox(
                  height: 30,
                ),

                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        elevation: 0,
                        color: const Color(0xFF44B6AF),
                        height: 50,
                        // minWidth: 500,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () async {
                         print('NAME:::::: $name');
                          String fileName = name;
                          String savePath = await getSavePath(fileName);
                          _downFileAPI(fileId, savePath);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Download',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: MaterialButton(
                        elevation: 0,
                        color: const Color(0xFF44B6AF),
                        height: 50,
                        // minWidth: 500,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () {
                          // _add_client_API();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Dont',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _downFileAPI(int id, String savePath) async{
    var res = await CallApi().authenticatedDownloadRequest('download-file/${id}');

    try{
      if (res.statusCode == 200) {
        // Create the file and write the response content to it
        File file = File(savePath);
        await file.writeAsBytes(res.bodyBytes);
        print('File downloaded and saved successfully!');
      } else {
        print('Failed to download file. Status code: ${res.statusCode}');
      }
    } catch(e) {
      print(' ------TRY CATCH ERRR---------\n\n\n ${e} \n\n\n----------------------');
    }
  }

  Future<String> getSavePath(String fileName) async {
    Directory? appDir;
    if (Platform.isAndroid) {
      appDir = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      appDir = await getApplicationDocumentsDirectory();
    } else {
      throw Exception('Unsupported platform');
    }

    String savePath = '${appDir!.path}/$fileName';
    return savePath;
  }

}

class GroupDocument_Item {
  final String id, name, file;

  GroupDocument_Item(
      this.id,
      this.name,
      this.file,
      );
}
