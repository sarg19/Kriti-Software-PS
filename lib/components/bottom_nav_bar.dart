import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
                color: _currentIndex == 0 ? const Color.fromRGBO(164, 146, 203, 1.0) : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(10))
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
          icon: Container(
            margin: const EdgeInsets.all(8.0),
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: _currentIndex == 1 ? const Color.fromRGBO(164, 146, 203, 1.0) : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(10))
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
          icon: Container(
            margin: const EdgeInsets.all(8.0),
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: _currentIndex == 2 ? const Color.fromRGBO(164, 146, 203, 1.0) : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
            child: IconButton(
              icon: const ImageIcon(AssetImage('assets/icons/favorite.png')),
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
                color: _currentIndex == 3 ? const Color.fromRGBO(164, 146, 203, 1.0) : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
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
    );
  }

}
