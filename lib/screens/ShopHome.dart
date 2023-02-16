import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/bottom_nav_bar.dart';
import '../components/bottomnavbarshop.dart';
class ShopHome extends StatefulWidget {
  const ShopHome({super.key});

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<ShopHome> {
  int _currentIndex = 0;
  bool _isopen = true;
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.values,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'Subansiri Canteen',
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    _isopen? 'Now Open' : 'Now Closed',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Color.fromRGBO(114, 114, 114, 1.0),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Center(
                    child: Container(
                      alignment: const Alignment(0,-1),
                      height: 98.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: SizedBox.expand(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                            shape: StadiumBorder(),
                          ),
                          child: Text(
                            'Add Offer',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Color.fromRGBO(114, 114, 114, 1.0),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Container(
                      alignment: const Alignment(0,-1),
                      height: 43.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: Center(
                        child: Text(
                          "Today's Earning is Rs.500",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                    height: 250.h,
                    width: 250.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(244, 233, 255, 1.0),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              );
  }
}
