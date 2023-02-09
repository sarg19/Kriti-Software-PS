import 'package:flutter/material.dart';
import 'package:kriti/components/bottom_nav_bar.dart';
import 'package:kriti/popups/profilepopup.dart';
class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  PageController controller = PageController(initialPage: 0, keepPage: false);
  static dynamic currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var discountlist = ['1', '2', '3', '4', '5'];
    var categories = ['1', '2', '3', '4'];
    var size = MediaQuery
        .of(context)
        .size;
    var width = size.width;
    var height = size.height;
    return Stack(
      children: [
        Image.asset(
          'assets/images/bgImage1.png',
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
            title: Center(
              child: Container(
                height: 50,
                width: 50,
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
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
            actions: [
              Transform.scale(
                scale: 1.5,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ProfilePopup(),
                    );
                  },
                  icon: const Icon(
                      Icons.account_circle_outlined, color: Colors.black),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  height: 40,
                  child: const TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 5),
                      prefixIcon: Icon(
                          Icons.search_outlined, color: Colors.black),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      hintText: 'Search...',
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(width * 0.06, height / 7.4, 0, 0),
                child: Text("Hello There,Username",
                  style: TextStyle(fontSize: 24, letterSpacing: 2),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, height / 6.3, 0, 0),
                height: height * 0.31,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
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
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: categories.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: ElevatedButton(
                          onPressed: () => print("hello"),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(width / 6),
                            backgroundColor: Colors.white,
                          ), child: null,
                        ),
                      );
                    }),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavBar(),
        ),
      ],

    );
  }
}