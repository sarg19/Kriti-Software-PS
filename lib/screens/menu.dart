import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';

class menuscreen extends StatefulWidget {
  const menuscreen({Key? key}) : super(key: key);

  @override
  State<menuscreen> createState() => _menuscreenState();
}

class _menuscreenState extends State<menuscreen> {
  List menuItems = [["Aloo Seez Paratha",20],["Bhezz Fried Rice",25],["Seez Maggi",30],["Duck Curry",50],["Bread Omelette",30],["Chips",10],["Siken Biriyani",160]];
  var _selectedindex = 0,
      size,
      height,
      width;

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
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Scaffold(
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
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                    padding: const EdgeInsets.fromLTRB(70.0,10.0,70.0,10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 40,
                      child: const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 5),
                          prefixIcon: Icon(Icons.search_outlined , color: Colors.black),
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hintText: 'Search...',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 580.5,
                      child: ListView.builder(
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 0),
                            child: MyCard(
                              name: menuItems[index][0],
                              price: menuItems[index][1],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: const BottomNavBar(),
          ),
        )
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  final name;
  int price;

  MyCard({
    this.name = "",
    this.price = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        height: 170,
        child: Column(
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 249, 240, 1.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )
                ),
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                height: 80,
                width: 280,
                child: Text.rich(
                    TextSpan(
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 20,
                        ),
                        children: [
                          TextSpan(text: name),
                          TextSpan(text: '\n'),
                          TextSpan(text: '\n'),
                          TextSpan(text: "₹ "),
                          TextSpan(text: price.toString()),
                        ]
                    )
                )
            ),
            Container(
                height: 60,
                width: 280,
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
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: StadiumBorder(),
                            backgroundColor: Color.fromRGBO(188, 157, 255, 1),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 15,
                            ),
                          ),
                          onPressed: (){},
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
