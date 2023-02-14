import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kriti/screens/menu.dart';

import '../database.dart';



class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({super.key});

  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> with TickerProviderStateMixin {
  late List marketcomplexshop;
  late List khokhashop;
  late List foodcourtshop;
  late List canteenshop;
  int marketcomplexsize=0;
  int khokhasize=0;
  int foodcourtsize=0;
  int canteensize=0;
  late Databases db;
  late Timer timer;
  initialise(){
    db=Databases();
    db.initialise();
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      Reload();
    });
    // db.create_food_shop("Aicy7Z7TrkJHVgwxrADB", "food-foodcourt", "Gholap Sarjerao", "sarvesh@gmail.com", "Bajerao since 1947", 1234567890, 'Food Court', 'Food');

  }
  @override
  void initState() {
    super.initState();
    initialise();
  }
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Stack(
          children:[
            Image.asset(
              'assets/images/bgImage1.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Center(
                    child: Container(
                      height:50,
                      width:50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),

                      child: Image(
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
                    physics: NeverScrollableScrollPhysics(),
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
                            child: TextField(
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
                        SizedBox(
                          height: 70,
                          child: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 100.0,
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(65),
                              child: TabBar(
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                tabs:
                                [
                                  Container(
                                    alignment: const Alignment(0,-1),
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromRGBO(188, 157, 255, 1.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: SizedBox.expand(
                                      child: const Center(
                                        child: Text(
                                          'Market Complex',
                                          style: TextStyle(
                                            wordSpacing: 3,
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: const Alignment(0,-1),
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromRGBO(188, 157, 255, 1.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: SizedBox.expand(
                                      child: const Center(
                                        child: Text(
                                          'Khokha',
                                          style: TextStyle(
                                            wordSpacing: 3,
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: const Alignment(0,-1),
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromRGBO(188, 157, 255, 1.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: SizedBox.expand(
                                      child: const Center(
                                        child: Text(
                                          'Food  Court',
                                          style: TextStyle(
                                            wordSpacing: 3,
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: const Alignment(0,-1),
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromRGBO(188, 157, 255, 1.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: SizedBox.expand(
                                      child: const Center(
                                        child: Text(
                                          'Canteen',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height:height*0.571,
                          child: TabBarView(
                            children: [
                              Container(
                                height: height*0.571,
                                child: ListView.builder(
                                  itemCount: marketcomplexsize+1,
                                  itemBuilder: (BuildContext context, int index)
                                  {
                                    if(index==0)
                                    {
                                      return Column(
                                        children: [
                                          Text(
                                            'Trending in Market Complex',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            width:width*0.89,
                                            height : 150,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 5,
                                              itemBuilder: (BuildContext context,int ind)
                                              {
                                                return Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Container(
                                                    height: 141,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Color.fromRGBO(188, 157, 255, 1.0),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else
                                    {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Color.fromRGBO(188, 157, 255, 1.0),
                                          ),
                                          height: 40,
                                          child: OutlinedButton(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    marketcomplexshop[index-1]['Name'],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    marketcomplexshop[index-1]['open']==1?'Open':'Close',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              if(marketcomplexshop[index-1]['open']==1){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>menuscreen(shop_key: marketcomplexshop[index-1]['id'],collection_name: "food-marketcomplex")));
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Container(
                                height: 420,
                                child: ListView.builder(
                                  itemCount: khokhasize+1,
                                  itemBuilder: (BuildContext context, int index)
                                  {
                                    if(index==0)
                                    {
                                      return Column(
                                        children: [
                                          Text(
                                            'Trending in Khokha',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            width:350,
                                            height : 150,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 5,
                                              itemBuilder: (BuildContext context,int ind)
                                              {
                                                return Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Container(
                                                    height: 141,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Color.fromRGBO(188, 157, 255, 1.0),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else
                                    {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Color.fromRGBO(188, 157, 255, 1.0),
                                          ),
                                          height: 40,
                                          child: OutlinedButton(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    khokhashop[index-1]['Name'],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    khokhashop[index-1]['open']==1?'Open':'Close',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              if(khokhashop[index-1]['open']==1){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>menuscreen(shop_key: khokhashop[index-1]['id'],collection_name: "food-khokha")));
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Container(
                                height: 420,
                                child: ListView.builder(
                                  itemCount: foodcourtsize+1,
                                  itemBuilder: (BuildContext context, int index)
                                  {
                                    if(index==0)
                                    {
                                      return Column(
                                        children: [
                                          Text(
                                            'Trending in Food Court',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            width:350,
                                            height : 150,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 5,
                                              itemBuilder: (BuildContext context,int ind)
                                              {
                                                return Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Container(
                                                    height: 141,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Color.fromRGBO(188, 157, 255, 1.0),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else
                                    {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Color.fromRGBO(188, 157, 255, 1.0),
                                          ),
                                          height: 40,
                                          child: OutlinedButton(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    foodcourtshop[index-1]['Name'],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    foodcourtshop[index-1]['open']==1?'Open':'Close',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              if(foodcourtshop[index-1]['open']==1){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>menuscreen(shop_key: foodcourtshop[index-1]['id'],collection_name: "food-foodcourt")));
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Container(
                                height: 420,
                                child: ListView.builder(
                                  itemCount: canteensize+1,
                                  itemBuilder: (BuildContext context, int index)
                                  {
                                    if(index==0)
                                    {
                                      return Column(
                                        children: [
                                          Text(
                                            'Trending in Canteen',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            width:350,
                                            height : 150,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 5,
                                              itemBuilder: (BuildContext context,int ind)
                                              {
                                                return Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Container(
                                                    height: 141,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Color.fromRGBO(188, 157, 255, 1.0),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    else
                                    {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Color.fromRGBO(188, 157, 255, 1.0),
                                          ),
                                          height: 40,
                                          child: OutlinedButton(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    canteenshop[index-1]['Name'],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    canteenshop[index-1]['open']==1?'Open':'Close',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              if(canteenshop[index-1]['open']==1){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>menuscreen(shop_key: canteenshop[index-1]['id'],collection_name: "food-canteen")));
                                              }
                                              },
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),


                // new TabBarView(
                //   controller: tabController,
                //   children: myTabs.map((Tab tab) {
                //     return new Center(child: new Text(tab.text!));
                //   }).toList(),
                // ),
                // floatingActionButton: new FloatingActionButton(
                //   onPressed: () => tabController.animateTo((tabController.index + 1) % 2), // Switch tabs
                //   child: new Icon(Icons.swap_horiz),
                // ),
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: const Color.fromRGBO(219, 202, 255, 1.0),
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black54,
                  selectedFontSize: 0,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: Container(
                        margin: const EdgeInsets.all(8.0),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: _currentIndex == 0 ? const Color.fromRGBO(164, 146, 203, 1.0) : Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: IconButton(
                          icon: const ImageIcon(AssetImage('assets/icons/home.png')),
                          onPressed: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                          },
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        margin: const EdgeInsets.all(8.0),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: _currentIndex == 1 ? const Color.fromRGBO(164, 146, 203, 1.0) : Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: IconButton(
                          icon: const ImageIcon(AssetImage('assets/icons/bag.png')),
                          onPressed: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                          },
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        margin: const EdgeInsets.all(8.0),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: _currentIndex == 2 ? const Color.fromRGBO(164, 146, 203, 1.0) : Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: IconButton(
                          icon: const ImageIcon(AssetImage('assets/icons/favorite.png')),
                          onPressed: () {
                            setState(() {
                              _currentIndex = 2;
                            });
                          },
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        margin: const EdgeInsets.all(8.0),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: _currentIndex == 3 ? const Color.fromRGBO(164, 146, 203, 1.0) : Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: IconButton(
                          icon: const ImageIcon(AssetImage('assets/icons/cart.png')),
                          onPressed: () {
                            setState(() {
                              _currentIndex = 3;
                            });
                          },
                        ),
                      ),
                      label: '',
                    ),
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }
  Future<void> Reload() async {
    db.getfoodshop('food-marketcomplex').then((value){
      setState((){
        marketcomplexshop=value;
        marketcomplexsize=marketcomplexshop.length;
      });
    });
    db.getfoodshop('food-canteen').then((value){
      setState((){
        canteenshop=value;
        canteensize=canteenshop.length;
      });
    });
    db.getfoodshop('food-foodcourt').then((value){
      setState((){
        foodcourtshop=value;
        foodcourtsize=foodcourtshop.length;
      });
    });
    db.getfoodshop('food-khokha').then((value){
      setState((){
        khokhashop=value;
        khokhasize=khokhashop.length;
      });
    });
  }
}
