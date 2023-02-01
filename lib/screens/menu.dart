import 'package:flutter/material.dart';

// void main()=>{
//   runApp(MaterialApp(
//       home: menuscreen()
//   ))
// };
class menuscreen extends StatefulWidget {
  const menuscreen({Key? key}) : super(key: key);

  @override
  State<menuscreen> createState() => _menuscreenState();
}

class _menuscreenState extends State<menuscreen> {
  var _selectedindex = 0,
      size,
      height,
      width;
  var menulistitemname = ['1', '2', '3', '4', '5','6','7','8','9','10'],
      menulistitemprice = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:  Stack(
            children: [
              ListTile(
                title: Text("Kapili Canteen",style: TextStyle(fontSize: 20,letterSpacing: 1,fontWeight:FontWeight.bold,color: Colors.blue[300]),),
                subtitle: Text("Now Open"),
              ),
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  margin: EdgeInsets.fromLTRB((width*75)/100, height/60, 0, 0),
                  child: IconButton
                    (onPressed: (){}, icon: Icon(Icons.shopping_cart,color: Colors.white,))),
            ],
          ),
          shadowColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding:EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: ListView.separated(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (menulistitemname == null) {
                  return CircularProgressIndicator();
                }
                return Stack(
                  children: [
                    Container(
                      width: (width*98)/100,
                      height: (height*9)/100,
                      padding: EdgeInsets.fromLTRB(width/12, 0, width/12, 0),
                      child: ListTile(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.blue[200],
                        title: Text("Seez Maggi",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        subtitle: Text("Rs 20",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                      ),
                    ),
                    Container(
                      margin:EdgeInsets.fromLTRB((width*55)/100, (height*2)/100, 0, 0),
                      child: ElevatedButton(
                        onPressed: (){},
                        child: Text("Add to Cart",style: TextStyle(color:Colors.white,),),
                      ),
                    )
                  ],
                );
              },
              itemCount: menulistitemname == null ? 0 : menulistitemname.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 30,);
              },
            ),
          ),
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
              label: "Favourites",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "Account",
            ),
          ],

          selectedItemColor: Colors.blue[800],
          unselectedItemColor: Colors.blue[600],
          backgroundColor: Colors.blue[500],
          elevation: 10,
          currentIndex: _selectedindex,
          onTap: _onItemTapped,

        )
    );
  }
}
