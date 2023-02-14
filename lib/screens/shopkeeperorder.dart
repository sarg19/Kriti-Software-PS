
import 'dart:async';

import 'package:flutter/material.dart';

import '../database.dart';

class ShopkeeperOrderPage extends StatefulWidget {
  const ShopkeeperOrderPage({Key? key}) : super(key: key);

  @override
  State<ShopkeeperOrderPage> createState() => _ShopkeeperOrderPageState();
}

class _ShopkeeperOrderPageState extends State<ShopkeeperOrderPage> {
  List Pending_Order=[];
  List Active_Order=[];
  int pendinglength=0;
  int activelength=0;
  late Databases db;
  late Timer timer;
  initialise(){
    db=Databases();
    db.initialise();
  }
  void initState() {
    super.initState();
    initialise();
    db.retrieve_shop_info("shops", "kOFNcRZ9JnFFiW3AtXzj").then((value){
      setState((){
        Pending_Order=value['Pending_Order'];
        Active_Order=value['Active_Order'];
        pendinglength=Pending_Order.length;
        activelength=Active_Order.length;
      });
    });
    // timer=Timer.periodic(Duration(milliseconds: 100), (timer) {
    // });
  }
  int _currentIndex = 0;
  List GrandList = [
    ["aloo seez","alooseez maggi"],
    ["dfbdsf","aerge","gaergvae"],
    ["ergvearvearga"],
    ["aloo seez","alooseez maggi"],
    ["dfbdsf","aerge","gaergvae"],
    ["ergvearvearga"],
  ];
  List GandList = [
    ["aloo seez","alooseez maggi"],
    ["dfbdsf","aerge","gaergvae"],
    ["ergvearvearga"],
    ["aloo seez","alooseez maggi"],
    ["dfbdsf","aerge","gaergvae"],
    ["ergvearvearga"],
  ];
  var selected = 1;
  var size, height, width;

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
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Image(
                  image: AssetImage("assets/images/appLogo.png"),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
            actions: [
              Transform.scale(
                scale: 1.5,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle_outlined,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)
                      // ),
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text("Orders", style: TextStyle(fontSize: 40,fontWeight: FontWeight.w400)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          // print('press');
                          setState(() {
                            selected = 0;
                          });
                          // Perform action
                        },
                        child: Text(
                          "Active",
                          style: TextStyle(
                            // decoration: selected == 0
                            //     ? TextDecoration.underline
                            //     : TextDecoration.none,
                            color: selected == 0
                                ? Colors.black
                                : Color.fromRGBO(104, 104, 104, 1.0),
                            fontSize: 25,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ),
                      ),
                      TextButton(
                        // style: ButtonStyle(),
                        onPressed: () {
                          // print('press');
                          setState(() {
                            selected = 1;
                          });
                          // Perform action
                        },
                        child: Text(
                          "Pending",
                          style: TextStyle(
                            // decoration: selected == 1
                            //     ? TextDecoration.underline
                            //     : TextDecoration.none,
                            color: selected == 1
                                ? Colors.black
                                : Color.fromRGBO(104, 104, 104, 1.0),
                            fontSize: 25,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 3,
                    color: Colors.black,
                    // height: 10,
                    indent: selected == 0? 70 : MediaQuery.of(context).size.width/2 +20,
                    endIndent: selected==0? MediaQuery.of(context).size.width/2 + 50 : 70,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  selected == 1
                      ? Container(
                    height: 500,
                    child: ListView.builder(
                        itemCount: pendinglength,
                        itemBuilder: (context, index) {
                          return ShopkeeperPendingCard(items: Pending_Order[index]);
                        }),
                  )
                      : Container(
                    height: 500,
                    child: ListView.builder(
                        itemCount: activelength,
                        itemBuilder: (context, index) {
                          return ShopkeeperActiveCard(items: Active_Order[index]);
                        }),
                  )
                ],
              ),
            ),
          ),
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
          ),
        ),
      ],
    );
  }
}


class ShopkeeperPendingCard extends StatefulWidget {
  final Map items;

  ShopkeeperPendingCard({required this.items});

  @override
  State<ShopkeeperPendingCard> createState() => _shopkeeper_pending_card();
}
class ShopkeeperActiveCard extends StatefulWidget {
  final Map items;

  ShopkeeperActiveCard({required this.items});

  @override
  State<ShopkeeperActiveCard> createState() => _shopkeeper_active_card();
}
class _shopkeeper_active_card extends State<ShopkeeperActiveCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        // width: 280,
        height: widget.items['Order_Items'].length.toDouble()*25+150,
        // decoration: BoxDecoration(
        //   color: Color.fromRGBO(255, 249, 240, 1.0),
        //   borderRadius: BorderRadius.circular(15),
        // ),
        child: Column(
          children: [
            Container(
              //padding: EdgeInsets.fromLTRB(20, 0, right, bottom),
              height: 55,
              width: 280,
              padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(188, 157, 255, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
              ),
              child: Text(
                widget.items['Name'],
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans'
                ),
              ),

            ),
            Container(
              color: Color.fromRGBO(255, 249, 240, 1.0),
              padding: EdgeInsets.fromLTRB(20, 0,
                  20, 0),
              height: widget.items['Order_Items'].length.toDouble()*25+40,
              // height: items.length == 1 ? 60 : items.length*33,
              width: 280,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.items['Order_Items'].length,
                      itemBuilder: (context,index){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.items['Order_Items'][index]['Item_Name'], style: TextStyle(fontSize: 18,fontFamily: 'DMSans'),),
                            Text("x "+widget.items['Order_Items'][index]['Quantity'].toString(), style: TextStyle(fontSize: 16,fontFamily: 'DMSans',color: Color.fromRGBO(114, 114, 114, 1.0)),),
                          ],
                        );
                      },
                    ),
                  ),
                  Align(
                    heightFactor: 1.3,
                    alignment: Alignment.topRight,
                    child: Text("Rs. "+widget.items['Total_Amount'].toString(), style: TextStyle(fontSize: 16,fontFamily: 'DMSans',color: Color.fromRGBO(114, 114, 114, 1.0)),),
                  ),
                ],
              ),
            ),
            Container(
              // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 55,
                width: 280,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 249, 240, 1.0),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const ImageIcon(AssetImage('assets/icons/scan.png'), color: Colors.transparent,),
                          iconSize: 0,
                          onPressed: (){},
                          // color: Colors.red,
                        ),
                        Container(
                          width: 120,
                          // padding: EdgeInsets.fromLTRB(73, 0, 0, 7),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: StadiumBorder(),
                                primary: Color.fromRGBO(188, 157, 255, 1),
                                onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                            ),
                            child: Text(
                              'Ready',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 16,
                              ),
                            ),
                            onPressed: (){},
                          ),
                        ),
                        IconButton(
                          icon: ImageIcon(AssetImage('assets/icons/scan.png')),
                          iconSize: 30,
                          onPressed: (){},
                          // color: Colors.red,
                        )

                      ]
                  ),
                )

            )


          ],
        ),
      ),
    );
  }
}




class _shopkeeper_pending_card extends State<ShopkeeperPendingCard>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        // width: 280,
        height: widget.items['Order_Items'].length.toDouble()*25+150,
        // decoration: BoxDecoration(
        //   color: Color.fromRGBO(255, 249, 240, 1.0),
        //   borderRadius: BorderRadius.circular(15),
        // ),
        child: Column(
          children: [
            Container(
              //padding: EdgeInsets.fromLTRB(20, 0, right, bottom),
              height: 55,
              width: 280,
              padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(188, 157, 255, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
              ),
              child: Text(
                widget.items['Name'],
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans'
                ),
              ),

            ),
            Container(
              color: Color.fromRGBO(255, 249, 240, 1.0),
              padding: EdgeInsets.fromLTRB(20, 0,
                  20, 0),
              height: widget.items['Order_Items'].length.toDouble()*25+40,
              // height: items.length == 1 ? 60 : items.length*33,
              width: 280,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.items['Order_Items'].length,
                      itemBuilder: (context,index){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.items['Order_Items'][index]['Item_Name'], style: TextStyle(fontSize: 18,fontFamily: 'DMSans'),),
                            Text("x "+widget.items['Order_Items'][index]['Quantity'].toString(),style: TextStyle(color: Color.fromRGBO(114, 114, 114, 1.0),fontSize: 16))
                          ],
                        );
                      },
                    ),
                  ),
                  Align(
                    heightFactor: 1.3,
                    alignment: Alignment.topRight,
                    child: Text("Rs. "+widget.items['Total_Amount'].toString(), style: TextStyle(fontSize: 16,fontFamily: 'DMSans',color: Color.fromRGBO(
                        114, 114, 114, 1.0)),),
                  ),
                ],
              ),
            ),
            Container(
                height: 55,
                width: 280,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 249, 240, 1.0),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90,
                          // padding: EdgeInsets.fromLTRB(20, 0, 20, 7),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: StadiumBorder(),
                                primary: Color.fromRGBO(188, 157, 255, 1),
                                onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                            ),
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15,
                              ),
                            ),
                            onPressed: (){},
                          ),
                        ),
                        Container(
                          width: 90,
                          // padding: EdgeInsets.fromLTRB(20, 0, 20, 7),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: StadiumBorder(),
                                primary: Color.fromRGBO(188, 157, 255, 1),
                                onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                            ),
                            child: Text(
                              'Reject',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15,
                              ),
                            ),
                            onPressed: (){},
                          ),
                        )

                      ]
                  ),
                )

            )


          ],
        ),
      ),
    );
  }
}
