import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kriti/bottomsheets/loginsheet.dart';
import 'package:kriti/widgets/textfield.dart';

class SignUpSheet extends StatefulWidget {
  const SignUpSheet({Key? key}) : super(key: key);

  @override
  State<SignUpSheet> createState() => _SignUpSheetState();
}

class _SignUpSheetState extends State<SignUpSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _hostelController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              color: Colors.black.withOpacity(0.15)
          ),
          width: MediaQuery.of(context).size.width,
          height: 650.0,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                CustomTextField(controller: _nameController, labelText: "Name", hintText: "", inputType: TextInputType.text),
                CustomTextField(controller: _emailController, labelText: "Email", hintText: "", inputType: TextInputType.emailAddress),
                CustomTextField(controller: _hostelController, labelText: "Hostel/Quarter", hintText: "", inputType: TextInputType.text),
                CustomTextField(controller: _phoneController, labelText: "Phone number", hintText: "", inputType: TextInputType.phone),
                CustomTextField(controller: _passwordController, labelText: "Password", hintText: "", inputType: TextInputType.text, obscureText: true,),
                CustomTextField(controller: _confirmPasswordController, labelText: "Confirm Password", hintText: "", inputType: TextInputType.text, obscureText: true,),
                ElevatedButton(
                  onPressed: () {},
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
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Divider(
                  thickness: 2,
                  indent: (width-150)/2,
                  endIndent: (width-150)/2,
                  color: Colors.white,
                  // height: 150,
                ),
                const SizedBox(height: 15,),
                RichText(
                  text: TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                                color: Colors.white
                            )
                        ),
                        TextSpan(
                            text: 'login',
                            style: const TextStyle(
                              color: Colors.black,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
