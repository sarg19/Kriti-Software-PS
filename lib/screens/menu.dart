import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/popups/profilepopup.dart';
import 'package:kriti/popups/shopdetailspopup.dart';
import 'package:kriti/popups/shopkeeperProfilePopup.dart';
import 'package:kriti/screens/customertabs.dart';
import '../components/bottom_nav_bar.dart';
import '../database.dart';
import '../popups/showPopUp.dart';

class menuscreen extends StatefulWidget {
  String shop_key;
  String collection_name;
  menuscreen({Key? key,this.shop_key="",this.collection_name=""}) : super(key: key);

  @override
  State<menuscreen> createState() => _menuscreenState();
}

class _menuscreenState extends State<menuscreen> {
  var size,
      height,
      width;
  var listlength=0;
  String status="Open";
  // List testingList = [["Seez Maggi",23],["Aloo Paratha",20]];
  late Timer timer;
  late Databases db;
  String ShopName="";
  Map shop={};
  initialise(){
    db=Databases();
    db.initialise();
  }
  @override
  void initState(){
    super.initState();
    initialise();
    timer= Timer.periodic(const Duration(milliseconds: 100), (timer) {
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
        Scaffold(
          backgroundColor: Colors.transparent,
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
                    builder: (context) => const ShowPopUp(
                      widgetcontent: Profile(),
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
          body: Center(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                  padding: EdgeInsets.fromLTRB(70.0.w,10.0.h,70.0.w,10.0.h),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    height: 40.h,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0, 7.h, 0, 5.h),
                        prefixIcon: const Icon(Icons.search_outlined , color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hintText: 'Search...',
                        ),
                      ),
                    ),
                  ),
                  PreferredSize(
                    preferredSize: Size.fromHeight(90.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w/6),
                          child: Text(
                            ShopName,  //change to ShopName
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontFamily: 'DM-Sans'
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: w/6),
                              child: Text(
                                'Now $status',
                                style: TextStyle(
                                    color: const Color.fromRGBO(114, 114, 114, 1.0),
                                    fontSize: 15.sp,
                                    fontFamily: 'DM-Sans'
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: w/3),
                              child: TextButton(onPressed: (){
                                showDialog(context: context, builder: (BuildContext context){
                                  return const ShowPopUp(widgetcontent: ShopDetails(),);
                                });
                              }, child: Text(
                                  'details',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.sp,
                                ),
                              )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h/60,
                  ),
                  SizedBox(
                    height: 550.h,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: listlength,
                      itemBuilder: (context, index) {
                        if(shop['Menu'][index]['Available']==1) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            child: MyCard(
                              name: shop['Menu'][index]['Name'],
                              price: shop['Menu'][index]['Price'],
                            ),
                          );
                        }else{
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
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
        )
      ],
    );
  }
  Future<void> Reload()async{
    db.retrieve_menu(widget.shop_key,widget.collection_name).then((value){
      if(!mounted){
        return;
      }
      setState(() {
        shop=value;
        listlength=shop['Menu'].length;
        ShopName=shop['ShopName'];
        status=shop['open']==1?"Open":"Close";
        listlength=shop['open']==1?listlength:0;
      });
    });
  }
}

class MyCard extends StatefulWidget {
  final name;
  int price;

  MyCard({
    this.name = "",
    this.price = 0,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 60.w),
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 249, 240, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5.h),
        height: h/5.89,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 0, 0),
                    height: 80.h,
                    // width: 280,
                    child: Text.rich(
                        TextSpan(
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 20.sp,
                            ),
                            children: [
                              TextSpan(text: widget.name),
                              const TextSpan(text: '\n'),
                              // TextSpan(text: '\n'),
                              const TextSpan(text: "₹ "),
                              TextSpan(text: widget.price.toString()),
                            ]
                        )
                    )
                ),
                SizedBox(
                  height: 30.h,
                  // width: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.black : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                height: 55.h,
                // width: 280,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 249, 240, 1.0),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)
                    )
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10.w, 10.h),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const StadiumBorder(),
                            backgroundColor: const Color.fromRGBO(188, 157, 255, 1),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 15.sp,
                            ),
                          ),
                          onPressed: (){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Item added to cart.")));
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