// import 'package:flutter/material.dart';
// import 'package:kimbweta_app/models/discussion_group.dart';
// import '../constants/constants.dart';
//
//
// class Home2 extends StatelessWidget{
//   static String id = 'home2Screen';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.logout),
//           tooltip: "Log out",
//           onPressed: (){
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: Colors.blueGrey,
//         title: Text('[ ${DiscussionGroup.createdGroups.length} - Groups Created ]',style: const TextStyle(
//             fontFamily: 'Montserrat2',
//             color: kDiscussionDescriptionColor,
//             fontSize: 15,
//             fontWeight: FontWeight.bold
//
//         ),),
//
//       ),
//       backgroundColor: Colors.blueGrey,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.only(top: 2.0),
//               decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.blueGrey,
//                       Colors.black,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20.0),
//                     topRight: Radius.circular(20.0),
//                   )
//               ),
//
//               ///Displays the discussions created
//               child: ListView.builder(
//                 itemCount: DiscussionGroup.createdGroups.length,
//                 itemBuilder:(context, index)=> Card(
//                   color: Colors.transparent,
//                   margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
//                   elevation: 1,
//                   child: InkWell(
//                     onTap: (){
//                       print("HAHHA");
//                     },
//                     child: ListTile(
//                       title: Text(DiscussionGroup.createdGroups[index].groupName.toString(),
//                         style: const TextStyle(
//                           color: kMainWhiteColor,
//                           letterSpacing: 2,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//
//
//                       ),
//                       trailing: IconButton(
//                           icon: const Icon(Icons.delete, color: kMainThemeAppColor,),
//                           onPressed: (){},
//                       ),
//
//                       subtitle: Text('Created On: ${DiscussionGroup.createdGroups[index].createAt.toString()}',
//                         style: const TextStyle(
//                             color: Colors.white24,
//                             fontFamily: 'Montserrat2',
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 1,
//                             fontSize: 9
//                         ),
//                       ),
//
//                     ),
//                   ),
//
//                 ),
//
//
//               ),
//             ),
//           )
//         ],
//       ),
//
//
//
//     );
//   }
// }
//
//
//
