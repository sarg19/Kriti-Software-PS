import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchquery=TextEditingController();
  var discountlist=['1','2','3','4','5'];
  var _selectedindex=0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Row(
              children:[
                const SizedBox(width:20),
                SizedBox(
                  width: 300,
                  height: 40,
                  child: TextField(
                    controller: searchquery,
                    style: const TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.blueAccent),
                      prefixIcon:const Icon(Icons.search, color: Colors.blue,),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 5),
                      ),
                      filled: true,
                      fillColor: Colors.lightBlue[50],
                      hintText: 'Search',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.shopping_cart,color:Colors.white),
                    )
                ),
              ]
          ),
          const SizedBox(height: 15,),
          Row(
            children: [
              const SizedBox(width: 20,),
              Container(
                alignment: Alignment.centerLeft,
                child:Text(
                  'Hi User,',
                  style:TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue[500]
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15,),
          SizedBox(
            width:double.infinity,
            height:200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                if(discountlist==null){
                  return const CircularProgressIndicator();
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width:340,
                        height: 200,
                        padding: const EdgeInsets.fromLTRB(15, 0,0, 0),
                        child: ListTile(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          tileColor: Colors.blue,
                          title: ClipRRect(
                            child:InkWell(
                              onTap: (){},
                              child: const Text(""),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: discountlist==null? 0:discountlist.length,
              separatorBuilder: (context,index){
                return const SizedBox(height: 30,);
              },
            ),
          ),
          const SizedBox(height: 15,),
          SizedBox(
            height: 260,
            child: GridView.count(crossAxisCount: 2,
              padding:const EdgeInsets.all(20),
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              childAspectRatio:1.5,
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle,color:Colors.blue ),
                  child:const Text(""),
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle,color:Colors.green,),
                  child:const Text(""),
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color:Colors.yellow,),
                  child:const Text(""),
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle,color:Colors.grey,),
                  child:const Text(""),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_rounded),
            label: "Food",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label:"Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label:"Account",
          ),
        ],

        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.blue[600],
        backgroundColor: Colors.blue[500],
        elevation: 10,
        currentIndex: _selectedindex,
        onTap: _onItemTapped,
      ),
    );
  }
}
