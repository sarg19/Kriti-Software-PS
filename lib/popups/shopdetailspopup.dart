import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/database.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetails extends StatefulWidget {
  String shop_key;
  String collection;
  ShopDetails({Key? key,required this.shop_key,required this.collection}) : super(key: key);

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  String Name="UserName";
  String ShopName="ShopName";
  int Phone=1234567890;
  int counter=0;
  late Databases db;
  initialise() {
    db = Databases();
    db.initialise();
    db.retrieve_shop_info(widget.collection, widget.shop_key).then((value){
      setState(() {
        counter=1;
        ShopName=value['ShopName'];
        Name=value['UserName'];
        Phone=value['Number'];
      });
    });
  }
  @override
  void initState() {
    super.initState();
    initialise();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 231.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromRGBO(253, 243, 223, 1.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 8.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0.w),
                  child: IconButton(
                    icon: const ImageIcon(AssetImage('assets/icons/back.png')),
                    onPressed: () =>
                    {
                      Navigator.pop(context)
                    },
                  ),
                ),
                Text('Shop Details', style: TextStyle(
                  fontSize: 24.sp,
                ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 28.0.w),
                  child: const ImageIcon(AssetImage('assets/icons/person.png'),
                    color: Colors.transparent,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.0.h, bottom: 2.0.h),
                  child: Text(widget.shop_key, style: TextStyle(
                    fontSize: 20.sp,
                  )),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.0.w, top: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5.0.h),
                    child: Text(Name, style: TextStyle(
                        fontSize: 20.sp
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0.h, bottom: 10.0.h),
                    child: Text(ShopName, style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color.fromRGBO(
                            114, 114, 114, 1.0)
                    )),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(188, 157, 255, 1.0)),
                    ),
                    onPressed: () async {
                      Uri code=Uri.parse('tel:8770768952');
                      print(code);
                      launchUrl(code);
                    },
                    child: const Text('Contact')
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
