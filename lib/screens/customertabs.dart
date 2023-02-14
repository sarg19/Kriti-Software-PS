import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/popups/profilepopup.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/screens/cartscreen.dart';
import 'package:kriti/screens/favouritesscreen.dart';
import 'package:kriti/screens/home.dart';
import 'package:kriti/screens/orderscreen.dart';

class CustomerTabs extends StatefulWidget {
  final int currentIndex;

  const CustomerTabs({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<CustomerTabs> createState() => _CustomerTabsState();
}

class _CustomerTabsState extends State<CustomerTabs> {
  var _currentIndex;
  var tabs = [
    const homescreen(),
    const OrderPage(),
    const favouritesscreen(),
    const cartscreen()
  ];

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Stack(
      children: [
        Image.asset(
          'assets/images/bgImage1.png',
          height: height,
          width: width,
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
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ShowPopUp(
                      widgetcontent: Profile(),
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
          body: tabs[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(219, 202, 255, 1.0),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            selectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: _currentIndex == 0
                          ? const Color.fromRGBO(164, 146, 203, 1.0)
                          : Colors.transparent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
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
                icon: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: _currentIndex == 1
                          ? const Color.fromRGBO(164, 146, 203, 1.0)
                          : Colors.transparent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
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
                icon: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: _currentIndex == 2
                          ? const Color.fromRGBO(164, 146, 203, 1.0)
                          : Colors.transparent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: IconButton(
                    icon: const ImageIcon(
                        AssetImage('assets/icons/favorite.png')),
                    onPressed: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: _currentIndex == 3
                          ? const Color.fromRGBO(164, 146, 203, 1.0)
                          : Colors.transparent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: IconButton(
                    icon: const ImageIcon(AssetImage('assets/icons/cart.png')),
                    onPressed: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
