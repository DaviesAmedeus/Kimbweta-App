import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Files'),
      ),
      body: FutureBuilder<List<File>>(
        future: getSavedFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<File> savedFiles = snapshot.data!;
            return ListView.builder(
              itemCount: savedFiles.length,
              itemBuilder: (context, index) {
                File file = savedFiles[index];
                return ListTile(
                  title: Text(file.path),
                  // Add additional UI elements as needed
                );
              },
            );
          } else {
            return Center(child: Text('No saved files'));
          }
        },
      ),
    );
  }



  Future<List<File>> getSavedFiles() async {
    Directory? appDir;
    if (Platform.isAndroid) {
      appDir = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      appDir = await getApplicationDocumentsDirectory();
    } else {
      throw Exception('Unsupported platform');
    }

    // Get a list of files in the directory
    List<FileSystemEntity> fileEntities = appDir!.listSync();

    // Filter and return only the saved files (excluding directories)
    List<File> savedFiles = fileEntities
        .where((entity) => entity is File)
        .map((entity) => entity as File)
        .toList();

    return savedFiles;
  }


}








