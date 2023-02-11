import 'package:flutter/material.dart';

class testscreenadd extends StatefulWidget {
  const testscreenadd({Key? key}) : super(key: key);

  @override
  State<testscreenadd> createState() => _testscreenaddState();
}

class _testscreenaddState extends State<testscreenadd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: AddItem(),
    );
  }
}

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  var size,
      height,
      width;
  
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
              padding: EdgeInsets.only(left: 5,right: 50),
              height: 50,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Add Item',
                        style: TextStyle(fontSize: 24),
                      ),
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
