import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(
  home: Temp(),
)
);
class Temp extends StatefulWidget{
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  int _currentIndex = 0;
  List<String>_Stationary =['Subhansiri','Kapili','Barak','Umiam','Dhansiri','Lohit','Disang','Dihing','Kameng','Brahma','Manas','Core 1','Core 2','Core 3','Core 4'];
  List<String>_Status=['Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open','Open',];
  @override
  Widget build(BuildContext context)
  {
    return Stack(children: [
      Image.asset(
        'assets/images/bgImage1.png',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Padding(
        padding: EdgeInsets.all(0),
        child: Scaffold(
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
                    height: 30,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                                'Market Complex',
                                style: TextStyle(
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
                                'Khokha',
                                style: TextStyle(
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
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                side: BorderSide(
                                  color: Colors.transparent,
                                ),
                                shape: StadiumBorder(),
                              ),
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
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                side: BorderSide(
                                  color: Colors.transparent,
                                ),
                                shape: StadiumBorder(),
                              ),
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                                          color: Colors.white,
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
                            child: GestureDetector(
                              onTap: (){},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromRGBO(188, 157, 255, 1.0),
                                ),
                                height: 40,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 9,bottom: 9,left: 14),
                                        child: Text(
                                          '${_Stationary[index-1]} Canteen',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 9,bottom: 9,right: 14),
                                        child: Text(
                                          '${_Status[index-1]}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
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
          ),
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
      )
    ]);
  }
}