import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/database.dart';
import 'package:kriti/popups/profilepopup.dart';
import 'package:kriti/popups/shopdetailspopup.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/screens/customertabs.dart';
import 'package:kriti/screens/uploadfilescreen.dart';

class Misc extends StatefulWidget {
  const Misc({Key? key}) : super(key: key);

  @override
  State<Misc> createState() => _MiscState();
}

class _MiscState extends State<Misc> {

  int _currentIndex = 0;
  List<String>_Stationary =['Subhansiri','Kapili','Barak','Umiam','Dhansiri','Lohit','Disang','Dihing','Kameng','Brahma','Manas','Core 1','Core 2','Core 3','Core 4'];
  List<String>_Status=['Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open',];
  String Name='User';
  String Email='abc@example.com';
  int Phone=1234567890;
  List Misc=[];
  int misclength=0;
  late Databases db;
  late Timer timer;
  initialise() {
    db = Databases();
    db.initialise();
    db.retrieve_user_info(FirebaseAuth.instance.currentUser?.uid).then((value){
      setState(() {
        Name=value['Name'];
        Email=value['Mail'];
        Phone=value['Phone_Number'];
      });
    });
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      Reload();
    });
  }
  @override
  void initState() {
    super.initState();
    initialise();
  }
  final SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/bgImage1.png',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Padding(
        padding: EdgeInsets.all(0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Image(
              height: 45.h,
              width: 45.h,
              image: const AssetImage("assets/images/appLogo.png"),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new , color: Colors.black ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>  ShowPopUp(
                      widgetcontent: Profile(Name: Name,Email: Email,Phone: Phone,),
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
          body: Center(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(70.0.w,10.0.h,70.0.w,10.0.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 40.h,
                      child: TextField(
                        controller: SearchController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 7.h, 0, 5.h),
                          prefixIcon: const Icon(Icons.search_outlined , color: Colors.black),
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hintText: 'Search...',
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 588.h,
                    child:ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: misclength,
                      itemBuilder: (BuildContext context, int index)
                      {
                        if(!Misc[index]['Name'].toString().toLowerCase().contains(SearchController.text.toLowerCase())){
                          return Container();
                        }
                        if(Misc[index]['Verified']==0){
                          return Container();
                        }
                        return Padding(
                          padding: EdgeInsets.fromLTRB(45.w, 10.h, 45.w, 10.h),
                          child: GestureDetector(
                            onTap: (){
                              showDialog(context: context, builder: (BuildContext context){
                                return ShowPopUp(widgetcontent: ShopDetails(shop_key: Misc[index]['id'],collection: 'miscellaneous',),);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromRGBO(188, 157, 255, 1.0),
                              ),
                              height: 40.h,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 9.h,bottom: 9.h,left: 14.w),
                                        child: Text(
                                          Misc[index]['Name'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 9.h,bottom: 9.h,right: 14.w),
                                      child: Text(
                                        Misc[index]['open']==1?'Open':'Close',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(219, 202, 255, 1.0),
            selectedItemColor: Colors.black54,
            unselectedItemColor: Colors.black54,
            selectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/home.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 0)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/bag.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 1)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/favorite.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 2)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/cart.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 3)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
            ],
          ),
        ),
      )
    ]);
  }
  Future<void> Reload() async {
    db.getfoodshop('miscellaneous').then((value){
      if(!mounted) {
        return;
      }
      setState((){
        Misc=value;
        misclength=Misc.length;
      });
    });
  }
}
