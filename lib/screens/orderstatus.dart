import 'package:flutter/material.dart';

import '../components/bottom_nav_bar.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({Key? key}) : super(key: key);

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {

  var size,
      height,
      width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;

    bool requestApproved = true;
    bool requestRejected = !requestApproved;
    bool showMakePaymentButton = true;
    bool paymentSuccessful = true;
    bool orderProcessing = true;
    bool orderReady = true;
    bool special;
    bool goToQR = requestApproved & paymentSuccessful & orderProcessing & orderReady;

    if(requestRejected) special = false;
    else special = true;

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
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNavBar(),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Text(
                  'Order Status',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
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
                      height: 40,
                      width: 40,
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
                          fontSize: 20,
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: requestApproved | requestRejected,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 240),
                    child: Container(
                      height: h/19,
                      width: 5,
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
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
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
                            fontSize: 20,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: requestRejected,
                  child: Row(
                    children: [
                      SizedBox(
                        width: w/7,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(188,157,255,1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: w/20,
                      ),
                      Text(
                        'Request Rejected',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: requestApproved & showMakePaymentButton,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 240),
                    child: Container(
                      height: h/19,
                      width: 5,
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
                    padding: const EdgeInsets.only(right: 240),
                    child: Container(
                      height: h/9,
                      width: 5,
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
                        height: 40,
                        width: 40,
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
                        onPressed: () {},
                        child: Text(
                          'Make Payment',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
                        height: 40,
                        width: 40,
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
                            fontSize: 20,
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
                    padding: const EdgeInsets.only(right: 240),
                    child: Container(
                      height: h/19,
                      width: 5,
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
                        height: 40,
                        width: 40,
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
                            fontSize: 20,
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
                    padding: const EdgeInsets.only(right: 240),
                    child: Container(
                      height: h/19,
                      width: 5,
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
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(188,157,255,1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: w/20,
                      ),
                      const Text(
                        'Order Ready',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
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
                    child: const Text(
                      'Go to QR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
}
