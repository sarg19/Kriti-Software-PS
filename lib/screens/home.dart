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
    db.retrieve_user_info(FirebaseAuth.instance.currentUser?.uid).then((value){
      setState((){
        Name=value['Name'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var discountlist = ['1', '2', '3', '4', '5'];
    var categories = ['Food', 'Stationary', 'Juice center', 'Others'];
    var nextscreens = [const MyTabbedPage(), const StationaryScreen(), const JuiceCenter(), const Misc()];
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(70.0.w, 10.0.h, 70.0.w, 10.0.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            height: 40.h,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 7.h, 0, 5.h),
                prefixIcon:
                    const Icon(Icons.search_outlined, color: Colors.black),
                border: InputBorder.none,
                fillColor: Colors.white,
                hintText: 'Search...',
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(width * 0.06, height / 7.4, 0, 0),
          child: Text(
            "Hello There, "+Name,
            style: TextStyle(fontSize: 24.sp, letterSpacing: 2),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, height / 6.3, 0, 0),
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
          margin: EdgeInsets.fromLTRB(0, height / 2.2, 0, 0),
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: categories.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => nextscreens[index]));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(width / 6),
                      backgroundColor: Colors.white,
                    ),
                    child: null,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
