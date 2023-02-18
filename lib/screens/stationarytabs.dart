
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/database.dart';
import 'package:kriti/popups/shopkeeperProfilePopup.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/screens/stationaryhome.dart';
import 'package:kriti/screens/stationaryorder.dart';
import 'package:firebase_auth/firebase_auth.dart';


class StationaryTabs extends StatefulWidget {
  final String coltype;
  const StationaryTabs({Key? key,required this.coltype}) : super(key: key);

  @override
  State<StationaryTabs> createState() => _StationaryTabsState();
}

class _StationaryTabsState extends State<StationaryTabs> {
  String email="";
  String username="";
  String shopname="";
  num Phone=123456789;
  late Databases db;
  num _currentStar = 4;
  bool _isopen = true;
  initialise(){
    db=Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    initialise();
    db.retrieve_shop_info(widget.coltype,FirebaseAuth.instance.currentUser?.uid).then((value){
      if(!mounted)return;
      setState(() {
        username=value['UserName'];
        _currentStar=3;
        shopname=value['ShopName'];
        email=value['Email'];
        Phone=value['Number'];
        _isopen=value['open']==1?true:false;
      });
    });
  }
  int _currentIndex = 0;

  var tabs = [const StationaryHomePage(), const StationaryOrderPage()];
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
                ],
              ),
            ),
          ),
        ]
    );
  }
}
