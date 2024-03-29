import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/database.dart';
import 'package:kriti/widgets/textfield.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'skloginsheet.dart';

class SkSignupSheet extends StatefulWidget {
  const SkSignupSheet({Key? key}) : super(key: key);

  @override
  State<SkSignupSheet> createState() => _SkSignupSheetState();
}

class _SkSignupSheetState extends State<SkSignupSheet> {
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _nameError = "";
  String _ownerNameError = "";
  String _emailError = "";
  String _phoneError = "";
  String _upiError = "";
  String _passwordError = "";
  String _confirmError = "";
  String _regionError = "";
  String _shopTypeError = "";
  int region = 0;
  int shopType = 0;
  String collection_name = "";

  String? dropdownvalue;

  late Databases db;

  initialise() {
    db = Databases();
    db.initialise();
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  String get_collection() {
    if (shopType == 1) {
      if (region == 1) {
        return "food-canteen";
      } else if (region == 2) {
        return "food-foodcourt";
      } else if (region == 3) {
        return "food-marketcomplex";
      } else if (region == 4) {
        return "food-khokha";
      }
    } else if (shopType == 2) {
      return "stationary";
    } else if (shopType == 3) {
      return "grocery";
    } else {
      return "miscellaneous";
    }
    return "";
  }

  Future<void> signup() async {
    String name = _shopNameController.text;
    String ownerName = _ownerNameController.text;
    String email = _emailController.text;
    String upi = _upiController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;
    String confirm = _confirmPasswordController.text;

    if (name.isEmpty) {
      setState(() {
        _nameError = " Shop name is required.";
      });
      return;
    } else {
      setState(() {
        _nameError = "";
      });
    }
    if (ownerName.isEmpty) {
      setState(() {
        _ownerNameError = "Owner's name is required.";
      });
      return;
    } else {
      setState(() {
        _ownerNameError = "";
      });
    }
    if (email.isEmpty) {
      setState(() {
        _emailError = "Email is required.";
      });
      return;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      setState(() {
        _emailError = "Enter valid email";
      });
      return;
    } else {
      setState(() {
        _emailError = "";
      });
    }
    if (phone.isEmpty) {
      setState(() {
        _phoneError = "Phone number is required.";
      });
      return;
    } else if (phone.length != 10) {
      setState(() {
        _phoneError = "Enter valid phone number";
      });
      return;
    } else {
      setState(() {
        _phoneError = "";
      });
    }
    if (upi.isEmpty) {
      setState(() {
        _upiError = "UPI ID is required.";
      });
      return;
    } else {
      setState(() {
        _upiError = "";
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
      setState(() {
        _passwordError = "";
        _confirmError = "";
      });
    }
    if (region == 0 && shopType == 1) {
      setState(() {
        _regionError = "You must select a region.";
      });
      return;
    } else {
      setState(() {
        _regionError = "";
      });
    }
    if (shopType == 0) {
      setState(() {
        _shopTypeError = "Select the type of your shop.";
      });
      return;
    } else {
      setState(() {
        _shopTypeError = "";
      });
    }
    try {
      collection_name = get_collection();
      print(collection_name);
      FocusManager.instance.primaryFocus?.unfocus();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        value.user?.updateDisplayName(collection_name.toString()).then((value) {
          FirebaseAuth.instance.currentUser?.reload().then((value) {
            print(FirebaseAuth.instance.currentUser);
            print(FirebaseAuth.instance.currentUser?.displayName);
          });
        });
        db.create_shop_user(FirebaseAuth.instance.currentUser!.uid,
            num.tryParse(phone), email, name, upi, ownerName, collection_name);
      });
      if (!mounted) return;
      FirebaseAuth.instance.signOut();
      sendmail("knowshopkapili@gmail.com", "Verification of account",
          "Verify the following account \nShop Name: $name\nOwner Name: $ownerName\n Email: $email\n Phone Number: $phone\n UPI ID: $upi\n Type of shop: $collection_name");
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "We've received your request. Wait for your verification.")));
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        setState(() {
          _passwordError = "Password too weak.";
        });
      } else if (e.code == "email-already-in-use") {
        setState(() {
          _emailError = "Email already registered.";
        });
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Some error occurred")));
    }
  }

  Future<String> sendmail(String email, String subject, String body) async {
    String username = 'knowshopkapili@gmail.com';
    String password = 'kcihnoydluldsgcm';
    final smtpServer = gmail(username, password);
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                color: Colors.black.withOpacity(0.15)),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15.h),
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
                  CustomTextField(
                    controller: _shopNameController,
                    labelText: "Shop Name",
                    hintText: "",
                    inputType: TextInputType.text,
                    errorText: _nameError,
                  ),
                  CustomTextField(
                    controller: _ownerNameController,
                    labelText: "Owner's Name",
                    hintText: "",
                    inputType: TextInputType.text,
                    errorText: _ownerNameError,
                  ),
                  CustomTextField(
                    controller: _emailController,
                    labelText: "Email",
                    hintText: "",
                    inputType: TextInputType.emailAddress,
                    errorText: _emailError,
                  ),
                  CustomTextField(
                    controller: _phoneController,
                    labelText: "Phone number",
                    hintText: "",
                    inputType: TextInputType.phone,
                    errorText: _phoneError,
                  ),
                  CustomTextField(
                    controller: _upiController,
                    labelText: "UPI ID",
                    hintText: "",
                    inputType: TextInputType.text,
                    errorText: _upiError,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    labelText: "Password",
                    hintText: "",
                    inputType: TextInputType.text,
                    obscureText: true,
                    errorText: _passwordError,
                  ),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    labelText: "Confirm Password",
                    hintText: "",
                    inputType: TextInputType.text,
                    obscureText: true,
                    errorText: _confirmError,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: Text(
                        'Type of shop',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _shopTypeError == ""
                      ? const SizedBox(
                          height: 0,
                        )
                      : Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60.w),
                            child: Text(
                              _shopTypeError,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                  // const SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Food',
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                        IconButton(
                          iconSize: 13.sp,
                          onPressed: () {
                            setState(() {
                              shopType = 1;
                            });
                          },
                          icon: shopType == 1
                              ? Image.asset('assets/icons/radiofilled.png')
                              : Image.asset('assets/icons/radio.png'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Stationary',
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                        IconButton(
                          iconSize: 13.sp,
                          onPressed: () {
                            setState(() {
                              shopType = 2;
                            });
                          },
                          icon: shopType == 2
                              ? Image.asset('assets/icons/radiofilled.png')
                              : Image.asset('assets/icons/radio.png'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Juice Center',
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                        IconButton(
                          iconSize: 13.sp,
                          onPressed: () {
                            setState(() {
                              shopType = 3;
                            });
                          },
                          icon: shopType == 3
                              ? Image.asset('assets/icons/radiofilled.png')
                              : Image.asset('assets/icons/radio.png'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Miscellaneous',
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                        IconButton(
                          iconSize: 13.sp,
                          onPressed: () {
                            setState(() {
                              shopType = 4;
                            });
                          },
                          icon: shopType == 4
                              ? Image.asset('assets/icons/radiofilled.png')
                              : Image.asset('assets/icons/radio.png'),
                        ),
                      ],
                    ),
                  ),
                  shopType == 1
                      ? Column(children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 60.w),
                              child: Text(
                                'Select Region',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          _regionError == ""
                              ? const SizedBox(
                                  height: 0,
                                )
                              : Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 60.w),
                                    child: Text(
                                      _regionError,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ),
                          // const SizedBox(height: 5,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Canteen',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                                IconButton(
                                  iconSize: 13.sp,
                                  onPressed: () {
                                    setState(() {
                                      region = 1;
                                    });
                                  },
                                  icon: region == 1
                                      ? Image.asset(
                                          'assets/icons/radiofilled.png')
                                      : Image.asset('assets/icons/radio.png'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Food Court',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                                IconButton(
                                  iconSize: 13.sp,
                                  onPressed: () {
                                    setState(() {
                                      region = 2;
                                    });
                                  },
                                  icon: region == 2
                                      ? Image.asset(
                                          'assets/icons/radiofilled.png')
                                      : Image.asset('assets/icons/radio.png'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Market Complex',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                                IconButton(
                                  iconSize: 13.sp,
                                  onPressed: () {
                                    setState(() {
                                      region = 3;
                                    });
                                  },
                                  icon: region == 3
                                      ? Image.asset(
                                          'assets/icons/radiofilled.png')
                                      : Image.asset('assets/icons/radio.png'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Khokha',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                                IconButton(
                                  iconSize: 13.sp,
                                  onPressed: () {
                                    setState(() {
                                      region = 4;
                                    });
                                  },
                                  icon: region == 4
                                      ? Image.asset(
                                          'assets/icons/radiofilled.png')
                                      : Image.asset('assets/icons/radio.png'),
                                ),
                              ],
                            ),
                          ),
                        ])
                      : const SizedBox(
                          height: 0,
                        ),
                  ElevatedButton(
                    onPressed: () {
                      signup();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFBC9DFF)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                        )),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontWeight: FontWeight.w600))),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Divider(
                    thickness: 2,
                    indent: (width - 150) / 2,
                    endIndent: (width - 150) / 2,
                    color: Colors.white,
                    // height: 150,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Already have an account? ',
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp)),
                      TextSpan(
                          text: 'login',
                          style:
                              TextStyle(color: Colors.black, fontSize: 15.sp),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pop();
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => const SkLoginSheet(),
                                backgroundColor: Colors.transparent,
                                barrierColor: Colors.transparent,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                )),
                                isScrollControlled: true,
                              );
                            })
                    ]),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
