import 'package:flutter/material.dart';
import 'package:kriti/screens/welcomescreen2.dart';
import 'package:kriti/screens/welcomscreen.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return Scaffold(
        body:Stack(
          children: [
            ClipPath(
              clipper: UpwardTrapeziumClipper(),
              child: InkWell(
                highlightColor: const Color.fromRGBO(255, 222, 158, 1.0),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopkeeperWelcomeScreen()));
                },
                child: Container(color: const Color.fromRGBO(244, 233, 255, 1.0),
                  // child: Text("Owner",style: TextStyle(color: Color.fromRGBO(
                  // 206, 232, 240, 1.0)),)
                ),
              ),

            ),
            ClipPath(
              clipper: DownwardTrapeziumClipper(),
              child: InkWell(
                splashColor: const Color.fromRGBO(244, 233, 255, 1.0),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerWelcomeScreen()));
                },
                child: Container(color: const Color.fromRGBO(255, 222, 158, 1.0),
                  // child:Text("Customer",style: TextStyle(color: Color.fromRGBO(
                  //     90, 183, 212, 1.0)),)
                ),
              ),

            ),
            Container(
                padding: EdgeInsets.fromLTRB(width/3,height/4,0 ,0),
                child: TextButton(
                  onPressed: () {
                    // print("Owner");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopkeeperWelcomeScreen()));
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)
                  ),
                  child: Text("Owner",style: TextStyle(
                    color: const Color.fromRGBO(1, 1, 1, 1.0),
                    fontSize: size.width*0.10,
                  ),
                  ),
                )
            ),
            Container(
                color: null,
                padding: EdgeInsets.fromLTRB(width/3.6,height*0.70,0 ,0),
                child:TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent)
                    ),
                    onPressed:() {
                      // print("Customer");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerWelcomeScreen()));
                    },
                    child: Text("Customer",
                      style: TextStyle(color: const Color.fromRGBO(1, 1, 1, 1.0),fontSize: size.width*0.10),))
            ),
          ],
        )
    );
  }
}
class UpwardTrapeziumClipper extends CustomClipper<Path>{

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


class DownwardTrapeziumClipper extends CustomClipper<Path>{

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

