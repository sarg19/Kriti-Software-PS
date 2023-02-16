import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/popups/shopkeeperProfilePopup.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/screens/ShopHome.dart';
import 'package:kriti/screens/menushopkeeper.dart';
import 'package:kriti/screens/shopkeeperorder.dart';

class ShopkeeperTabs extends StatefulWidget {
  const ShopkeeperTabs({Key? key}) : super(key: key);

  @override
  State<ShopkeeperTabs> createState() => _ShopkeeperTabsState();
}

class _ShopkeeperTabsState extends State<ShopkeeperTabs> {
  int _currentIndex = 0;
  bool _isopen = true;
  var tabs = [const ShopHome(), const ShopkeeperOrderPage(), const shopmenuscreen()];
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
                          color: _currentIndex == 0 ? Color.fromRGBO(164, 146, 203, 1.0) : Colors.transparent,
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
                          color: _currentIndex == 1 ? Color.fromRGBO(164, 146, 203, 1.0) : Colors.transparent,
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
                          color: _currentIndex == 2 ? Color.fromRGBO(164, 146, 203, 1.0) : Colors.transparent,
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
