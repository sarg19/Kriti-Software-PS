import 'package:flutter/material.dart';

class ShopkeeperProfile extends StatefulWidget {
  const ShopkeeperProfile({Key? key}) : super(key: key);

  @override
  State<ShopkeeperProfile> createState() => _ShopkeeperProfileState();
}

class _ShopkeeperProfileState extends State<ShopkeeperProfile> {

  int _currentStar = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
              height: 396,
              width: 304,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromRGBO(253, 243, 223, 1.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: IconButton(
                            icon: const ImageIcon(
                                AssetImage('assets/icons/back.png')),
                            onPressed: () => {Navigator.pop(context)},
                          ),
                        ),
                        const Text(
                          'Kapili',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 28.0),
                          child: ImageIcon(
                            AssetImage('assets/icons/person.png'),
                            // color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 2.0),
                          child: Text('S23004xxx',
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text('Abxshk Sjxhsu',
                                style: TextStyle(fontSize: 20)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text('Kapili Canteen',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(114, 114, 114, 1.0))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text('890824xxx',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0,top: 12,bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(188, 157, 255, 1.0)),
                              ),
                              onPressed: () {},
                              child: const Text('Edit Profile')),
                          ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(188, 157, 255, 1.0)),
                              ),
                              onPressed: () {},
                              child: const Text('Log Out'))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Your Ratings',
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(_currentStar < 1 ? Icons.star_border_rounded : Icons.star_rate_rounded , size: 35),
                              onPressed:(){
                                setState(() {
                                  _currentStar = 1;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(_currentStar < 2 ? Icons.star_border_rounded : Icons.star_rate_rounded , size: 35),
                              onPressed:(){
                                setState(() {
                                  _currentStar = 2;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(_currentStar < 3 ? Icons.star_border_rounded : Icons.star_rate_rounded , size: 35),
                              onPressed:(){
                                setState(() {
                                  _currentStar = 3;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(_currentStar < 4 ? Icons.star_border_rounded : Icons.star_rate_rounded , size: 35),
                              onPressed:(){
                                setState(() {
                                  _currentStar = 4;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(_currentStar < 5 ? Icons.star_border_rounded : Icons.star_rate_rounded , size: 35),
                              onPressed:(){
                                setState(() {
                                  _currentStar = 5;
                                });
                              },
                            )
                          ]
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
