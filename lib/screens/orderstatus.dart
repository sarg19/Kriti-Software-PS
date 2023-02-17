import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/database.dart';
import 'package:kriti/popups/profilepopup.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/screens/customertabs.dart';
import 'package:kriti/screens/paymentscreen.dart';

import '../components/bottom_nav_bar.dart';

class OrderStatusScreen extends StatefulWidget {
  final String order_uid;
  const OrderStatusScreen({Key? key, required this.order_uid}) : super(key: key);

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {

  var size,
      height,
      width;

  String order_status = "";
  String upi_id = "";
  String payment_amount = "";
  String shop_name = "";
  late Timer timer;
  late Databases db;
  late Map user_info;
  initialise(){
    db=Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    initialise();
    timer= Timer.periodic(const Duration(milliseconds: 100), (timer) {
      Reload();
    });
  }

  bool requestApproved = false;
  // bool requestRejected = !requestApproved;
  bool showMakePaymentButton = false;
  bool paymentSuccessful = false;
  bool orderProcessing = false;
  bool orderReady = false;
  late bool special;
  bool goToQR = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;

    // bool requestApproved = false;
    // // bool requestRejected = !requestApproved;
    // bool showMakePaymentButton = false;
    // bool paymentSuccessful = false;
    // bool orderProcessing = false;
    // bool orderReady = false;
    // bool special;
    // bool goToQR = requestApproved & paymentSuccessful & orderProcessing & orderReady;

    if(requestApproved) special = true;
    else special = false;

    if(!requestApproved){
      showMakePaymentButton = false;
      paymentSuccessful = false;
      orderProcessing = false;
      orderReady = false;
    }

    if(paymentSuccessful){
      showMakePaymentButton = false;
    }
    else{
      orderProcessing = false;
      orderReady = false;
    }

    if(!orderProcessing) orderReady = false;

    return Stack(
      children: [
        Image.asset(
          height: h,
          width: w,
          fit: BoxFit.cover,
          "assets/images/bgImage1.png",
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
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new , color: Colors.black ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ShowPopUp(
                      widgetcontent: Profile(Name: "Name",Email: "Email",Phone: 9876513546,),
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
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(219, 202, 255, 1.0),
            selectedItemColor: Colors.black54,
            unselectedItemColor: Colors.black54,
            selectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/home.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 0)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/bag.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 1)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/favorite.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 2)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/cart.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 3)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: Column(
              children: [
                Text(
                  'Order Status',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.sp,
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none
                  ),
                ),
                SizedBox(height: h/17),
                Row(
                  children: [
                    SizedBox(
                      width: w/7,
                    ),
                    Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(188,157,255,1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: w/20,
                    ),
                    Text(
                      'Request Sent',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: requestApproved,
                  child: Padding(
                    padding: EdgeInsets.only(right: 220.w),
                    child: Container(
                      height: h/19,
                      width: 5.w,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(188,157,255,1)
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: requestApproved,
                  child: Row(
                    children: [
                      SizedBox(
                        width: w/7,
                      ),
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(188,157,255,1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: w/20,
                      ),
                      Text(
                        'Request Approved',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ],
                  ),
                ),
                // Visibility(
                //   visible: requestRejected,
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         width: w/7,
                //       ),
                //       Container(
                //         height: 40.h,
                //         width: 40.h,
                //         decoration: BoxDecoration(
                //           color: Color.fromRGBO(188,157,255,1),
                //           shape: BoxShape.circle,
                //         ),
                //       ),
                //       SizedBox(
                //         width: w/20,
                //       ),
                //       Text(
                //         'Request Rejected',
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 20.sp,
                //             fontFamily: 'DMSans',
                //             fontWeight: FontWeight.normal,
                //             decoration: TextDecoration.none
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Visibility(
                  visible: requestApproved & showMakePaymentButton,
                  child: Padding(
                    padding: EdgeInsets.only(right: 220.w),
                    child: Container(
                      height: h/19,
                      width: 5.w,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(188,157,255,1)
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: special,
                  // visible: requestApproved | requestRejected & !showMakePaymentButton,
                  child: Padding(
                    padding: EdgeInsets.only(right: 220.w),
                    child: Container(
                      height: h/9,
                      width: 5.w,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(188,157,255,1)
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: showMakePaymentButton,
                  child: Row(
                    children: [
                      SizedBox(
                        width: w/7,
                      ),
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(188,157,255,1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: w/20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(188,157,255,1),
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                          )
                        ),
                        onPressed: () {
                          db.PaymentSuccess(widget.order_uid);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(upi_id: upi_id, payment_amount: payment_amount, shop_name: shop_name,)));
                        },
                        child: Text(
                          'Make Payment',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontFamily: 'DMSans',
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: paymentSuccessful,
                  child: Row(
                    children: [
                      SizedBox(
                        width: w/7,
                      ),
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(188,157,255,1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: w/20,
                      ),
                      Text(
                        'Payment Successful',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: paymentSuccessful & orderProcessing,
                  child: Padding(
                    padding: EdgeInsets.only(right: 220.w),
                    child: Container(
                      height: h/19,
                      width: 5.w,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(188,157,255,1)
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: orderProcessing,
                  child: Row(
                    children: [
                      SizedBox(
                        width: w/7,
                      ),
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(188,157,255,1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: w/20,
                      ),
                      Text(
                        'Order being Processed',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: orderProcessing & orderReady,
                  child: Padding(
                    padding: EdgeInsets.only(right: 220.w),
                    child: Container(
                      height: h/19,
                      width: 5.w,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(188,157,255,1)
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: orderReady,
                  child: Row(
                    children: [
                      SizedBox(
                        width: w/7,
                      ),
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(188,157,255,1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: w/20,
                      ),
                      Text(
                        'Order Ready',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h/20),
                Visibility(
                  visible: goToQR,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                    Color.fromRGBO(188,157,255,1),
                    ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                      )
                    ),
                    onPressed: () {},
                    child: Text(
                      'Go to QR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Future<void> Reload()async{
    // print(widget.order_uid);
    db.get_order_details(widget.order_uid).then((value) {
      if(!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        payment_amount = value['Total_Amount'].toString();
      });
      setState(() {
        shop_name = value['Shop_Name'];
      });
      setState(() {
        order_status = value['Status'];
      });
      // print(order_status);
      if(order_status=="Approved"){
        setState(() {
          requestApproved = true;
          special = true;
          showMakePaymentButton = true;
        });
      }
      if(order_status=="Successful"){
        setState(() {
          paymentSuccessful = true;
          orderProcessing = true;
        });
      }
      if(order_status=="Ready"){
        setState(() {
          orderReady = true;
          goToQR = true;
        });
      }
      db.getUserType(value['Shop_Key']).then((collection) {
        db.retrieve_shop_info(collection, value['Shop_Key']).then((shopinfo) {
          if(!mounted) return;
          setState(() {
            upi_id = shopinfo['UPI_id'];
          });
        });
      });
    });
  }
}