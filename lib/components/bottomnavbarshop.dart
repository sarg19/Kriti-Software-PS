import 'package:flutter/material.dart';

class BottomNavBarShop extends StatefulWidget {
  const BottomNavBarShop({Key? key}) : super(key: key);

  @override
  State<BottomNavBarShop> createState() => _BottomNavBarShopState();
}

class _BottomNavBarShopState extends State<BottomNavBarShop> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
