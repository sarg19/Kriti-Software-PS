import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/bottom_nav_bar.dart';
import '../database.dart';

class favouritesscreen extends StatefulWidget {
  const favouritesscreen({Key? key}) : super(key: key);

  @override
  State<favouritesscreen> createState() => _favouritesscreenState();
}

class _favouritesscreenState extends State<favouritesscreen> {
  var size;
  var listlength = 0;
  late Databases db;
  Map Favouites = {};

  initialise() {
    db = Databases();
    db.initialise();
  }

  @override
  void initState() {
    super.initState();
    initialise();
    db.retrieve_user_info("01li51cY9718Ns75HOa9").then((value) {
      setState(() {
        Favouites = value;
        listlength = Favouites['Favourites'].length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Center(
      child: Column(
        children: [
          Center(
            child: Container(
              // decoration: BoxDecoration(
              //     border: Border.all(color: Colors.black)
              // ),
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text("Favourites",
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w400)),
            ),
          ),
          // SizedBox(
          //   height: 10.h,
          // ),
          Container(
            height: 560.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: listlength,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: FavouritesCard(
                    name: Favouites['Favourites'][index]['Item_Name'],
                    price: Favouites['Favourites'][index]['Price'],
                    shopName: Favouites['Favourites'][index]['Shop_Name'],
                    Shop_Key: Favouites['Favourites'][index]['Shop_Key'],
                    db: db,
                  ),
                );
                // if(Menu['menu'][index]['Available']==1) {
                //   return Container(
                //     margin: EdgeInsets.only(bottom: 20, top: 20),
                //     child: FavouritesCard(
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
    );
  }
}

class FavouritesCard extends StatelessWidget {
  final String name;
  num price;
  final String shopName;
  final String Shop_Key;
  Databases db;

  FavouritesCard(
      {this.name = "",
      this.price = 0,
      this.shopName = "",
      this.Shop_Key = "",
      required this.db});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        height: 200.h,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(188, 157, 255, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              height: 60.h,
              width: 280.w,
              child: Center(
                child: Text(
                  shopName,
                  style: TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 249, 240, 1.0),
                ),
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                height: 80.h,
                width: 280.w,
                child: Text.rich(TextSpan(
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 20.sp,
                    ),
                    children: [
                      TextSpan(text: name),
                      const TextSpan(text: '\n'),
                      // const TextSpan(text: '\n'),
                      const TextSpan(text: "₹ "),
                      TextSpan(text: price.toString()),
                    ]))),
            Container(
                height: 60.h,
                width: 280.w,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 249, 240, 1.0),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: StadiumBorder(),
                        backgroundColor: Color.fromRGBO(188, 157, 255, 1),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 15.sp,
                        ),
                      ),
                      onPressed: () {
                        db.Add_to_Cart(name, price, Shop_Key, shopName,
                            "01li51cY9718Ns75HOa9");
                      },
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
