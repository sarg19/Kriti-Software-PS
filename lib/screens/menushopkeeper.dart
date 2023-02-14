import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kriti/components/additem.dart';
import 'package:kriti/components/edititem.dart';
import 'package:kriti/popups/profilepopup.dart';
import '../components/bottom_nav_bar.dart';
import '../database.dart';
import '../popups/showPopUp.dart';
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
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      Reload();
    });

  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Stack(
      children: [
        Image.asset(
          height: h,
          width: w,
          fit: BoxFit.cover,
          "assets/images/bgImage1.png",
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Center(
                child: Container(
                  height:50,
                  width:50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),

                  child: const Image(
                    image: AssetImage("assets/images/appLogo.png"),
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 100.0,
              leading: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.arrow_back_ios_new , color: Colors.black ),
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
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70.0,10.0,70.0,10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        height: 40,
                        child: const TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 5),
                            prefixIcon: Icon(Icons.search_outlined , color: Colors.black),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: 'Search...',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: Text(
                        "Kapili Canteen",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'DM Sans'
                        )
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 550,
                      child: ListView.builder(
                        itemCount: listlength,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 0),
                            child: ShopkeeperMenuCard(
                              name: Menu['Menu'][index]['Name'],
                              price: Menu['Menu'][index]['Price'],
                              availability: Menu['Menu'][index]['Available']==1?"Available":"Unavailable",
                              index: index,
                              Shop_Key: "kOFNcRZ9JnFFiW3AtXzj",
                              Menu: Menu,
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
            ),
            bottomNavigationBar: const BottomNavBar(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              child: Image.asset('assets/icons/circleplus.png'),
              onPressed: (){
                showDialog(context: context, builder: (BuildContext context){
                  return ShowPopUp(widgetcontent: AddItem(Shop_Key: "kOFNcRZ9JnFFiW3AtXzj",Menu: Menu,));
                });
              },
            ),
          ),
        )
      ],
    );
  }
  Future<void> Reload() async {
    db.retrieve_menu("kOFNcRZ9JnFFiW3AtXzj",'shops').then((value){
      setState(() {
        Menu=value;
        listlength=Menu['Menu'].length;
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
  ShopkeeperMenuCard({
    this.name = "",
    this.price = 0,
    this.availability="",
    this.index=0,
    this.Shop_Key="",
    required this.Menu
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        height: 170,
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
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                height: 80,
                width: 280,
                child: Stack(
                  children:[
                    Text.rich(
                        TextSpan(
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 20,
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
                      right: 12,
                      child: Container(
                        child: Text(
                          availability,
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 13,
                            color: Color.fromRGBO(72, 72, 72, 1)
                          ),
                        ),
                      ),
                    )
                  ]
                ),
            ),
            Container(
                height: 60,
                width: 280,
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
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                              return ShowPopUp(widgetcontent: EditItem(name: name,price: price,availability: availability,index: index,Shop_Key: Shop_Key,Menu: Menu,));
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