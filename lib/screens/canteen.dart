import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/popups/profilepopup.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/screens/customertabs.dart';
import 'package:kriti/screens/menu.dart';

import '../database.dart';



class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({super.key});

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> with TickerProviderStateMixin {
  late List marketcomplexshop;
  late List khokhashop;
  late List foodcourtshop;
  late List canteenshop;
  int marketcomplexsize=0;
  int khokhasize=0;
  int foodcourtsize=0;
  int canteensize=0;
  late Databases db;
  late Timer timer;
  String Name='User';
  String Email='abc@example.com';
  int Phone=1234567890;
  initialise(){
    db=Databases();
    db.initialise();
    db.retrieve_user_info(FirebaseAuth.instance.currentUser?.uid).then((value){
      setState((){
        Name=value['Name'];
        Email=value['Mail'];
        Phone=value['Phone_Number'];
      });

    });
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      Reload();
    });
    // db.create_food_shop("Aicy7Z7TrkJHVgwxrADB", "food-foodcourt", "Gholap Sarjerao", "sarvesh@gmail.com", "Bajerao since 1947", 1234567890, 'Food Court', 'Food');

  }
  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Stack(
          children:[
            Image.asset(
              'assets/images/bgImage1.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
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
                          padding: const EdgeInsets.fromLTRB(70.0,10.0,70.0,10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            height: 40.h,
                            child: TextField(
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
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 70.h,
                          child: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(65.h),
                              child: TabBar(
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                tabs:
                                [
                                  Container(
                                    alignment: const Alignment(0,-1),
                                    height: 65.h,
                                    width: 65.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromRGBO(188, 157, 255, 1.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: SizedBox.expand(
                                      child: Center(
                                        child: Text(
                                          'Market Complex',
                                          style: TextStyle(
                                            wordSpacing: 3,
                                            fontSize: 13.sp,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: const Alignment(0,-1),
                                    height: 65.h,
                                    width: 65.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromRGBO(188, 157, 255, 1.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: SizedBox.expand(
                                      child: Center(
                                        child: Text(
                                          'Khokha',
                                          style: TextStyle(
                                            wordSpacing: 3,
                                            fontSize: 13.sp,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: const Alignment(0,-1),
                                    height: 65.h,
                                    width: 65.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromRGBO(188, 157, 255, 1.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: SizedBox.expand(
                                      child: Center(
                                        child: Text(
                                          'Food  Court',
                                          style: TextStyle(
                                            wordSpacing: 3,
                                            fontSize: 13.sp,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: const Alignment(0,-1),
                                    height: 65.h,
                                    width: 65.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color.fromRGBO(188, 157, 255, 1.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: SizedBox.expand(
                                      child: Center(
                                        child: Text(
                                          'Canteen',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(
                          height:height*0.571,
                          child: TabBarView(
                            children: [
                              SizedBox(
                                height: 420.h,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: marketcomplexsize+1,
                                  itemBuilder: (BuildContext context, int index)
                                  {
                                    if(index==0)
                                    {
                                      return Column(
                                        children: [
                                          Text(
                                            'Trending in Market Complex',
                                            style: TextStyle(
                                              fontSize: 24.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width:width*0.89,
                                            height : 150.h,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 5,
                                              itemBuilder: (BuildContext context,int ind)
                                              {
                                                return Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Container(
                                                    height: 141.h,
                                                    width: 150.w
                                                    ,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: const Color.fromRGBO(188, 157, 255, 1.0),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else
                                    {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: const Color.fromRGBO(188, 157, 255, 1.0),
                                          ),
                                          height: 40.h,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              if(marketcomplexshop[index-1]['open']==1){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>menuscreen(shop_key: marketcomplexshop[index-1]['id'],collection_name: "food-marketcomplex")));
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    marketcomplexshop[index-1]['Name'],
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    marketcomplexshop[index-1]['open']==1?'Open':'Close',
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 420.h,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: khokhasize+1,
                                  itemBuilder: (BuildContext context, int index)
                                  {
                                    if(index==0)
                                    {
                                      return Column(
                                        children: [
                                          Text(
                                            'Trending in Khokha',
                                            style: TextStyle(
                                              fontSize: 24.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width:350.w,
                                            height : 150.h,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 5,
                                              itemBuilder: (BuildContext context,int ind)
                                              {
                                                return Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Container(
                                                    height: 141.h,
                                                    width: 150.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: const Color.fromRGBO(188, 157, 255, 1.0),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else
                                    {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: const Color.fromRGBO(188, 157, 255, 1.0),
                                          ),
                                          height: 40.h,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              if(khokhashop[index-1]['open']==1){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>menuscreen(shop_key: khokhashop[index-1]['id'],collection_name: "food-khokha")));
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    khokhashop[index-1]['Name'],
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    khokhashop[index-1]['open']==1?'Open':'Close',
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 420.h,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: foodcourtsize+1,
                                  itemBuilder: (BuildContext context, int index)
                                  {
                                    if(index==0)
                                    {
                                      return Column(
                                        children: [
                                          Text(
                                            'Trending in Food Court',
                                            style: TextStyle(
                                              fontSize: 24.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width:350.w,
                                            height : 150.h,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 5,
                                              itemBuilder: (BuildContext context,int ind)
                                              {
                                                return Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Container(
                                                    height: 141.h,
                                                    width: 150.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: const Color.fromRGBO(188, 157, 255, 1.0),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else
                                    {
                                      return Padding(
                                        padding: EdgeInsets.fromLTRB(45.w, 10.h, 45.w, 10.h),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: const Color.fromRGBO(188, 157, 255, 1.0),
                                          ),
                                          height: 40.h,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              if(foodcourtshop[index-1]['open']==1){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>menuscreen(shop_key: foodcourtshop[index-1]['id'],collection_name: "food-foodcourt")));
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    foodcourtshop[index-1]['Name'],
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    foodcourtshop[index-1]['open']==1?'Open':'Close',
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 420.h,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: canteensize+1,
                                  itemBuilder: (BuildContext context, int index)
                                  {
                                    if(index==0)
                                    {
                                      return Column(
                                        children: [
                                          Text(
                                            'Trending in Canteen',
                                            style: TextStyle(
                                              fontSize: 24.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width:350.w,
                                            height : 150.h,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 5,
                                              itemBuilder: (BuildContext context,int ind)
                                              {
                                                return Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Container(
                                                    height: 141,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: const Color.fromRGBO(188, 157, 255, 1.0),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else
                                    {
                                      return Padding(
                                        padding: EdgeInsets.fromLTRB(45.w, 10.h, 45.w, 10.h),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: const Color.fromRGBO(188, 157, 255, 1.0),
                                          ),
                                          height: 40.h,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              if(canteenshop[index-1]['open']==1){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>menuscreen(shop_key: canteenshop[index-1]['id'],collection_name: "food-canteen")));
                                              }
                                              },
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    canteenshop[index-1]['Name'],
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    canteenshop[index-1]['open']==1?'Open':'Close',
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                      ],
                    ),
                  ),
                ),


                // new TabBarView(
                //   controller: tabController,
                //   children: myTabs.map((Tab tab) {
                //     return new Center(child: new Text(tab.text!));
                //   }).toList(),
                // ),
                // floatingActionButton: new FloatingActionButton(
                //   onPressed: () => tabController.animateTo((tabController.index + 1) % 2), // Switch tabs
                //   child: new Icon(Icons.swap_horiz),
                // ),
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
            ),
          ]
      ),
    );
  }
  Future<void> Reload() async {
    db.getfoodshop('food-marketcomplex').then((value){
      if(!mounted) {
        return;
      }
      setState((){
        marketcomplexshop=value;
        marketcomplexsize=marketcomplexshop.length;
      });
    });
    db.getfoodshop('food-canteen').then((value){
      if(!mounted) {
        return;
      }
      setState((){
        canteenshop=value;
        canteensize=canteenshop.length;
      });
    });
    db.getfoodshop('food-foodcourt').then((value){
      if(!mounted) {
        return;
      }
      setState((){
        foodcourtshop=value;
        foodcourtsize=foodcourtshop.length;
      });
    });
    db.getfoodshop('food-khokha').then((value){
      if(!mounted) {
        return;
      }
      setState((){
        khokhashop=value;
        khokhasize=khokhashop.length;
      });
    });
  }
}
