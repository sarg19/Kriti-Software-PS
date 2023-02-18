import 'dart:math';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/bottomsheets/loginsheet.dart';
import 'package:kriti/screens/customertabs.dart';
import 'package:kriti/screens/home.dart';
import 'package:kriti/widgets/textfield.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../database.dart';

class SignUpSheet extends StatefulWidget {
  const SignUpSheet({Key? key}) : super(key: key);

  @override
  State<SignUpSheet> createState() => _SignUpSheetState();
}

class _SignUpSheetState extends State<SignUpSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String _nameError = "";
  String _emailError = "";
  String _phoneError = "";
  String _passwordError = "";
  String _confirmError = "";
  String _otpError = "";
  bool verified = false;
  bool otpsent = false;
  String otp = "";
  String otp2 = "";
  late Databases db;
  initialise(){
    db=Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    initialise();
  }
  Random random = Random();
  String email = "";
  void sendOTP() async {
    email = _emailController.text;
    if (email.isEmpty) {
      setState(() {
        _emailError = "Email is required.";
      });
      return;
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@iitg.ac.in")
        .hasMatch(email)) {
      setState(() {
        _emailError = "Enter valid IITG email";
      });
      return;
    } else {
      setState(() {
        _emailError = "";
      });
    }
    for(var i=0; i<6; i++){
      var temp = random.nextInt(10);
      otp = otp+temp.toString();
    }
    print(otp);
    sendmail(_emailController.text, "Email verification for KnowShop", "Enter the following OTP for verifying your email in KnowShop\n$otp");
    setState(() {
      otp2 = otp;
      otp = "";
    });
  }

  void verifyOTP() async {
    if(_otpController.text==otp2) {
      setState(() {
        verified = true;
        otpsent = true;
      });
    } else {
      setState(() {
        _otpError = "Wrong OTP";
      });
    }
  }

  Future<String> sendmail(String email, String subject, String body) async {
    String username = 'knowshopkapili@gmail.com';
    String password = 'kcihnoydluldsgcm';
    // String password = String.fromEnvironment('name');
    final smtpServer = gmail(username, password);
    // Create our message.
    final message = Message()
      ..from = Address(username, 'KnowShop')
      ..recipients.add(Address(email))
      ..subject = subject
      ..text = body;
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
      return sendReport.toString();
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return "Fail";
    }
  }

  Future<void> signup() async {
    String name = _nameController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;
    String confirm = _confirmPasswordController.text;

    if (name.isEmpty) {
      setState(() {
        _nameError = "Name is required.";
      });
      return;
    } else {
      setState(() {
        _nameError = "";
      });
    }
    if (phone.isEmpty) {
      setState(() {
        _phoneError = "Phone number is required.";
      });
      return;
    } else if (phone.length !=10){
      setState(() {
        _phoneError = "Enter valid phone number";
      });
      return;
    } else if(num.tryParse(phone).runtimeType==null) {
      setState(() {
        _phoneError = "Wrong input in phone";
      });
    }else{
      setState(() {
        _phoneError = "";
      });
    }
    if (password.isEmpty) {
      setState(() {
        _passwordError = "Password can't be empty";
      });
      return;
    } else if (confirm.isEmpty) {
      setState(() {
        _passwordError = "";
        _confirmError = "Password can't be empty";
      });
      return;
    } else if (password != confirm) {
      setState(() {
        _passwordError = "";
        _confirmError = "Passwords don't match.";
      });
      return;
    } else {
      _passwordError = "";
      _confirmError = "";
    }
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password).then((value){
        value.user?.updateDisplayName("users").then((value){
          FirebaseAuth.instance.currentUser?.reload().then((value){
            print(FirebaseAuth.instance.currentUser);
            print(FirebaseAuth.instance.currentUser?.displayName);
          });
        });
            db.create_user(value.user?.uid,email ,name, num.tryParse(phone));
      });
      if (!mounted) return;
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("SignUp successful. Login to proceed.")));
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        setState(() {
          _passwordError = "Password too weak.";
        });
      } else if (e.code == "email-already-in-use") {
        setState(() {
          otpsent = !otpsent;
          verified = !verified;
          _emailError = "Email already registered.";
        });
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Some error occurred")));
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp),
                    ),
                  ),
                  CustomTextField(controller: _nameController, labelText: "Name", hintText: "", inputType: TextInputType.text, errorText: _nameError,),
                  CustomTextField(controller: _emailController, labelText: "Email", hintText: "", inputType: TextInputType.emailAddress, errorText: _emailError, enabled: !otpsent),
                  CustomTextField(controller: _phoneController, labelText: "Phone number", hintText: "", inputType: TextInputType.phone, errorText: _phoneError,),
                  CustomTextField(controller: _passwordController, labelText: "Password", hintText: "", inputType: TextInputType.text, obscureText: true, errorText: _passwordError,),
                  CustomTextField(controller: _confirmPasswordController, labelText: "Confirm Password", hintText: "", inputType: TextInputType.text, obscureText: true, errorText: _confirmError,),
                  Visibility(
                    visible: !verified,
                    child: ElevatedButton(
                      onPressed: () async {
                        sendOTP();
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Send OTP',
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(visible: !verified, child: CustomTextField(controller: _otpController, labelText: "OTP", hintText: "", inputType: TextInputType.number, obscureText: true, errorText: _otpError,)),
                  Visibility(
                    visible: !verified,
                    child: ElevatedButton(
                      onPressed: () {
                        verifyOTP();
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: verified,
                    child: ElevatedButton(
                      onPressed: () {
                        signup();
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h,),
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
                              text: 'Already have an account? ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp
                              )
                          ),
                          TextSpan(
                              text: 'login',
                              style: TextStyle(
                                color: Colors.black,
                                  fontSize: 15.sp
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.of(context).pop();
                                showModalBottomSheet(
                                  context: context, builder: (context) => const LoginSheet(),
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
