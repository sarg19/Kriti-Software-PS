import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:kriti/popups/removeconformationPopup.dart';
import 'package:kriti/screens/orderstatus.dart';
import '../database.dart';
import '../popups/showPopUp.dart';

class cartscreen extends StatefulWidget {
  const cartscreen({Key? key}) : super(key: key);

  @override
  State<cartscreen> createState() => _cartscreenState();
}

class _cartscreenState extends State<cartscreen> {
  int _currentIndex = 0;
  var cartitemname = [
    'Seez Maggi',
    'Seez Maggi',
    'Paratha',
    'Seez Maggi',
    'Seez Maggi',
    'Paratha'
  ];
  var cartitemprice = ['100', '100', '50', '100', '100', '50'];
  var cartitemnumber = ['01', '01', '01', '01', '01', '01'];
  var canteenname = [
    'Subansiri Canteen',
    'Kapili Canteen',
    'Lohit Canteen',
    'Barak Canteen',
    'Manas Canteen',
  ];
  int itemlength = 0;
  String dropdownvalue = '';
  var currentprice = 0;
  late Databases db;
  late Map user_data;
  int ind = 0;
  var canteen = [];
  num total = 0;
  late Timer timer;
  int counter=0;
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
        counter=1;
        user_data = value;
        for (Map item in user_data['Cart']) {
          canteen.add(item['Shop_Name']);
        }
        if(value['Cart'].length==0){
          itemlength=0;
          dropdownvalue='';
          total=0;
        }else{
          itemlength = value['Cart'][0]['Items'].length;
          dropdownvalue = canteen[0];
          total = value['Cart'][0]['Total_Amount'];
        }
      });
    });
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      Reload();
    });
  }

  void getprice() {
    currentprice = 0;
    for (var i = 0; i < cartitemprice.length; i++) {
      currentprice = currentprice +
          int.parse(cartitemprice[i]) * int.parse(cartitemnumber[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    getprice();
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(8, 20, 0, 20),
            child: Text("Cart",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w300)),
          ),
        ),
        Container(
          height: height * 0.07,
          width: width * 0.8,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(188, 157, 255, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              items: canteen
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 25.sp,
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        ),
                      ))
                  .toList(),
              value: dropdownvalue,
              onChanged: (value) {
                setState(() {
                  ind = canteen.indexOf(value as String);
                  dropdownvalue = value as String;
                  itemlength = user_data['Cart'][ind]['Items'].length;
                  total = user_data['Cart'][ind]['Total_Amount'];
                });
              },
              dropdownDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromRGBO(188, 157, 255, 1.0),
              ),
              iconOnClick: Icon(Icons.arrow_drop_up, color: Colors.white),
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              dropdownWidth: width * 0.7,
              buttonHeight: 40,
              buttonWidth: width * 0.8,
              itemHeight: 40,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromRGBO(255, 249, 240, 1.0),
                    ),
                    height: height * 0.1,
                    margin:
                        EdgeInsets.fromLTRB(width * 0.11, 10, width * 0.11, 0),
                    child: Stack(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(width * 0.0636,
                                height * 0.017, 0, height * 0.0235),
                            child: Text(
                                user_data['Cart'][ind]['Items'][index]
                                    ['Item_Name'],
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ))),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                width * 0.0636, height * 0.049, 0, 0),
                            child: Text(
                              "Rs. " +
                                  user_data['Cart'][ind]['Items'][index]
                                          ['Price']
                                      .toString(),
                              style: TextStyle(fontSize: 20.sp),
                            )),
                        Container(
                          width: width * 0.09669,
                          height: height * 0.047,
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color.fromRGBO(188, 157, 255, 1.0),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              )),
                          margin: EdgeInsets.fromLTRB(width * 0.40, 20, 0, 0),
                          padding:
                              EdgeInsets.fromLTRB(0, 0, 0, height * 0.00336),
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                            ),
                            child: Center(
                                child: Text("+",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.sp))),
                            onPressed: () {
                              setState(() {
                                db.incrementcart(ind, index, user_data['Cart'],
                                FirebaseAuth.instance.currentUser?.uid);
                              });
                            },
                          ),
                        ),
                        Container(
                          width: width * 0.09669,
                          height: height * 0.047,
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color.fromRGBO(188, 157, 255, 1.0),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )),
                          padding:
                              EdgeInsets.fromLTRB(0, 0, 0, height * 0.00783),
                          margin: EdgeInsets.fromLTRB(width * 0.6361, 20, 0, 0),
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                            ),
                            child: Center(
                                child: Text("-",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.sp))),
                            onPressed: () {
                              setState(() {
                                if(user_data['Cart'][ind]['Items'][index]['Quantity']==1){
                                  showDialog(context: context, builder: (BuildContext context){
                                    return ShowPopUp(widgetcontent: RemoveItem(),);
                                  });
                                }else{
                                  db.decrementcart(ind, index, user_data['Cart'],
                                      FirebaseAuth.instance.currentUser?.uid);
                                }
                              });
                            },
                          ),
                        ),
                        Container(
                          width: width * 0.09669,
                          height: height * 0.047,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromRGBO(188, 157, 255, 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.fromLTRB(width * 0.5216, 20, 0, 0),
                          padding:
                              EdgeInsets.fromLTRB(0, 0, 0, height * 0.00336),
                          child: Center(
                              child: Text(
                                  user_data['Cart'][ind]['Items'][index]
                                          ['Quantity']
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 15.h,
                  ),
                  itemCount: itemlength,
                ),
                Container(
                    height: height * 0.05,
                    width: width * 0.78,
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(255, 249, 240, 1.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Total:Rs. " + total.toString(),
                      style: TextStyle(
                          color: Color.fromRGBO(58, 58, 58, 1.0),
                          fontSize: 20.sp),
                    )),
                Container(
                    height: height * 0.05,
                    width: width * 0.5,
                    margin: EdgeInsets.fromLTRB(0, 35, 0, 10),
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(188, 157, 255, 1.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Add more items",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1.0),
                          fontSize: 20.sp),
                    )),
                Container(
                    height: height * 0.05,
                    width: width * 0.5,
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(188, 157, 255, 1.0),
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      child: Text("Request Order",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                              fontSize: 20.sp)),
                      onPressed: () {
                        if(counter==1 && canteen.isNotEmpty){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderStatusScreen()));
                          db.Request_Order(FirebaseAuth.instance.currentUser?.uid, user_data['Cart'][ind]['Shop_Key'], user_data['Cart'][ind]['Collection']);
                        }
                      },
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> Reload() async {
    db.retrieve_user_info(FirebaseAuth.instance.currentUser?.uid).then((value) {
      if(!mounted){
        return;
      }
      setState(() {
        user_data = value;
        for (Map item in user_data['Cart']) {
          if (!canteen.contains(item['Shop_Name'])) {
            canteen.add(item['Shop_Name']);
          }
        }
        if(value['Cart'].length==0){
          itemlength=0;
          total=0;
        }else{
          itemlength = value['Cart'][ind]['Items'].length;
          total = value['Cart'][ind]['Total_Amount'];
        }
      });
    });
  }
}
