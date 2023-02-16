import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/bottomsheets/skloginsheet.dart';
import 'package:kriti/bottomsheets/sksignupsheet.dart';

class ShopkeeperWelcomeScreen extends StatefulWidget {
  const ShopkeeperWelcomeScreen({Key? key}) : super(key: key);

  @override
  State<ShopkeeperWelcomeScreen> createState() => _ShopkeeperWelcomeScreenState();
}

class _ShopkeeperWelcomeScreenState extends State<ShopkeeperWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/bgImage1.png',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 140.h,
              ),
              SizedBox(
                height: 150.h,
                width: 150.h,
                child: Image.asset('assets/images/appLogo.png'),
              ),
              SizedBox(
                height: 80.h,
              ),
              Text(
                'Welcome',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 30.w),
                child: Text(
                  'Please login or sign up to continue using this app',
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context, builder: (context) => const SkSignupSheet(),
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20 ),
                            )
                        ),
                        isScrollControlled: true,
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xFFBC9DFF)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontWeight: FontWeight.w600))),
                    child: Text('Sign Up', style: TextStyle(fontSize: 20.sp),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context, builder: (context) => const SkLoginSheet(),
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20 ),
                            )
                        ),
                        isScrollControlled: true,
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xFFBC9DFF)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontWeight: FontWeight.w600))),
                    child: Text('Log In', style: TextStyle(fontSize: 20.sp),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
