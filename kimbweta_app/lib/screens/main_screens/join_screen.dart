import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../components/snackbar.dart';
import '../../constants/constants.dart';
import '../../models/discussion_group.dart';
class JoinScreen extends StatefulWidget {
  const JoinScreen({Key? key}) : super(key: key);

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {

  var userData, next;

  List<JoinGroup_Item>? join_group_data;


  @override
  void initState() {
    _getUserInfo();
    //listenNotifications();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
    print(userData);
    fetchJoinGroupData();
  }


  // void addGroup(String gpName, String? gpDesc) {
  //   int groupID = DiscussionGroup.createdGroups.length + 1;
  //   final group = DiscussionGroup(groupName: gpName, groupDesc: gpDesc, createAt: DateTime.now(), id: groupID );
  //   DiscussionGroup.createdGroups.add(group);
  //   print(DiscussionGroup.createdGroups.length);
  // }
  //
  // void  _deleteItem(int id){
  //
  //   setState(() {
  //     DiscussionGroup.createdGroups.removeAt(id);
  //
  //   });
  //
  //
  //   ScaffoldMessenger.of(context).showSnackBar(
  //       const  SnackBar(
  //         content: Text('Successflul deleted!!'),));
  //   print('>>>>>Item Deleted!!! remained>> ${DiscussionGroup.createdGroups.length}');
  //
  // }
  //
  //
  // TextEditingController _discNameController =TextEditingController();
  // TextEditingController _discDescController =TextEditingController();
  //
  //
  // Future<void> _showDialogForm(BuildContext context, int? id) async {
  //
  //   showDialog(
  //       context:context,
  //       builder: (context)=> AlertDialog(
  //
  //         contentPadding: const EdgeInsets.only(left: 25, right: 25),
  //         title:  Center(
  //           child: Text(id == null ? 'Create Discussion' : 'Remove Discussion?',
  //           style: const TextStyle(color: kMainBlackColor),),),
  //         shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //
  //         content: Container(
  //           width: 450.0,
  //           child: SingleChildScrollView(
  //             child: id == null ? Column(
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: <Widget>[
  //                 const SizedBox(height: 20.0),
  //
  //                 TextField(
  //                   decoration: const InputDecoration(
  //                       border: OutlineInputBorder(),
  //                       hintText: 'Discussion Name'),
  //                   controller: _discNameController,
  //                 ),
  //                 SizedBox(height: 10,),
  //
  //                 TextField(
  //                   decoration: const InputDecoration(
  //                       border: OutlineInputBorder(),
  //                       hintText: 'Discussion Desc'),
  //                   controller: _discDescController,
  //                 ),
  //
  //               ],
  //             ) : Container(),
  //           ),
  //         ),
  //
  //         actions: <Widget>[
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Container(
  //                 width: MediaQuery.of(context).size.width * 0.30,
  //                 child: TextButton(
  //                   onPressed: (){
  //                     Navigator.pop(context);
  //                   },
  //                   child: const Text("CANCEL"),
  //                 ),
  //               ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width * 0.30,
  //                 child: TextButton(
  //                   onPressed: () {
  //
  //                     if(id == null){
  //                       setState(() {
  //                         addGroup(_discNameController.text, _discDescController.text);
  //                       });
  //
  //                     } else{
  //                        _deleteItem(id);
  //                       print('NOTHING');
  //                     }
  //
  //                     _discNameController.text = '';
  //                     _discDescController.text = '';
  //
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text(id == null ? 'CREATE' : 'REMOVE'),
  //                 ),
  //               )
  //             ],
  //           )
  //         ],
  //       )
  //   );
  // }

  fetchJoinGroupData() async {
    // var customer = userData['id'].toString();
    String url = 'joined_group/' + userData['user']['id'].toString();
    // if (next != null) {
    //   url = url_format(next);
    // }
    var res = await CallApi().authenticatedGetRequest(url, context: context);

    print(res);
    if (res != null) {
      var body = json.decode(res.body);
      print(body);
      var join_groupItensJson = body;
      List<JoinGroup_Item> _join_group_items = [];
      if (next != null) {
        _join_group_items = join_group_data!;
      }

      for (var f in join_groupItensJson) {
        JoinGroup_Item join_group_items = JoinGroup_Item(
          f['id'].toString(),
          f['name'].toString(),
          f['code'].toString(),
          f['description'].toString(),
          f['created_at'].toString(),
        );
        _join_group_items.add(join_group_items);
      }
      print('>>>>>>>>>>>>>>HAHAHA>>>>>>>>>>>${_join_group_items.length}');
      // setState(() {
      //   loading = false;
      // });

      setState(() {
        join_group_data = _join_group_items;
      });
    } else {
      showSnack(context, 'No network');
      return [];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          tooltip: "Log out",
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: (join_group_data!.length == 1) ? Text('[ ${join_group_data!.length} - Group Created ]',style: const TextStyle(
            fontFamily: 'Montserrat2',
            color: kDiscussionDescriptionColor,
            fontSize: 15,
            fontWeight: FontWeight.bold

        ),
        )
            : Text('[ ${join_group_data!.length} - Groups Created ]',style: const TextStyle(
            fontFamily: 'Montserrat2',
            color: kDiscussionDescriptionColor,
            fontSize: 15,
            fontWeight: FontWeight.bold

        ),
        )

        ,

      ),
      backgroundColor: Colors.blueGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 2.0),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blueGrey,
                      Colors.black,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )
              ),

              ///Displays the discussions created
              child: join_group_Component(),

              // child: ListView(
              //   children: [
              //     ListTile(
              //       title: const Text('HCI',
              //         style: TextStyle(
              //           color: kMainWhiteColor,
              //           letterSpacing: 2,
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold,
              //
              //         ),
              //         maxLines: 1,
              //         overflow: TextOverflow.ellipsis,
              //
              //
              //       ),
              //       subtitle: const Text('Created On: 23-07-2023',
              //         style: TextStyle(
              //             color: Colors.white24,
              //             fontFamily: 'Montserrat2',
              //             fontWeight: FontWeight.bold,
              //             letterSpacing: 1,
              //             fontSize: 9
              //         ),
              //       ),
              //       trailing: IconButton(
              //           icon: const Icon(Icons.delete, color: kMainThemeAppColor,),
              //
              //           // onPressed: () =>_showDialogForm(context, DiscussionGroup.createdGroups.indexOf(
              //           //     DiscussionGroup.createdGroups[index]))
              //         onPressed: (){},
              //
              //
              //
              //       ),
              //     ),
              //   ],
              // ),
            ),
          )
        ],
      ),

      ///My FBA
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blueGrey,
      //   child: const Icon(Icons.add, color: kMainWhiteColor,),
      //   onPressed: (){
      //
      //     // _showDialogForm(context, null);
      //
      //   },
      // ),

      /// Michael Michael modified FBA
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          // selectFile();
          // _add_Group_Dialog(context);
        },
        label: const Text('Join Group'),
        backgroundColor: kMainThemeAppColor,
      ),


    );
  }

  join_group_Component() {
    print("----------------");
    print(join_group_data!.length);
    if (join_group_data == null) {
      return Center(
        child: Text('No Network or Connection...'),
      );
    } else if (join_group_data != null && join_group_data?.length == 0) {
      // No Data
      return Text('No Data or No Group yet...');
    } else {
      return ListView.builder(
        itemCount:join_group_data!.length,
        itemBuilder:(context, index)=> Card(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          elevation: 1,
          child: InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(
              //     builder: (context)=> DiscussionScreen(
              //         dName:DiscussionGroup.createdGroups[index].groupName.toString())));
            },
            child: ListTile(
              title: Text(join_group_data![index].name,
                style: const TextStyle(
                  color: kMainWhiteColor,
                  letterSpacing: 2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,

                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,


              ),
              subtitle: Text('${join_group_data![index].description}',
                style: const TextStyle(
                    color: Colors.white24,
                    fontFamily: 'Montserrat2',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 9
                ),
              ),

              trailing: Text('00:00'),
              leading: Image.asset('images/group_logo.png'),

            ),
          ),

        ),


      );
    }
  }
}
