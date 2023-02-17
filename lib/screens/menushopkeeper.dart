import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kriti/components/additem.dart';
import 'package:kriti/components/edititem.dart';
import 'package:kriti/popups/profilepopup.dart';
import '../components/bottom_nav_bar.dart';
import '../database.dart';
import '../popups/showPopUp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../database.dart';

class shopmenuscreen extends StatefulWidget {
  const shopmenuscreen({Key? key}) : super(key: key);

  @override
  State<shopmenuscreen> createState() => _shopmenuscreenState();
}

class _shopmenuscreenState extends State<shopmenuscreen> {
  var size,
      height,
      width;

  var listlength=0;
  String ShopName="";
  final SearchController=TextEditingController();

  late Databases db;
  Map Menu={};
  late Timer timer;
  initialise(){
    db=Databases();
    db.initialise();
  }
  @override
  void initState(){
    super.initState();
    initialise();
    FirebaseAuth.instance.currentUser?.reload().then((value){
      timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        Reload();
      });
    });


  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Center(
              child: SingleChildScrollView(
                physics:NeverScrollableScrollPhysics(),
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
                            prefixIcon: Icon(Icons.search_outlined , color: Colors.black),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: 'Search...',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      child: Text(
                        ShopName,
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontFamily: 'DM Sans'
                        )
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 550.h,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: listlength,
                        itemBuilder: (context, index) {
                          if(!Menu['Menu'][index]['Name'].toString().toLowerCase().contains(SearchController.text.toLowerCase())){
                            return Container();
                          }
                          return Container(
                            margin: EdgeInsets.only(bottom: 0),
                            child: ShopkeeperMenuCard(
                              name: Menu['Menu'][index]['Name'],
                              price: Menu['Menu'][index]['Price'],
                              availability: Menu['Menu'][index]['Available']==1?"Available":"Unavailable",
                              index: index,
                              Shop_Key: FirebaseAuth.instance.currentUser?.uid,
                              Menu: Menu,
                              Collection: FirebaseAuth.instance.currentUser?.displayName
                            )
                          );
                          // if(Menu['menu'][index]['Available']==1) {
                          //   return Container(
                          //     margin: EdgeInsets.only(bottom: 0),
                          //     child: ShopkeeperMenuCard(
                          //       name: Menu['menu'][index]['Name'],
                          //       price: Menu['menu'][index]['Price'],
                          //     ),
                          //   );
                          // }else{
                          //   return Container();
                          // }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
  }
  Future<void> Reload() async {
    db.retrieve_menu(FirebaseAuth.instance.currentUser?.uid,FirebaseAuth.instance.currentUser?.displayName).then((value){
      if(!mounted) return;
      setState(() {
        Menu=value;
        listlength=Menu['Menu'].length;
        ShopName=Menu['ShopName'];
      });
    });
  }
}

class ShopkeeperMenuCard extends StatelessWidget {
  final name;
  int price;
  final availability;
  int index;
  final Shop_Key;
  Map Menu;
  final Collection;
  ShopkeeperMenuCard({
    this.name = "",
    this.price = 0,
    this.availability="",
    this.index=0,
    this.Shop_Key="",
    required this.Menu,
    this.Collection=""
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        height: 170.h,
        child: Column(
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 249, 240, 1.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )
                ),
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 0, 0),
                height: 90.h,
                width: 280.w,
                child: Stack(
                  children:[
                    Text.rich(
                        TextSpan(
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 20.sp,
                            ),
                            children: [
                              TextSpan(text: name),
                              TextSpan(text: '\n'),
                              TextSpan(text: '\n'),
                              TextSpan(text: "₹ "),
                              TextSpan(text: price.toString()),
                            ]
                        )
                    ),
                    Positioned(
                      top: 0,
                      right: 12.w,
                      child: Container(
                        child: Text(
                          availability,
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 13.sp,
                            color: Color.fromRGBO(72, 72, 72, 1)
                          ),
                        ),
                      ),
                    )
                  ]
                ),
            ),
            Container(
                height: 60.h,
                width: 280.w,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 249, 240, 1.0),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)
                    )
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10.h),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: StadiumBorder(),
                            backgroundColor: Color.fromRGBO(188, 157, 255, 1),
                          ),
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 15,
                            ),
                          ),
                          onPressed: (){
                            showDialog(context: context, builder: (BuildContext context){
                              return ShowPopUp(widgetcontent: EditItem(name: name,price: price,availability: availability,index: index,Shop_Key: Shop_Key,Menu: Menu,Collection: Collection,));
                            });
                          },
                        ),
                      )
                    ]
                )
            )
          ],
        ),
      ),
    );
  }
}