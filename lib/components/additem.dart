import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../database.dart';

class AddItem extends StatefulWidget {
  final Shop_Key;
  Map Menu;
  final Collection;
  AddItem({Key? key,this.Shop_Key="",required this.Menu,this.Collection=""}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final NameController=TextEditingController();
  final PriceController=TextEditingController();
  var size;
  late Databases db;
  initialise(){
    db=Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    NameController.text="";
    PriceController.text="";
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
            padding: EdgeInsets.only(left: 5.w,right: 50.w),
            height: 50.h,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/back.png')),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Add Item',
                      style: TextStyle(fontSize: 24.sp),
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
                          padding: const EdgeInsets.only(left: 20),
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
                        controller: PriceController,
                        keyboardType: TextInputType.number,
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
                          // print(num.tryParse(PriceController.text).runtimeType);
                          if(num.tryParse(PriceController.text).runtimeType==null){
                            print("wrong input");
                          }else if(num.tryParse(PriceController.text)==null){
                            print("wrong input");
                          }else{
                            db.add_menu_item(widget.Shop_Key, widget.Menu, NameController.text,num.tryParse(PriceController.text),widget.Collection);
                          }
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
