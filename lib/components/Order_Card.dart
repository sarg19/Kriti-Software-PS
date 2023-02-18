import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List GrandList=[["aloo seez","dvhjfs","dhdj"],["dgcjsgf","dhckjsfh","chd", "vy"]];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: GrandList.length,
          itemBuilder: (BuildContext context, int index){
            return MyCard(items: GrandList[index],);
          }
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final List<String> items;

  MyCard({this.items=const []});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        // width: 280,
        height: items.length*25+145,
        // decoration: BoxDecoration(
        //   color: Color.fromRGBO(255, 249, 240, 1.0),
        //   borderRadius: BorderRadius.circular(15),
        // ),
        child: Column(
          children: [
            Container(
              //padding: EdgeInsets.fromLTRB(20, 0, right, bottom),
              height: 55,
              width: 280,
              padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(188, 157, 255, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
              ),
              child: const Text(
                'Kapili Canteen',
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans'
                ),
              ),

            ),
            Container(
              color: Color.fromRGBO(255, 249, 240, 1.0),
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              height: items.length*25+35,
              // height: items.length == 1 ? 60 : items.length*33,
              width: 280,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context,index){
                        return Text(items[index], style: TextStyle(fontSize: 18,fontFamily: 'DMSans'),);
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: 55,
                width: 280,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 249, 240, 1.0),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)
                    )
                ),
                child: Row(
                    children: [
                      Container(
                        width: 140,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 7),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: StadiumBorder(),
                              primary: Color.fromRGBO(188, 157, 255, 1),
                              onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                          ),
                          child: Text(
                            'Review',
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 15,
                            ),
                          ),
                          onPressed: (){},
                        ),
                      ),
                      Container(
                        width: 140,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 7),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: StadiumBorder(),
                              primary: Color.fromRGBO(188, 157, 255, 1),
                              onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                          ),
                          child: Text(
                            'Reorder',
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
