import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/popups/editshopkeeperprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kriti/screens/choicescreen.dart';
import 'package:kriti/popups/shopkeeperProfilePopup.dart';

class groceryandmiscellaneous extends StatefulWidget {
  const groceryandmiscellaneous({Key? key}) : super(key: key);

  @override
  State<groceryandmiscellaneous> createState() => _groceryandmiscellaneous();
}

class _groceryandmiscellaneous extends State<groceryandmiscellaneous> {
  bool _isopen=true;
  var selected=0;
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Stack(
      children: [
        Image.asset(
          'assets/images/bgImage1.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Image(
              height: 45.h,
              width: 45.h,
              image: const AssetImage("assets/images/appLogo.png"),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: (){
                setState(() {
                  _isopen = !_isopen;
                });
              },
              child: Image.asset(
                _isopen ? 'assets/icons/Toggle-on.png' : 'assets/icons/Toggle-off.png',
                height: 50.h,
                width: 63.w,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ShowPopUp(
                      widgetcontent: ShopkeeperProfile(),
                    ),
                  );
                },
                iconSize: 30.h,
                icon: const ImageIcon(
                  AssetImage('assets/icons/person.png'),
                  color: Colors.black,
                ),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                children: [
                  SizedBox(height: 20.h,),

                  Center(child: Text("Kapili Juice",textAlign:TextAlign.center,style:TextStyle(fontSize: 37.sp,))),
                  Text("Now closed",textAlign: TextAlign.left,style: TextStyle(fontSize: 20,color: Color.fromRGBO(
                      114, 114, 114, 1.0)),),
                  SizedBox(height: 45.h,),
                  Text("23004cxcx",style: TextStyle(fontSize: 22.sp),),
                  SizedBox(height: 25.h,),
                  Text("abshhh",style: TextStyle(fontSize: 22.sp),),
                  SizedBox(height: 20.h,),
                  Text("987652xx",style: TextStyle(fontSize: 22.sp),),
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
                            builder: (context) => const ShowPopUp(
                              widgetcontent: ShopkeeperEditProfile(),
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
}

