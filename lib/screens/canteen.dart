import 'package:flutter/material.dart';


class Canteen extends StatefulWidget {
  @override
  State<Canteen> createState() => _CanteenState();
}

class _CanteenState extends State<Canteen> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new MyTabbedPage(),
    );
  }
}

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({super.key});

  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<String>_Stationary =['Subhansiri','Kapili','Barak','Umiam','Dhansiri','Lohit','Disang','Dihing','Kameng','Brahma','Manas','Core 1','Core 2','Core 3','Core 4'];
  List<String>_Status=['Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open',];


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
                                  itemCount: _Stationary.length+1,
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
                                                    '${_Stationary[index-1]} Stationary',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    '${_Status[index-1]}',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {},
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
                                  itemCount: _Stationary.length+1,
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
                                                    '${_Stationary[index-1]} Stationary',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    '${_Status[index-1]}',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {},
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
                                  itemCount: _Stationary.length+1,
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
                                                    '${_Stationary[index-1]} Stationary',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    '${_Status[index-1]}',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {},
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
                                  itemCount: _Stationary.length+1,
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
                                                    '${_Stationary[index-1]} Stationary',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    '${_Status[index-1]}',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {},
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
}
