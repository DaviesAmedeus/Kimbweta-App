import 'package:flutter/material.dart';
import 'package:kimbweta_app/screens/join_screen.dart';

import '../constants/constants.dart';
import 'home_screen.dart';

class ScreenTabs extends StatefulWidget {
  static String id = '/tabs';

  const ScreenTabs({super.key});

  @override
  State<ScreenTabs> createState() => _ScreenTabsState();
}

class _ScreenTabsState extends State<ScreenTabs> {
  int _currentIndex = 0;

  final _tabs= [
    const HomeScreen(),
    const JoinScreen(),
    const Center(child: Text('Downloads'),),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:    _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          backgroundColor: Colors.blueGrey,
          currentIndex: _currentIndex,
          showUnselectedLabels: false,

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.connect_without_contact),label: 'Join'),
            BottomNavigationBarItem(icon: Icon(Icons.download_sharp),label: 'Archive'),
          ],


          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
        ),

    ) ;
  }
}




