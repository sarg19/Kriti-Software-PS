import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/bottomsheets/signupsheet.dart';
import 'package:kriti/popups/changepassword.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/screens/customertabs.dart';
import 'package:kriti/screens/home.dart';
import 'package:kriti/widgets/textfield.dart';

import '../database.dart';

class LoginSheet extends StatefulWidget {
  const LoginSheet({Key? key}) : super(key: key);

  @override
  State<LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends State<LoginSheet> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Databases db;
  late Map user_info;
  initialise(){
    db=Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    initialise();
  }
  String _emailError = "";
  String _passwordError = "";

  Future<void> submit() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    if (email.isEmpty) {
      setState(() {
        _emailError = "Email required.";
      });
      return;
    } else {
      setState(() {
        _emailError = "";
      });
    }
    if (password.isEmpty) {
      setState(() {
        _passwordError = "Password required.";
      });
      return;
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password).then((value){
            // print(value);
            db.retrieve_user_info(value.user?.uid).then((data){
              user_info=data;
              print(user_info);
            });
      });
      if (!mounted) return;
      // if (!FirebaseAuth.instance.currentUser!.emailVerified) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => CustomerTabs(currentIndex: 0)),
              (Route route) => false);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        setState(() {
          _emailError = "Invalid email";
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          _passwordError = "Incorrect password";
        });
      } else {
        setState(() {
          _emailError = e.code;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20
        ),
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                  color: Colors.black.withOpacity(0.15)
              ),
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp),
                    ),
                  ),
                  CustomTextField(controller: _emailController, labelText: "Email", hintText: "", inputType: TextInputType.emailAddress, errorText: _emailError,),
                  CustomTextField(controller: _passwordController, labelText: "Password", hintText: "", inputType: TextInputType.text, obscureText: true, errorText: _passwordError,),
                  // SizedBox(height: 7.h,),
                  Padding(
                    padding: EdgeInsets.only(right: 60.w),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const ShowPopUp(widgetcontent: ChangePassword(),),
                          );
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 7.h,),
                  ElevatedButton(
                    onPressed: () {
                      submit();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xFFBC9DFF)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            )),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontWeight: FontWeight.w600))),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 7.h,),
                  Divider(
                    thickness: 2,
                    indent: (width-150)/2,
                    endIndent: (width-150)/2,
                    color: Colors.white,
                    // height: 150,
                  ),
                  SizedBox(height: 15.h,),
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Don\'t have an account? ',
                              style: TextStyle(
                                  color: Colors.white,
                                fontSize: 15.sp
                              )
                          ),
                          TextSpan(
                              text: 'signup',
                              style: TextStyle(
                                color: Colors.black,
                                  fontSize: 15.sp
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.of(context).pop();
                                showModalBottomSheet(
                                  context: context, builder: (context) => const SignUpSheet(),
                                  backgroundColor: Colors.transparent,
                                  barrierColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20 ),
                                      )
                                  ),
                                  isScrollControlled: true,
                                );
                              }
                          )
                        ]
                    ),
                  ),
                  SizedBox(height: 20.h,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
