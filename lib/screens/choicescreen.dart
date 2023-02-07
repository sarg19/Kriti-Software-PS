import 'package:flutter/material.dart';

class choicescreen extends StatefulWidget {
  const choicescreen({Key? key}) : super(key: key);

  @override
  State<choicescreen> createState() => _choicescreenState();
}

class _choicescreenState extends State<choicescreen> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return Scaffold(
        body:Stack(
          children: [
            ClipPath(
              clipper: upwardtrapeziumclipper(),
              child: GestureDetector(
                onTap: ()=>print("Owner"),
                child: Container(color: Color.fromRGBO(244, 233, 255, 1.0),
                  // child: Text("Owner",style: TextStyle(color: Color.fromRGBO(
                  // 206, 232, 240, 1.0)),)
                ),
              ),

            ),
            ClipPath(
              clipper: downwardtrapeziumclipper(),
              child: GestureDetector(
                onTap: ()=>print("Customer"),
                child: Container(color: Color.fromRGBO(255, 222, 158, 1.0),
                  // child:Text("Customer",style: TextStyle(color: Color.fromRGBO(
                  //     90, 183, 212, 1.0)),)
                ),
              ),

            ),
            Container(
                padding: EdgeInsets.fromLTRB(width/3,height/3.2,0 ,0),
                child: TextButton(
                  onPressed: ()=>print("Owner"),
                  style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)
                  ),
                  child: Text("Owner",style: TextStyle(
                    color: Color.fromRGBO(1, 1, 1, 1.0),
                    fontSize: size.width*0.10,
                  ),
                  ),
                )
            ),
            Container(
                color: null,
                padding: EdgeInsets.fromLTRB(width/3.6,height*0.85,0 ,0),
                child:TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)
                    ),
                    onPressed:()=>print("Customer"),
                    child: Text("Customer",
                      style: TextStyle(color: Color.fromRGBO(1, 1, 1, 1.0),fontSize: size.width*0.10),))
            ),
          ],
        )
    );
  }
}
class upwardtrapeziumclipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size){
    Path path=Path();
    path.lineTo(size.width,0);
    path.lineTo(size.width, size.height/2.5);
    path.lineTo(0, size.height/1.847);
    return path;

  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)=>true;
}


class downwardtrapeziumclipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size){
    Path path=Path();
    path.moveTo(0,size.height/1.847);
    path.lineTo(size.width,size.height/2.5);
    path.lineTo(size.width,size.height);
    path.lineTo(0, size.height);
    return path;

  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)=>true;
}

