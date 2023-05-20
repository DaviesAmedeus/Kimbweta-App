import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../background_screens/discussion_screen.dart';
import 'package:kimbweta_app/models/discussion_group.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  void addGroup(String gpName, String? gpDesc) {
    int groupID = DiscussionGroup.createdGroups.length + 1;
    final group = DiscussionGroup(groupName: gpName, groupDesc: gpDesc, createAt: DateTime.now(), id: groupID );
    DiscussionGroup.createdGroups.add(group);
    print(DiscussionGroup.createdGroups.length);
  }

  void  _deleteItem(int id){

    setState(() {
      DiscussionGroup.createdGroups.removeAt(id);

    });


    ScaffoldMessenger.of(context).showSnackBar(
        const  SnackBar(
          content: Text('Successflul deleted!!'),));
    print('>>>>>Item Deleted!!! remained>> ${DiscussionGroup.createdGroups.length}');

  }


  TextEditingController _discNameController =TextEditingController();
  TextEditingController _discDescController =TextEditingController();


  Future<void> _showDialogForm(BuildContext context, int? id) async {

    showDialog(
        context:context,
        builder: (context)=> AlertDialog(

          contentPadding: const EdgeInsets.only(left: 25, right: 25),
          title:  Center(
            child: Text(id == null ? 'Create Discussion' : 'Remove Discussion?',
            style: const TextStyle(color: kMainBlackColor),),),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),

          content: Container(
            width: 450.0,
            child: SingleChildScrollView(
              child: id == null ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 20.0),

                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Discussion Name'),
                    controller: _discNameController,
                  ),
                  SizedBox(height: 10,),

                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Discussion Desc'),
                    controller: _discDescController,
                  ),

                ],
              ) : Container(),
            ),
          ),

          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("CANCEL"),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: TextButton(
                    onPressed: () {

                      if(id == null){
                        setState(() {
                          addGroup(_discNameController.text, _discDescController.text);
                        });

                      } else{
                         _deleteItem(id);
                        print('NOTHING');
                      }

                      _discNameController.text = '';
                      _discDescController.text = '';

                      Navigator.pop(context);
                    },
                    child: Text(id == null ? 'CREATE' : 'REMOVE'),
                  ),
                )
              ],
            )
          ],
        )
    );
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
        title: Text('[ ${DiscussionGroup.createdGroups.length} - Groups Created ]',style: const TextStyle(
            fontFamily: 'Montserrat2',
            color: kDiscussionDescriptionColor,
            fontSize: 15,
            fontWeight: FontWeight.bold

        ),
        ),

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
              child: ListView.builder(
                itemCount:DiscussionGroup.createdGroups.length,
                itemBuilder:(context, index)=> Card(
                  color: Colors.transparent,
                  margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                  elevation: 1,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> DiscussionScreen(
                              dName:DiscussionGroup.createdGroups[index].groupName.toString())));
                    },
                    child: ListTile(
                      title: Text(DiscussionGroup.createdGroups[index].groupName.toString(),
                        style: const TextStyle(
                          color: kMainWhiteColor,
                          letterSpacing: 2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,

                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,


                      ),
                      subtitle: Text('Created On: ${DiscussionGroup.createdGroups[index].createAt.toString()}',
                        style: const TextStyle(
                            color: Colors.white24,
                            fontFamily: 'Montserrat2',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontSize: 9
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: kMainThemeAppColor,),
                        onPressed: () =>_showDialogForm(context, DiscussionGroup.createdGroups.indexOf(
                            DiscussionGroup.createdGroups[index]))



                      ),
                    ),
                  ),

                ),


              ),
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, color: kMainWhiteColor,),
        onPressed: (){

          _showDialogForm(context, null);

        },
      ),


    );
  }
}