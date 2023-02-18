import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../database.dart';

class StationaryOrderPage extends StatefulWidget {
  const StationaryOrderPage({Key? key}) : super(key: key);

  @override
  State<StationaryOrderPage> createState() => _StationaryOrderPageState();
}

class _StationaryOrderPageState extends State<StationaryOrderPage> {
  int _currentIndex = 0;
  List GrandList=[["Sent an image on your Gmail"],
    ["Sent an image on your Gmail"],
    ["Sent an image on your Gmail"],
    ["Sent an image on your Gmail"]];
  List GandList = [["Sent an image on your Gmail"],
    ["Sent an image on your Gmail"],
    ["Sent an image on your Gmail"],
    ["Sent an image on your Gmail"]];
  var selected = 1;
  var size, height, width;
  late Timer timer;
  List Active_Orders=[];
  List Pending_Order=[];
  int activelength=0;
  int pendinglength=0;
  late Databases db;
  initialise() {
    db = Databases();
    db.initialise();
  }

  @override
  void initState() {
    super.initState();
    initialise();
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) { Reload();});
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)
                      // ),
                      padding: EdgeInsets.fromLTRB(0, 20.h, 0, 20.h),
                      child: Text("Orders", style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.w400)),
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
                            fontSize: 25.sp,
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
                    indent: selected == 0? 59.w : MediaQuery.of(context).size.width/2+10.h ,
                    endIndent: selected==0? MediaQuery.of(context).size.width/2 + 57.w : 59.w,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  selected == 1
                      ? Container(
                    height: 500.h,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                        itemCount: pendinglength,
                        itemBuilder: (context, index) {
                          return StationaryPendingCard(items: Pending_Order[index]);
                        }),
                  )
                      : Container(
                    height: 500.h,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                        itemCount: activelength,
                        itemBuilder: (context, index) {
                          return StationaryActiveCard(items: Active_Orders[index]);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Future<void> Reload() async {
    db.retrieve_shop_info("stationary", FirebaseAuth.instance.currentUser?.uid).then((value){
      if(!mounted){
        return;
      }
      setState(() {
        Active_Orders=value['Active_Orders'];
        Pending_Order=value['Pending_Order'];
        activelength=Active_Orders.length;
        pendinglength=Pending_Order.length;
      });
    });
  }
}

// class OrderCard extends StatefulWidget {
//   final List<String> items;
//
//   OrderCard({this.items = const []});
//
//   @override
//   State<OrderCard> createState() => _OrderCardState();
// }
class StationaryPendingCard extends StatefulWidget {
  final Map items;
  StationaryPendingCard({required this.items});

  @override
  State<StationaryPendingCard> createState() => _StationaryPendingCard();
}
class StationaryActiveCard extends StatefulWidget {
  final Map items;
  StationaryActiveCard({required this.items});

  @override
  State<StationaryActiveCard> createState() => _StationaryActiveCard();
}
class _StationaryPendingCard extends State<StationaryPendingCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        // width: 280,
        // height: 178,
        // decoration: BoxDecoration(
        //   color: Colors.red,
        //   borderRadius: BorderRadius.circular(15),
        // ),
        child: Column(
          children: [
            Container(
              //padding: EdgeInsets.fromLTRB(20, 0, right, bottom),
              height: 55.h,
              width: 280.w,
              padding: EdgeInsets.fromLTRB(20.w, 15.h, 0, 0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(188, 157, 255, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
              ),
              child: Text(
                'Tarun',
                style: TextStyle(
                    fontSize: 25.sp,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans'
                ),
              ),

            ),
            Container(
              color: Color.fromRGBO(255, 249, 240, 1.0),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 80.h,
              // height: items.length == 1 ? 60 : items.length*33,
              width: 280.w,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.h,),
                  Expanded(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.items.length,
                      itemBuilder: (context,index){
                        return Text("Sent on your Email",textAlign: TextAlign.center, style: TextStyle(fontSize: 18.sp,fontFamily: 'DMSans',),);
                      },
                    ),
                  ),
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
                        bottomRight: Radius.circular(15)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                            ),
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15.sp,
                              ),
                            ),
                            onPressed: (){},
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
                                onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                            ),
                            child: Text(
                              'Reject',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15.sp,
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




class _StationaryActiveCard extends State<StationaryActiveCard>{
  var getResult;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
        // width: 280,
        // height: 178,
        // decoration: BoxDecoration(
        //   color: Colors.red,
        //   borderRadius: BorderRadius.circular(15),
        // ),
        child: Column(
          children: [
            Container(
              //padding: EdgeInsets.fromLTRB(20, 0, right, bottom),
              height: 55.h,
              width: 280.w,
              padding: EdgeInsets.fromLTRB(20.w, 15.h, 0, 0),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(188, 157, 255, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
              ),
              child: Text(
                'Tarun',
                style: TextStyle(
                    fontSize: 25.sp,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans'
                ),
              ),

            ),
            Container(
              color: Color.fromRGBO(255, 249, 240, 1.0),
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              height: 80.h,
              // height: items.length == 1 ? 60 : items.length*33,
              width: 280.w,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.h,),
                  Expanded(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.items.length,
                      itemBuilder: (context,index){
                        return Text("Sent on your Email",textAlign: TextAlign.center, style: TextStyle(fontSize: 18,fontFamily: 'DMSans',),);
                      },
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
                          onPressed: (){
                          },
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
                                onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                            ),
                            child: Text(
                              'Ready',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 15.sp,
                              ),
                            ),
                            onPressed: (){},
                          ),
                        ),
                        IconButton(
                          icon: ImageIcon(AssetImage('assets/icons/scan.png')),
                          iconSize: 30,
                          onPressed: (){
                            scanQRCode();
                          },
                          // color: Colors.red,
                        )
                        // Container(
                        //   width: 140,
                        //   padding: EdgeInsets.fromLTRB(20, 0, 20, 7),
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         elevation: 0,
                        //         shape: StadiumBorder(),
                        //         primary: Color.fromRGBO(188, 157, 255, 1),
                        //         onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                        //     ),
                        //     child: Text(
                        //       'Reorder',
                        //       style: TextStyle(
                        //         fontFamily: 'DMSans',
                        //         fontSize: 15,
                        //       ),
                        //     ),
                        //     onPressed: (){},
                        //   ),
                        // )

                      ]
                  ),
                )

            )


          ],
        ),
      ),
    );
  }
  void scanQRCode() async {
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#BC9DFF', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        getResult = qrCode;
      });
    }catch(e){
      print(e);
    }
  }
}
