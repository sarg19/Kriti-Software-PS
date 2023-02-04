import 'package:flutter/material.dart';
void main()=>{
  runApp(MaterialApp(
      home: homescreen()
  ))
};

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  PageController controller =PageController(initialPage: 0,keepPage: false);
  static dynamic currentPageValue = 0.0;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var discountlist = ['1','2','3','4','5'];
    var categories=['1','2','3','4'];
    var size=MediaQuery.of(context).size;
    var width=size.width;
    var height=size.height;
    return Stack(
      children: [
        Image.asset(
          'assests/bgImage1.png',
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body:Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(width*0.06, height/4.9, 0, 0),
                child: Text("Hello There,Username",style: TextStyle(fontSize: 24,letterSpacing: 2),),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(0, height/4.5, 0, 0),
                height: height*0.31,
                child:PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      height: height*0.27,
                      width:width*0.80,
                    );
                  },
                  pageSnapping: true,
                  controller: controller,
                  itemCount: discountlist==null? 0:discountlist.length,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, height/1.9, 0, 0),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: categories.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: ElevatedButton(
                          onPressed: ()=>print("hello"),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(width/6),
                            backgroundColor: Colors.white,
                          ), child: null,
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ],

    );
  }
}