import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kriti/components/bottom_nav_bar.dart';

import '../database.dart';

class FeedbackScreen extends StatefulWidget {
  final String shop_key;
  final String collection;
  const FeedbackScreen({Key? key, required this.shop_key, required this.collection}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  int _currentButton = 0;
  late Databases db;
  late Timer timer;
  initialise(){
    db=Databases();
    db.initialise();

  }
  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bgImage1.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width:MediaQuery.of(context).size.width ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 55.0),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    // padding: const EdgeInsets.only(bottom: 1000) ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'How was the service of\n your order from this\n shop?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Rate the shop,your feedback matters',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color.fromRGBO(114, 114, 114, 1.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(_currentButton < 1 ? Icons.star_border_rounded : Icons.star_rate_rounded),
                          onPressed:(){
                            setState(() {
                              _currentButton = 1;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(_currentButton < 2 ? Icons.star_border_rounded : Icons.star_rate_rounded),
                          onPressed:(){
                            setState(() {
                              _currentButton = 2;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(_currentButton < 3 ? Icons.star_border_rounded : Icons.star_rate_rounded),
                          onPressed:(){
                            setState(() {
                              _currentButton = 3;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(_currentButton < 4 ? Icons.star_border_rounded : Icons.star_rate_rounded),
                          onPressed:(){
                            setState(() {
                              _currentButton = 4;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(_currentButton < 5 ? Icons.star_border_rounded : Icons.star_rate_rounded),
                          onPressed:(){
                            setState(() {
                              _currentButton = 5;
                            });
                          },
                        )
                      ]
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                          ),
                          backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(188, 157, 255, 1.0)),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('No, Thanks')
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                          ),
                          backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(188, 157, 255, 1.0)),
                        ),
                        onPressed: (){
                          db.rating(_currentButton, widget.shop_key, widget.collection);
                          Navigator.pop(context);
                        },
                        child: const Text('Submit')
                    )
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavBar(),
        ),
      ],

    );
  }
}
