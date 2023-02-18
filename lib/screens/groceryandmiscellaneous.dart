import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/popups/editshopkeeperprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kriti/screens/choicescreen.dart';
import 'package:kriti/popups/shopkeeperProfilePopup.dart';
import 'dart:async';
import '../database.dart';

class groceryandmiscellaneous extends StatefulWidget {
  final String coltype;

  const groceryandmiscellaneous({Key? key,required this.coltype}) : super(key: key);

  @override
  State<groceryandmiscellaneous> createState() => _groceryandmiscellaneous();
}

class _groceryandmiscellaneous extends State<groceryandmiscellaneous> {
  String email="";
  String username="";
  String shopname="";
  String upiid="";
  num Phone=123456789;
  num _currentStar = 4;
  late Databases db;
  late Timer timer;
  bool _isopen=true;
  String open="Close";
  var selected=0;
  var size, height, width;
  initialise(){
    db=Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    initialise();
    print(FirebaseAuth.instance.currentUser?.displayName);
    db.retrieve_shop_info(FirebaseAuth.instance.currentUser?.displayName,FirebaseAuth.instance.currentUser?.uid).then((value){
      if(!mounted)return;
      setState(() {
        upiid=value['UPI_id'];
        username=value['UserName'];
        _currentStar=3;
        shopname=value['ShopName'];
        email=value['Email'];
        Phone=value['Number'];
        _isopen=value['open']==1?true:false;
        open=value['open']==1?"Open":"Close";
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
                  db.shopToggle(FirebaseAuth.instance.currentUser?.uid, FirebaseAuth.instance.currentUser?.displayName);
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
                    builder: (context) => ShowPopUp(
                      widgetcontent: ShopkeeperProfile(shoptype: widget.coltype,username: username,phone: Phone,rating: _currentStar,shopname: shopname,email: email),
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

                  Center(child: Text(shopname,textAlign:TextAlign.center,style:TextStyle(fontSize: 37.sp,))),
                  Text("Now "+open,textAlign: TextAlign.left,style: TextStyle(fontSize: 20,color: Color.fromRGBO(
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
                            builder: (context) => ShowPopUp(
                              widgetcontent: ShopkeeperEditProfile(shoptype: widget.coltype,shopname: shopname,username: username,number: Phone,upiid: upiid),
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
    if(!mounted){
      return;
    }
    db.retrieve_shop_info(FirebaseAuth.instance.currentUser?.displayName,FirebaseAuth.instance.currentUser?.uid).then((value){
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
        open=value['open']==1?"Open":"Close";
        _isopen=value['open']==1?true:false;
      });
    });
  }
}

