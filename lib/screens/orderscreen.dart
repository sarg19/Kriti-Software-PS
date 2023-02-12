import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _currentIndex = 0;
  List GrandList = [
    ["aloo seez", "dvhjfs", "dhdj"],
    ["dgcjsgf", "dhckjsfh", "chd", "vy"],
    ["fhjh", "sflgjk"],
    ["jhg"]
  ];
  List GandList = [
    ["aloo seez", "spersh", "mahaveer"],
    ["duck", "kabootar"],
    ["fhjh", "sflgjk"],
    ["jhg"]
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
            elevation: 100.0,
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
                          "Completed",
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
                    indent: selected == 0? 60 : MediaQuery.of(context).size.width/2 ,
                    endIndent: selected==0? MediaQuery.of(context).size.width/2 + 50 : 60,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  selected == 1
                      ? Container(
                    height: 550,
                    child: ListView.builder(
                        itemCount: GrandList.length,
                        itemBuilder: (context, index) {
                          return OrderCard(items: GrandList[index]);
                        }),
                  )
                      : Container(
                    height: 550,
                    child: ListView.builder(
                        itemCount: GandList.length,
                        itemBuilder: (context, index) {
                          return customer_order_active_card(items: GandList[index]);
                        }),
                  ),
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

class OrderCard extends StatefulWidget {
  final List<String> items;

  OrderCard({this.items = const []});

  @override
  State<OrderCard> createState() => _OrderCardState();
}
class customer_order_active_card extends StatefulWidget {
  final List<String> items;

  customer_order_active_card({this.items = const []});

  @override
  State<customer_order_active_card> createState() => _CustomerOrderActiveCard();
}
class _CustomerOrderActiveCard extends State<customer_order_active_card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        // width: 280,
        height: widget.items.length*22+150,
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
                'Kapili Canteen',
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
              height: widget.items.length*22+40,
              // height: items.length == 1 ? 60 : items.length*33,
              width: 280,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.items.length,
                      itemBuilder: (context,index){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.items[index], style: TextStyle(fontSize: 18,fontFamily: 'DMSans'),),
                            Text("x1", style: TextStyle(fontSize: 16,fontFamily: 'DMSans',color: Color.fromRGBO(114, 114, 114, 1.0)),),
                          ],
                        );
                      },
                    ),
                  ),
                  Align(
                    heightFactor: 1.3,
                    alignment: Alignment.topRight,
                    child: Text("Rs. 100", style: TextStyle(fontSize: 16,fontFamily: 'DMSans',color: Color.fromRGBO(114, 114, 114, 1.0)),),
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
                          icon: const ImageIcon(AssetImage('assets/icons/qrcode.png'), color: Colors.transparent,),
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
                              'Show Status',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15,
                              ),
                            ),
                            onPressed: (){},
                          ),
                        ),
                        IconButton(
                          icon: ImageIcon(AssetImage('assets/icons/qrcode.png')),
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




class _OrderCardState extends State<OrderCard>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        // width: 280,
        height: widget.items.length*22+150,
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
                'Kapili Canteen',
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
              height: widget.items.length*22+40,
              // height: items.length == 1 ? 60 : items.length*33,
              width: 280,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.items.length,
                      itemBuilder: (context,index){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.items[index], style: TextStyle(fontSize: 18,fontFamily: 'DMSans'),),
                            Text("x1",style: TextStyle(color: Color.fromRGBO(114, 114, 114, 1.0),fontSize: 16))
                          ],
                        );
                      },
                    ),
                  ),
                  Align(
                    heightFactor: 1.3,
                    alignment: Alignment.topRight,
                    child: Text("Rs. 100", style: TextStyle(fontSize: 16,fontFamily: 'DMSans',color: Color.fromRGBO(
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
                              'Reorder',
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
                              'Review',
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
