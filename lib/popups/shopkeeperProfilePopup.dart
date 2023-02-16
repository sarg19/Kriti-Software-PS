import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/screens/choicescreen.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/popups/editshopkeeperprofile.dart';

class ShopkeeperProfile extends StatefulWidget {
  const ShopkeeperProfile({Key? key}) : super(key: key);

  @override
  State<ShopkeeperProfile> createState() => _ShopkeeperProfileState();
}

class _ShopkeeperProfileState extends State<ShopkeeperProfile> {

  int _currentStar = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
              height: 396.h,
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
                          'Kapili',
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
                          child: Text('S23004xxx',
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
                            child: Text('Abxshk Sjxhsu',
                                style: TextStyle(fontSize: 20.sp)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0.h, bottom: 10.0.h),
                            child: Text('Kapili Canteen',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color.fromRGBO(114, 114, 114, 1.0))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0.h),
                            child: Text('890824xxx',
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
                                  builder: (context) => const ShowPopUp(
                                    widgetcontent: ShopkeeperEditProfile(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Ratings',
                          style: TextStyle(fontSize: 24.sp),
                        )
                      ],
                    ),
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
}
