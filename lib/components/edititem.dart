import 'package:flutter/material.dart';

class testscreen extends StatefulWidget {
  const testscreen({Key? key}) : super(key: key);

  @override
  State<testscreen> createState() => _testscreenState();
}

class _testscreenState extends State<testscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: EditItem(),
    );
  }
}

class EditItem extends StatefulWidget {
  const EditItem({Key? key}) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  var size,
      height,
      width;
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Center(
      child: Container(
        height: 2*h/5,
        width: 3*w/4,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromRGBO(253, 243, 223, 1),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 50,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  const Text(
                    'Edit Item',
                    style: TextStyle(fontSize: 24),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _value = !_value;
                      });
                    },
                    child: Image.asset(
                      _value ? 'assets/icons/Toggle-on.png' : 'assets/icons/Toggle-off.png',
                      height: 50,
                      width: 63,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                                'Item',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'DMSans'
                                ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                                'Price',
                                 style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'DMSans'
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // ElevatedButton(
                      //   onPressed: () {},
                      //   child: Container(
                      //     height: 25,
                      //     width: 75,
                      //     decoration: BoxDecoration(
                      //       color: Color.fromRGBO(188, 157, 255, 1)
                      //     ),
                      //     child: Center(
                      //       child: Text('OK'),
                      //     ),
                      //   ),
                      //   // child: Text('OK'),
                      // ),
                      Container(
                        width: 100,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color.fromRGBO(188, 156, 255, 1)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )
                            )
                          ),
                          onPressed: () {},
                          child: Text('OK'),
                        ),
                      ),
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}
