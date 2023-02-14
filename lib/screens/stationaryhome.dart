import 'package:flutter/material.dart';

class StationaryHomePage extends StatefulWidget {
  const StationaryHomePage({Key? key}) : super(key: key);

  @override
  State<StationaryHomePage> createState() => _StationaryHomePage();
}

class _StationaryHomePage extends State<StationaryHomePage> {
  var selected=0;
  var size, height, width;
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
        Scaffold(
          backgroundColor: Colors.transparent,
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
              onPressed: () {
                setState(() {
                  selected = 1 - selected;
                });
              },
              icon: selected==1
                  ?ImageIcon(AssetImage('assets/icons/Toggle-off.png'),color: Colors.black,)
                  :ImageIcon(AssetImage('assets/icons/Toggle-on.png'),color: Colors.black,),
            ),
            actions: [
              Transform.scale(
                scale: 1.5,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle_outlined,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                children: [
                  SizedBox(height: 20,),

                  Center(child: Text("Subansiri Stationary",style:TextStyle(fontSize: 37,fontWeight: FontWeight.bold,))),
                  Text("Now closed",textAlign: TextAlign.left,style: TextStyle(fontSize: 20,color: Color.fromRGBO(
                      114, 114, 114, 1.0)),),
                  SizedBox(height: 50,),
                  Text("23004cxcx",style: TextStyle(fontSize: 22),),
                  SizedBox(height: 30,),
                  Text("abshhh",style: TextStyle(fontSize: 22),),
                  SizedBox(height: 20,),
                  Text("987652xx",style: TextStyle(fontSize: 22),),
                  SizedBox(height: 25,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: StadiumBorder(),
                            primary: Color.fromRGBO(188, 157, 255, 1),
                            onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 16,
                          ),
                        ),
                        onPressed: (){},
                      ),
                      Container(
                        width: 110,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: StadiumBorder(),
                              primary: Color.fromRGBO(188, 157, 255, 1),
                              onPrimary: Color.fromRGBO(255, 255, 255, 1.0)
                          ),
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 16,
                            ),
                          ),
                          onPressed: (){},
                        ),
                      ),
                    ],
                  )
                ],


              ),
            ),
          ),

        ),
      ],
    );
  }
}

