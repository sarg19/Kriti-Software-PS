

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../database.dart';


class EditItem extends StatefulWidget {
  final name;
  int price;
  final availability;
  int index;
  final Shop_Key;
  Map Menu;
  final Collection;
  EditItem({Key? key,this.name="",
    this.price=0,
    this.availability,
    this.index=0,
    this.Shop_Key="",required this.Menu,this.Collection=""}) : super(key: key);
  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final NameController=TextEditingController();
  final PriceController=TextEditingController();
  var size;
  late bool _value;
  late Databases db;
  initialise(){
    db=Databases();
    db.initialise();
  }
  @override
  void initState(){
    super.initState();
    NameController.text=widget.name;
    PriceController.text=widget.price.toString();
    _value=widget.availability=="Available"?true:false;
    initialise();
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    double h = size.height;
    return Container(
      height: 2*h/5,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromRGBO(253, 243, 223, 1),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.w),
            height: 50.h,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image.asset('assets/icons/back.png'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Edit Item',
                  style: TextStyle(fontSize: 24.sp),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _value = !_value;
                    });
                  },
                  child: Image.asset(
                    _value ? 'assets/icons/Toggle-on.png' : 'assets/icons/Toggle-off.png',
                    height: 50.h,
                    width: 63.w,
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
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                              'Item',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: 'DMSans'
                              ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50.h,
                      child: TextField(
                        controller: NameController,
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
                      height: 14.h,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                              'Price',
                               style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: 'DMSans'
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50.h,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: PriceController,
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
                    SizedBox(height: 20.h),
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
                      width: 100.w,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(188, 156, 255, 1)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                          )
                        ),
                        onPressed: () {
                          // print(NameController.text);
                          // print(num.tryParse(PriceController.text));
                          // print(_value);
                          db.update_menu(widget.Shop_Key, widget.index, widget.Menu, NameController.text, num.tryParse(PriceController.text),_value?1:0,widget.Collection);
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ),
                  ]
              )
          ),
        ],
      ),
    );
  }
}
