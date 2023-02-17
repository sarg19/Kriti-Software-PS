import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/popups/editshopkeeperprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kriti/screens/choicescreen.dart';
import "../database.dart";
import 'dart:async';

class StationaryHomePage extends StatefulWidget {
  const StationaryHomePage({Key? key}) : super(key: key);

  @override
  State<StationaryHomePage> createState() => _StationaryHomePage();
}

class _StationaryHomePage extends State<StationaryHomePage> {
  String email="";
  String username="";
  String shopname="";
  String upiid="";
  num Phone=123456789;
  var selected=0;
  var size, height, width;
  late Timer timer;
  late Databases db;
  initialise() {
    db = Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    initialise();
    db.retrieve_shop_info('stationary',FirebaseAuth.instance.currentUser?.uid).then((value){
      if(!mounted)return;
      setState(() {
        upiid=value['UPI_id'];
        username=value['UserName'];
        shopname=value['ShopName'];
        email=value['Email'];
        Phone=value['Number'];
      });
    });
    timer=Timer.periodic(Duration(milliseconds: 100), (timer) {
      Reload();
    });
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                children: [
                  SizedBox(height: 20.h,),

                  Center(child: Text(shopname,textAlign:TextAlign.center,style:TextStyle(fontSize: 37.sp,))),
                  Text("Now closed",textAlign: TextAlign.left,style: TextStyle(fontSize: 20,color: Color.fromRGBO(
                      114, 114, 114, 1.0)),),
                  SizedBox(height: 45.h,),
                  Text(email,style: TextStyle(fontSize: 22.sp),),
                  SizedBox(height: 25.h,),
                  Text(username,style: TextStyle(fontSize: 22.sp),),
                  SizedBox(height: 20.h,),
                  Text(Phone.toString(),style: TextStyle(fontSize: 22.sp),),
                  SizedBox(height: 25.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: StadiumBorder(),
                            primary: Color.fromRGBO(188, 157, 255, 1),
                            onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 16.sp,
                          ),
                        ),
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (context) =>  ShowPopUp(
                              widgetcontent: ShopkeeperEditProfile(upiid: upiid,number: Phone,username: username,shopname: shopname,shoptype: 'stationary'),
                            ),
                          );
                        },
                      ),
                      Container(
                        width: 110.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: StadiumBorder(),
                              primary: Color.fromRGBO(188, 157, 255, 1),
                              onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                          ),
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 16.sp,
                            ),
                          ),
                          onPressed: (){
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const ChoiceScreen()),
                                    (Route<dynamic> route) => false);
                          },
                        ),
                      ),
                    ],
                  )
                ],


              ),
            ),
          ),

        ),
      ],
    );
  }
  Future<void> Reload() async {
    db.retrieve_menu(FirebaseAuth.instance.currentUser?.uid,'stationary').then((value){
      if(!mounted){
        timer.cancel();
        return;
      }
      setState((){
        shopname=value['ShopName'];
        username=value['UserName'];
        Phone=value['Number'];
        upiid=value['UPI_id'];
        email=value['Email'];

      });
    });
  }
}

