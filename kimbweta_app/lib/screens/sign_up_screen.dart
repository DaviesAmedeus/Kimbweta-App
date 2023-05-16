import 'package:flutter/material.dart';
import 'package:kimbweta_app/api/sign_up_and_sign_in_api_service.dart';
import 'package:kimbweta_app/constants/constants.dart';
import 'package:kimbweta_app/models/sign_up_model.dart';
import '../components/our_button_round.dart';
import '../components/our_text_field.dart';
import 'package:kimbweta_app/screens/progressHUD.dart';


class SignUpScreen extends StatefulWidget {
  static String id = 'signUp';

  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  RegisterRequestModel? registerRequestModel;
  late String userName;
  late String email;
  late String _confirmPassword;
  late String password;

  bool isApiCallProcess = false;


  @override
  void initState() {
    super.initState();
    registerRequestModel = RegisterRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Container(
          width: double.infinity,

          ///For background gradient
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
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Form(
              key: globalFormKey,
              child: ListView(
                children: [
                  ///Text field for userName
                  OurTextField(
                    hintText: 'User Name',
                    icon: const Icon(
                      Icons.person_2,
                      color: kMainWhiteColor,
                    ),
                    onChanged: (input) {
                      userName = input!;
                      return null;
                    },
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "Field should not be empty";
                      }

                      if (input.contains("<") ||
                          input.contains(">") ||
                          input.contains("/")) {
                        return "Special characters not required!";
                      }
                    },
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ///Text field for email
                  OurTextField(
                    hintText: 'email',
                    icon: const Icon(
                      Icons.email_sharp,
                      color: kMainWhiteColor,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (input) {
                      email = input!;
                    },
                    validator: (input) {
                      if (input!.isEmpty) {
                        return "Field should not be empty";
                      }

                      if (!input.contains("@")) {
                        return "Email should be valid";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  ///Text field for password
                  OurTextField(
                      hintText: 'Create Password',
                      icon: const Icon(
                        Icons.lock_outline,
                        color: kMainWhiteColor,
                      ),
                      onChanged: (input) {
                        password = input!;
                        return null;
                      },
                      validator: (input) {
                        if (input!.isEmpty) {
                          return "Enter password";
                        }
                        if (input.length < 6) {
                          return "Password should have at least 6 characters";
                        }
                        return null;
                      }),

                  const SizedBox(
                    height: 20,
                  ),

                  ///Text field for confirm password
                  OurTextField(
                      hintText: 'Confirm Password',
                      icon: const Icon(
                        Icons.lock_outline,
                        color: kMainWhiteColor,
                      ),
                      onChanged: (input) {
                        _confirmPassword = input!;
                      },
                      validator: (input) {
                        if (input!.isEmpty) {
                          return "Required password for match";
                        }
                        if (input != password) {
                          return 'Password do not match';
                        }
                        return null;
                      }),

                  const SizedBox(
                    height: 20,
                  ),

                  ///Button For registering
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ButtonRound(
                      onPressed: () {
                        if (validateAndSave()) {
                          _sendRegisterRequest();
                          setState(() {
                            isApiCallProcess = true;
                          });
                          SignupAndSigninAPIService apiService = SignupAndSigninAPIService();
                          apiService.signUp(registerRequestModel!).then((value){

                            setState(() {
                              isApiCallProcess = false;
                            });

                            final snackBar =      SnackBar(
                                  content: Text("user:${userName} created"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            Navigator.pop(context);

                          });
                          print('>>>>>>>>>>>${registerRequestModel!.toJson()}');

                        }
                      },
                      btnText: "Sign Up",
                    ),
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),

                  ///Have an account? button
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Have an account? Sign In",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  ///function that assigns the validated inputs into the registerRequest
  void _sendRegisterRequest() {
    registerRequestModel!.userName = userName;
    registerRequestModel!.email = email;
    registerRequestModel!.password = password;
  }
}
