import 'package:flutter/material.dart';
import 'package:kimbweta_app/constants/constants.dart';
import 'package:kimbweta_app/screens/screen_tabs.dart';
import '../components/our_button_round.dart';
import '../components/our_text_field.dart';


class SignUpScreen extends StatefulWidget {
  static String id = 'signUp';

  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Container(
          width: double.infinity,

          ///For background gardient
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

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ///Text field for userName
              OurTextField(
                hintText: 'User Name',
                icon: const Icon(Icons.person_2, color: kMainWhiteColor,
                ),
              ),
              const SizedBox(height: 20,),

              ///Text field for email
              OurTextField(
                hintText: 'email',
                icon: const Icon(Icons.email_sharp, color: kMainWhiteColor,
                ),
              ),

              const SizedBox(height: 20,),

              ///Text field for password
              OurTextField(
                hintText: 'Create Password',
                icon: const Icon(Icons.lock_outline, color: kMainWhiteColor,
                ),
              ),

              const SizedBox(height: 20,),

              ///Text field for confirm password
              OurTextField(
                hintText: 'Confirm Password',
                icon: const Icon(Icons.lock_outline, color: kMainWhiteColor,
                ),
              ),

              const SizedBox(height: 20,),

              ///Button For registering
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ButtonRound(
                  onPressed: (){
                    Navigator.pushNamed(context, ScreenTabs.id);

                  },
                  btnText: "Sign Up",

                ),
              ),



              const SizedBox(height: 25.0,),

              ///Have an account? button
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Text("Have an account? Sign In",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
