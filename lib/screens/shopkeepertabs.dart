import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/components/additem.dart';
import 'package:kriti/popups/shopkeeperProfilePopup.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/screens/ShopHome.dart';
import 'package:kriti/screens/menushopkeeper.dart';
import 'package:kriti/screens/shopkeeperorder.dart';

import '../database.dart';

class ShopkeeperTabs extends StatefulWidget {
  final String coltype;
  const ShopkeeperTabs({Key? key,required this.coltype}) : super(key: key);

  @override
  State<ShopkeeperTabs> createState() => _ShopkeeperTabsState();
}

class _ShopkeeperTabsState extends State<ShopkeeperTabs> {
  String email="";
  String username="";
  String shopname="";
  num Phone=123456789;
  num _currentStar = 4;
  int _currentIndex = 0;
  bool _isopen = true;
  var tabs = [const ShopHome(), const ShopkeeperOrderPage(), const shopmenuscreen()];
  int counter=0;
  late Databases db;
  Map Menu={};
  late Timer timer;
  initialise(){
    db=Databases();
    db.initialise();
  }
  Future<void> Reload() async {
    db.retrieve_menu(FirebaseAuth.instance.currentUser?.uid,FirebaseAuth.instance.currentUser?.displayName).then((value){
      if(!mounted) return;
      setState(() {
        counter=1;
        Menu=value;
        _isopen=value['open']==1?true:false;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    initialise();
    FirebaseAuth.instance.currentUser?.reload().then((value) {
      timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        if(_currentIndex==2){
          Reload();
        }
      });
    });
    db.retrieve_shop_info(widget.coltype,FirebaseAuth.instance.currentUser?.uid).then((value){
      if(!mounted)return;
      setState(() {
        username=value['UserName'];
        _currentStar=3;
        shopname=value['ShopName'];
        email=value['Email'];
        Phone=value['Number'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Stack(
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
                leading: GestureDetector(
                  onTap: (){
                    setState(() {
                      _isopen = !_isopen;
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
                          widgetcontent: ShopkeeperProfile(shoptype: widget.coltype,email: email,shopname: shopname,rating: _currentStar,phone: Phone,username: username),
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
              body: tabs[_currentIndex],
              floatingActionButton: _currentIndex==2?FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                child: Image.asset('assets/icons/circleplus.png'),
                onPressed: (){
                  print(counter);
                  if(counter==1){
                    showDialog(context: context, builder: (BuildContext context){
                      return ShowPopUp(widgetcontent: AddItem(Shop_Key: FirebaseAuth.instance.currentUser?.uid,Collection: FirebaseAuth.instance.currentUser?.displayName,Menu: Menu,));
                    });
                  }
                },
              ):Visibility(
                visible: false,
                child: FloatingActionButton(
                  onPressed: (){},
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color.fromRGBO(219, 202, 255, 1.0),
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black54,
                selectedFontSize: 0,
                type: BottomNavigationBarType.fixed,
                // type: BottomNavigationBarType.values,
                currentIndex: _currentIndex,
                items: [
                  BottomNavigationBarItem(
                    // backgroundColor: const Color.fromRGBO(174, 147, 234, 1.0),
                    icon: Container(
                      margin: const EdgeInsets.all(8.0),
                      width: double.maxFinite,
                      // height: double.maxFinite,
                      decoration: BoxDecoration(
                          color: _currentIndex == 0 ? Color.fromRGBO(
                              255, 235, 198, 1.0) : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: IconButton(
                        icon: const ImageIcon(AssetImage('assets/icons/home.png')),
                        onPressed: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    // backgroundColor: const Color.fromRGBO(219, 202, 255, 1.0),
                    icon: Container(
                      margin: const EdgeInsets.all(8.0),
                      width: double.maxFinite,
                      // height: double.maxFinite,
                      decoration: BoxDecoration(
                          color: _currentIndex == 1 ? Color.fromRGBO(
                              255, 235, 198, 1.0) : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: IconButton(
                        icon: const ImageIcon(AssetImage('assets/icons/bag.png')),
                        onPressed: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    // backgroundColor: const Color.fromRGBO(219, 202, 255, 1.0),
                    icon: Container(
                      margin: const EdgeInsets.all(8.0),
                      width: double.maxFinite,
                      // height: double.maxFinite,
                      decoration: BoxDecoration(
                          color: _currentIndex == 2 ? Color.fromRGBO(
                              255, 235, 198, 1.0) : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: IconButton(
                        icon: const ImageIcon(AssetImage('assets/icons/more.png')),
                        onPressed: () {
                          setState(() {
                            _currentIndex = 2;
                          });
                        },
                      ),
                    ),
                    label: '',
                  ),
                ],
              ),
            ),
          ),
        ]
    );
  }
}
