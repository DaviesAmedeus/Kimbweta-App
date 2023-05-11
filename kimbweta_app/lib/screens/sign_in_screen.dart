import 'package:flutter/material.dart';
import 'package:kimbweta_app/constants/constants.dart';
import 'package:kimbweta_app/screens/screen_tabs.dart';
import 'package:kimbweta_app/screens/sign_up_screen.dart';
import '../components/our_button_round.dart';
import '../components/our_text_field.dart';
import 'home_screen.dart';


class SignInScreen extends StatefulWidget {
  static String id = '/signIn';
   const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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


              ///Text field for email
              OurTextField(
                hintText: 'Email',
                icon: const Icon(Icons.email_sharp, color: kMainWhiteColor,
                ),
              ),
              const SizedBox(height: 20,),

              ///Text field for password
              OurTextField(
                hintText: 'Password',
                icon: const Icon(Icons.lock_outline, color: kMainWhiteColor,
                ),
              ),



              const SizedBox(height: 20,),

              ///sign In button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ButtonRound(
                  onPressed: (){
                    Navigator.pushNamed(context, ScreenTabs.id);

                  },
                  btnText: "Sign In",

                ),
              ),

              const SizedBox(height: 20.0,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: OutlinedButton(

                  onPressed: () {
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [

                        Image(image: AssetImage('images/google_logo.png'), height: 25.0),
                        SizedBox(width: 10.0,),
                        Text('Sign In with Google',
                          style: TextStyle(
                              color: kMainWhiteColor,
                            letterSpacing: 2
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 25.0,),

              ///Dont have an account button
               GestureDetector(
                 onTap: (){
                   Navigator.pushNamed(context, SignUpScreen.id);
                 },
                 child: const Text("Don't have an account? Sign Up",
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


