import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/components/bottom_nav_bar.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/screens/Stationary.dart';
import 'package:kriti/screens/canteen.dart';
import 'package:kriti/screens/juicecenter.dart';
import 'package:kriti/screens/miscellaneous.dart';
import '../database.dart';
import '../popups/profilepopup.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  PageController controller = PageController(initialPage: 0, keepPage: false);
  static dynamic currentPageValue = 0.0;
  String Name="User";
  late Timer timer;
  final SearchController = TextEditingController();
  late Databases db;
  initialise() {
    db = Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });
    initialise();
    timer=Timer.periodic(const Duration(milliseconds: 100), (timer) {
      Reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    var discountlist = ['1', '2', '3', '4', '5'];
    var categories = ['Food', 'Stationary', 'Grocery', 'Miscellaneous'];
    var nextscreens = [const MyTabbedPage(), const StationaryScreen(), const JuiceCenter(), const Misc()];
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    List imagelist =['assets/icons/food.png.png','assets/icons/printer.png','assets/icons/grocery and juice.png','assets/icons/more-horizontal.png'];
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(width * 0.06, 20.h, 0, 0),
          child: Text(
            "Hello There, $Name",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 24.sp, letterSpacing: 2),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 50.h, 0, 0),
          height: height * 0.31,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: height * 0.27,
                width: width * 0.80,
              );
            },
            pageSnapping: true,
            controller: controller,
            itemCount: discountlist == null ? 0 : discountlist.length,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(30.w, 350.h, 30.w, 0),
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 32),
              itemCount: categories.length,
              itemBuilder: (BuildContext ctx, index) {
                return Column(
                  children: [
                    Container(
                      height: 50.h,
                      width: 100.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(188, 157, 255, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        // shape: BoxShape.circle,
                      ),

                      child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => nextscreens[index]));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.all(width / 6),

                        ),
                        icon: Image.asset(imagelist[index],color: Colors.white,scale: 0.1),
                      ),
                    ),
                    Text(categories[index],style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15.sp),),
                  ],
                );
              }),
        ),
      ],
    );
  }
  Future<void> Reload() async {
    db.retrieve_user_info(FirebaseAuth.instance.currentUser?.uid).then((value){
      if(!mounted){
        timer.cancel();
        return;
      }
      setState((){
        Name=value['Name'];
      });
    });
  }
}
