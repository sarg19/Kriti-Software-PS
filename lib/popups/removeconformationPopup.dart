import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../database.dart';

class RemoveItem extends StatefulWidget {
  Map user_info;
  int index1;
  int index2;
  RemoveItem({Key? key,required this.user_info,this.index1=0,this.index2=0}) : super(key: key);

  @override
  State<RemoveItem> createState() => _RemoveItemState();
}

class _RemoveItemState extends State<RemoveItem> {
  late Databases db;
  initialise() {
    db = Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    initialise();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 146.h,
      width: 304.w,
      decoration:  const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromRGBO(253, 243, 223, 1.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0.h,bottom: 12.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('Do you really want to',style: TextStyle(fontSize: 20)),
                Text('remove the item from cart?',style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 90.w,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                      ),
                      backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(188, 157, 255, 1.0)),
                    ),
                    onPressed: (){
                      db.removefromcart(FirebaseAuth.instance.currentUser?.uid,widget.user_info, widget.index1, widget.index2);
                      Navigator.pop(context);
                    },
                    child: const Text('Yes')
                ),
              ),
              SizedBox(
                width: 90.w,
                child: ElevatedButton(
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
                    child: const Text('No')
                ),
              )
            ],
          ),
        ],

      )
    );
  }
}
