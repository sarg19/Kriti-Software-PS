import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/popups/editprofilePopup.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/screens/choicescreen.dart';

import '../database.dart';

class Profile extends StatefulWidget {
  final String Name;
  final String Email;
  final num Phone;
  Profile({Key? key,this.Name="User",this.Email="abc@example.com",this.Phone=1234567890}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Timer timer;
  late Databases db;
  String Name="";
  String Email="";
  num Phone=123456789;
  initialise() {
    db = Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    initialise();
    setState((){
      Name=widget.Name;
      Email=widget.Email;
      Phone=widget.Phone;
    });
    timer=Timer.periodic(const Duration(milliseconds: 100), (timer) {
      Reload();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 271.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromRGBO(253, 243, 223, 1.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 8.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0.h),
                  child: IconButton(
                    icon: const ImageIcon(AssetImage('assets/icons/back.png')),
                    onPressed: () => {Navigator.pop(context)},
                  ),
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0.w),
                  child: IconButton(
                    icon:
                        const ImageIcon(AssetImage('assets/icons/person.png')),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.0.w, top: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Name,
                      style: TextStyle(
                        fontSize: 20.sp,
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0.h, bottom: 14.0.h),
                    child: Text(Email,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color.fromRGBO(114, 114, 114, 1.0))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0.h, bottom: 15.0.h),
                    child: Text(Phone.toString(), style: TextStyle(fontSize: 20.sp)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.0.w, right: 18.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(188, 157, 255, 1.0)),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ShowPopUp(
                            widgetcontent: EditProfile(name: Name,email: Email,phone: Phone,),
                          ),
                        );
                      },
                      child: const Text('Edit Profile')),
                  ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(188, 157, 255, 1.0)),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const ChoiceScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text('Log Out'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> Reload() async {
    if(!mounted){
      timer.cancel();
      return;
    }
    db.retrieve_user_info(FirebaseAuth.instance.currentUser?.uid).then((value){
      if(!mounted){
        return;
      }
      setState((){
        Name=value['Name'];
        Email=value['Mail'];
        Phone=value['Phone_Number'];
      });
    });
  }
}
