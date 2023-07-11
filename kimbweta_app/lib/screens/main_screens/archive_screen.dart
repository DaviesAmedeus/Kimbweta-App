import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/constants.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.logout),
          tooltip: "Log out",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Saved Files',
          style: TextStyle(
              fontFamily: 'Montserrat2',
              color: kDiscussionDescriptionColor,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<File>>(
        future: getSavedFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<File> savedFiles = snapshot.data!;
            return ListView.builder(
              itemCount: savedFiles.length,
              itemBuilder: (context, index) {
                File file = savedFiles[index];
                String fileName = file.path.replaceAll('/storage/emulated/0/Android/data/com.example.kimbweta_app/files/', '');
                return Card(
                  color: Colors.transparent,
                  margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                  elevation: 1,
                  child: InkWell(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => AdminDiscussionScreen(
                    //           gpId: my_group_data![reverseIndex].id,
                    //           name: my_group_data![reverseIndex].name,
                    //           code: my_group_data![reverseIndex].code,
                    //           description: my_group_data![reverseIndex].description,
                    //           createdAt: my_group_data![reverseIndex].created_at),
                    //     ),
                    //   );
                    // },
                    child: ListTile(
                        // path.basename(file!.path);
                      title: Text(fileName),

                      leading: Image.asset('images/file.png'),

                    ),
                  ),
                );

                //ANOTHER
                return ListTile(
                  title: Text(file.path),
                  // Add additional UI elements as needed
                );
              },
            );
          } else {
            return const Center(child: Text('No saved files'));
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
















































// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
//
// class ArchiveScreen extends StatefulWidget {
//   const ArchiveScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ArchiveScreen> createState() => _ArchiveScreenState();
// }
//
// class _ArchiveScreenState extends State<ArchiveScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Saved Files'),
//       ),
//       body: FutureBuilder<List<File>>(
//         future: getSavedFiles(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             List<File> savedFiles = snapshot.data!;
//             return ListView.builder(
//               itemCount: savedFiles.length,
//               itemBuilder: (context, index) {
//                 File file = savedFiles[index];
//                 return ListTile(
//                   title: Text(file.path),
//                   // Add additional UI elements as needed
//                 );
//               },
//             );
//           } else {
//             return Center(child: Text('No saved files'));
//           }
//         },
//       ),
//     );
//   }
//
//
//
//   Future<List<File>> getSavedFiles() async {
//     Directory? appDir;
//     if (Platform.isAndroid) {
//       appDir = await getExternalStorageDirectory();
//     } else if (Platform.isIOS) {
//       appDir = await getApplicationDocumentsDirectory();
//     } else {
//       throw Exception('Unsupported platform');
//     }
//
//     // Get a list of files in the directory
//     List<FileSystemEntity> fileEntities = appDir!.listSync();
//
//     // Filter and return only the saved files (excluding directories)
//     List<File> savedFiles = fileEntities
//         .where((entity) => entity is File)
//         .map((entity) => entity as File)
//         .toList();
//
//     return savedFiles;
//   }
//
//
// }
//
//
//
//
//
//
//
//
