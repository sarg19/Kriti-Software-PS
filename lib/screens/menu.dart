import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';
import '../database.dart';

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

  // List testingList = [["Seez Maggi",23],["Aloo Paratha",20]];
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
    db.retrieve_menu(widget.shop_key,widget.collection_name).then((value){
      setState(() {
        shop=value;
        listlength=shop['Menu'].length;
        ShopName=shop['ShopName'];

      });
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
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
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
                    PreferredSize(
                      preferredSize: Size.fromHeight(90),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: w/6),
                            child: Text(
                              ShopName,  //change to ShopName
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'DM-Sans'
                              ),
                            ),
                          ),
                          Visibility(
                            visible: listlength!=0,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: w/6),
                                  child: Text(
                                    'Now open',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'DM-Sans'
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w/3),
                                  child: TextButton(onPressed: (){}, child: Text(
                                      'details',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h/60,
                    ),
                    Container(
                      height: 550,
                      child: ListView.builder(
                        itemCount: listlength,
                        itemBuilder: (context, index) {
                          if(shop['Menu'][index]['Available']==1) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 0),
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
            bottomNavigationBar: const BottomNavBar(),
          ),
        )
      ],
    );
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 249, 240, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        height: h/5.89,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    height: 80,
                    // width: 280,
                    child: Text.rich(
                        TextSpan(
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 20,
                            ),
                            children: [
                              TextSpan(text: widget.name),
                              TextSpan(text: '\n'),
                              TextSpan(text: '\n'),
                              TextSpan(text: "₹ "),
                              TextSpan(text: widget.price.toString()),
                            ]
                        )
                    )
                ),
                Container(
                  height: 30,
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
                height: 60,
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