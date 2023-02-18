import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/screens/choicescreen.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/popups/editshopkeeperprofile.dart';
import '../database.dart';

class ShopkeeperProfile extends StatefulWidget {
  final String email;
  final String username;
  final String shopname;
  final num phone;
  final num rating;
  final String shoptype;
  ShopkeeperProfile({Key? key,this.email="S23004xxx",this.username='Abxshk Sjxhsu',this.phone=1234567890,this.rating=0,this.shopname="Kapili Canteen",required this.shoptype}) : super(key: key);

  @override
  State<ShopkeeperProfile> createState() => _ShopkeeperProfileState();
}

class _ShopkeeperProfileState extends State<ShopkeeperProfile> {
  late Timer timer;
  late Databases db;
  String email="";
  String username="";
  String shopname="";
  String upiid='';
  num Phone=123456789;
  num _currentStar = 4;
  initialise() {
    db = Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    initialise();
    setState((){
      email=widget.email;
      username=widget.username;
      shopname=widget.shopname;
      Phone=widget.phone;
      _currentStar=widget.rating;
    });
    timer=Timer.periodic(const Duration(milliseconds: 100), (timer) {
      Reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
              height: widget.shoptype=="stationary"|| widget.shoptype=="grocery"|| widget.shoptype=="stationary"? 290.h:396.h,
              width: 304.w,
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
                          padding: EdgeInsets.only(left: 8.0.w),
                          child: IconButton(
                            icon: const ImageIcon(
                                AssetImage('assets/icons/back.png')),
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
                          padding: EdgeInsets.only(right: 28.0.w),
                          child: const ImageIcon(
                            AssetImage('assets/icons/person.png'),
                            // color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0.h, bottom: 2.0.h),
                          child: Text(email,
                              style: TextStyle(
                                fontSize: 20.sp,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 22.0.w, top: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.0.h),
                            child: Text(username,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20.sp)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0.h, bottom: 10.0.h),
                            child: Text(shopname,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color.fromRGBO(114, 114, 114, 1.0))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0.h),
                            child: Text(Phone.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20.sp)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 18.0.w, right: 18.0.w,top: 12.h,bottom: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(188, 157, 255, 1.0)),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>  ShowPopUp(
                                    widgetcontent: ShopkeeperEditProfile(shoptype: widget.shoptype,shopname: shopname,username: username,number: Phone,upiid: upiid),
                                  ),
                                );
                              },
                              child: const Text('Edit Profile')),
                          ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
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
                    widget.shoptype=="stationary"|| widget.shoptype=="grocery"|| widget.shoptype=="stationary"?SizedBox():
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Ratings',
                          style: TextStyle(fontSize: 24.sp),
                        )
                      ],
                    ),
                    widget.shoptype=="stationary"|| widget.shoptype=="grocery"|| widget.shoptype=="stationary"?SizedBox():
                    Padding(
                      padding: EdgeInsets.only(top: 10.0.h),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(_currentStar < 1 ? Icons.star_border_rounded : Icons.star_rate_rounded , size: 35.sp),
                            Icon(_currentStar < 2 ? Icons.star_border_rounded : Icons.star_rate_rounded , size: 35.sp),
                            Icon(_currentStar < 3 ? Icons.star_border_rounded : Icons.star_rate_rounded , size: 35.sp),
                            Icon(_currentStar < 4 ? Icons.star_border_rounded : Icons.star_rate_rounded , size: 35.sp),
                            Icon(_currentStar < 5 ? Icons.star_border_rounded : Icons.star_rate_rounded , size: 35.sp),
                          ]
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
    db.retrieve_shop_info(widget.shoptype,FirebaseAuth.instance.currentUser?.uid).then((value){
      if(!mounted){
        return;
      }
      setState((){
        upiid=value['UPI_id'];
        username=value['UserName'];
        _currentStar=3;
        shopname=value['ShopName'];
        email=value['Email'];
        Phone=value['Number'];
      });
    });
  }
}
