import 'package:flutter/material.dart';
import 'package:kimbweta_app/constants/constants.dart';
import 'package:kimbweta_app/screens/discussion_screen.dart';
import 'package:kimbweta_app/screens/screen_tabs.dart';
import 'package:kimbweta_app/screens/sign_in_screen.dart';
import 'package:kimbweta_app/screens/sign_up_screen.dart';
import 'package:kimbweta_app/screens/welcome_screen.dart';
import 'package:kimbweta_app/screens/whiteboard_screen.dart';

void main() async{
  runApp(KimbwetaApp());
}

class KimbwetaApp extends StatelessWidget {
  const KimbwetaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor: Color(0xFFC41A3B),
      //   primaryColorLight: Color(0xFF1B1F32),
      //
      // ),
      initialRoute: SignInScreen.id,
      theme: ThemeData(
        primarySwatch: kMainThemeAppColor
      ),

      routes: {
        SignInScreen.id: (context)=> const SignInScreen(),
        SignUpScreen.id: (context)=> const SignUpScreen(),
        ScreenTabs.id: (context)=> const ScreenTabs(),
        WelcomeScreen.id: (context)=> WelcomeScreen(),
        WhiteboardScreen.id: (context)=> WhiteboardScreen(),
      },

    );
  }
}








