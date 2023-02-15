import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../database.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late Map user_info;
  late Databases db;
  int completedlength = 0;
  int activelength = 0;

  initialise() {
    db = Databases();
    db.initialise();
  }

  @override
  void initState() {
    super.initState();
    initialise();
    db.retrieve_user_info(FirebaseAuth.instance.currentUser?.uid).then((value) {
      setState(() {
        user_info = value;
        completedlength = user_info['Recent_Orders'].length;
        activelength = user_info['Active_Orders'].length;
      });
    });
  }

  int _currentIndex = 0;
  var selected = 1;
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Center(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Container(
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.black)
                // ),
                padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
                child: Text("Orders",
                    style: TextStyle(
                        fontSize: 30.sp, fontWeight: FontWeight.w400)),
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
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Text(
                    "Active",
                    style: TextStyle(
                      // decoration: selected == 0
                      //     ? TextDecoration.underline
                      //     : TextDecoration.none,
                      color: selected == 0
                          ? Colors.black
                          : const Color.fromRGBO(104, 104, 104, 1.0),
                      fontSize: 20.sp,
                    ),
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
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Text(
                    "Completed",
                    style: TextStyle(
                      // decoration: selected == 1
                      //     ? TextDecoration.underline
                      //     : TextDecoration.none,
                      color: selected == 1
                          ? Colors.black
                          : const Color.fromRGBO(104, 104, 104, 1.0),
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 3,
              color: Colors.black,
              // height: 10,
              indent: selected == 0
                  ? 60.w
                  : MediaQuery.of(context).size.width / 2 + 10.w,
              endIndent: selected == 0
                  ? MediaQuery.of(context).size.width / 2 + 50.w
                  : 58.w,
            ),
            // SizedBox(
            //   height: 10.h,
            // ),
            selected == 1
                ? Container(
                    height: 497.h,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: completedlength,
                        itemBuilder: (context, index) {
                          return OrderCard(
                              item: user_info['Recent_Orders'][index]);
                        }),
                  )
                : Container(
                    height: 497.h,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: activelength,
                        itemBuilder: (context, index) {
                          return customer_order_active_card(
                              item: user_info['Active_Orders'][index]);
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  final Map item;

  OrderCard({required this.item});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class customer_order_active_card extends StatefulWidget {
  final Map item;

  customer_order_active_card({required this.item});

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
        height: widget.item['Order_Items'].length.toDouble() * 22.h + 160.h,
        // decoration: BoxDecoration(
        //   color: Color.fromRGBO(255, 249, 240, 1.0),
        //   borderRadius: BorderRadius.circular(15),
        // ),
        child: Column(
          children: [
            Container(
              //padding: EdgeInsets.fromLTRB(20, 0, right, bottom),
              height: 55.h,
              width: 280.w,
              padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(188, 157, 255, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Text(
                widget.item['Shop_Name'],
                style: TextStyle(
                    fontSize: 25.sp,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans'),
              ),
            ),
            Container(
              color: Color.fromRGBO(255, 249, 240, 1.0),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              height:
                  widget.item['Order_Items'].length.toDouble() * 22.h + 50.h,
              // height: items.length == 1 ? 60 : items.length*33,
              width: 280.w,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.item['Order_Items'].length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.item['Order_Items'][index]['Item_Name'],
                              style: TextStyle(
                                  fontSize: 18.sp, fontFamily: 'DMSans'),
                            ),
                            Text(
                              "x${widget.item['Order_Items'][index]['Quantity']}",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'DMSans',
                                  color: Color.fromRGBO(114, 114, 114, 1.0)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Align(
                    heightFactor: 1.3,
                    alignment: Alignment.topRight,
                    child: Text(
                      "Rs. ${widget.item['Total_Amount']}",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'DMSans',
                          color: Color.fromRGBO(114, 114, 114, 1.0)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                // margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 55.h,
                width: 280.w,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 249, 240, 1.0),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const ImageIcon(
                            AssetImage('assets/icons/qrcode.png'),
                            color: Colors.transparent,
                          ),
                          iconSize: 0,
                          onPressed: () {},
                          // color: Colors.red,
                        ),
                        Container(
                          width: 120.w,
                          // padding: EdgeInsets.fromLTRB(73, 0, 0, 7),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: StadiumBorder(),
                                primary: Color.fromRGBO(188, 157, 255, 1),
                                onPrimary: Color.fromRGBO(255, 255, 255, 1.0)),
                            child: Text(
                              'Show Status',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15.sp,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        IconButton(
                          icon:
                              ImageIcon(AssetImage('assets/icons/qrcode.png')),
                          iconSize: 30.sp,
                          onPressed: () {},
                          // color: Colors.red,
                        )
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    double count = widget.item['Order_Items'].length.toDouble();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        // width: 280,
        height: count * 22.h + 160.h,
        // decoration: BoxDecoration(
        //   color: Color.fromRGBO(255, 249, 240, 1.0),
        //   borderRadius: BorderRadius.circular(15),
        // ),
        child: Column(
          children: [
            Container(
              //padding: EdgeInsets.fromLTRB(20, 0, right, bottom),
              height: 55.h,
              width: 280.w,
              padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(188, 157, 255, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Text(
                widget.item['Shop_Name'],
                style: TextStyle(
                    fontSize: 25.sp,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans'),
              ),
            ),
            Container(
              color: Color.fromRGBO(255, 249, 240, 1.0),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              height: count * 22.h + 40.h,
              width: 280.w,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.item['Order_Items'].length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.item['Order_Items'][index]['Item_Name'],
                              style: TextStyle(
                                  fontSize: 18.sp, fontFamily: 'DMSans'),
                            ),
                            Text(
                                "x${widget.item['Order_Items'][index]['Quantity']}",
                                style: TextStyle(
                                    color: Color.fromRGBO(114, 114, 114, 1.0),
                                    fontSize: 16.sp))
                          ],
                        );
                      },
                    ),
                  ),
                  // Align(
                  //   heightFactor: 1.3,
                  //   alignment: Alignment.topRight,
                  //   child: Text("Rs. 100", style: TextStyle(fontSize: 16,fontFamily: 'DMSans',color: Color.fromRGBO(
                  //       114, 114, 114, 1.0)),),
                  // ),
                ],
              ),
            ),
            Container(
                height: 55.h,
                width: 280.w,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 249, 240, 1.0),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90.w,
                          // padding: EdgeInsets.fromLTRB(20, 0, 20, 7),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: StadiumBorder(),
                                primary: Color.fromRGBO(188, 157, 255, 1),
                                onPrimary: Color.fromRGBO(255, 255, 255, 1.0)),
                            child: Text(
                              'Reorder',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15.sp,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          width: 90.w,
                          // padding: EdgeInsets.fromLTRB(20, 0, 20, 7),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: StadiumBorder(),
                                primary: Color.fromRGBO(188, 157, 255, 1),
                                onPrimary: Color.fromRGBO(255, 255, 255, 1.0)),
                            child: Text(
                              'Review',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15.sp,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
