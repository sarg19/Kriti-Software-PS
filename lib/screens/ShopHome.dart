import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';
import '../components/bottomnavbarshop.dart';
class ShopHome extends StatefulWidget {
  const ShopHome({super.key});

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<ShopHome> {
  int _currentIndex = 0;
  bool _isopen = true;
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
            child: new Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Center(
                  child: Container(
                    height:50,
                    width:50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),

                    child: Image(
                      image: AssetImage("assets/images/appLogo.png"),
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 100.0,
                leading: GestureDetector(
                  onTap: (){
                    setState(() {
                      _isopen = !_isopen;
                    });
                  },
                  child: Image.asset(
                    _isopen ? 'assets/icons/Toggle-on.png' : 'assets/icons/Toggle-off.png',
                    height: 50,
                    width: 63,
                  ),
                ),
                actions: [
                  Transform.scale(
                    scale: 1.5,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.account_circle_outlined , color: Colors.black),
                    ),
                  ),
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.values,
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Subansiri Canteen',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    _isopen? 'Now Open' : 'Now Closed',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(114, 114, 114, 1.0),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      alignment: const Alignment(0,-1),
                      height: 98,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: SizedBox.expand(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                            shape: StadiumBorder(),
                          ),
                          child: Text(
                            'Add Offer',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(114, 114, 114, 1.0),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      alignment: const Alignment(0,-1),
                      height: 43,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: Center(
                        child: Text(
                          "Today's Earning is Rs.500",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(244, 233, 255, 1.0),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavBarShop(),
            ),
          ),
        ]
    );
  }
}
