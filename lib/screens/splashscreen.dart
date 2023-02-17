import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/database.dart';
import 'package:kriti/screens/choicescreen.dart';
import 'package:kriti/screens/customertabs.dart';
import 'package:kriti/screens/shopkeepertabs.dart';
import 'package:kriti/screens/stationarytabs.dart';
import 'package:kriti/screens/groceryandmiscellaneous.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  final bool isLogin;

  const SplashScreen(this.isLogin, {super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Databases db;
  String type="none";

  initialise() {
    db = Databases();
    db.initialise();
  }

  @override
  void initState() {
    super.initState();
    initialise();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (!mounted) return;

    if (!widget.isLogin) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const ChoiceScreen(), type: PageTransitionType.fade));
    } else {
      if(FirebaseAuth.instance.currentUser!.displayName=="users"){
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: const CustomerTabs(currentIndex: 0),
                type: PageTransitionType.fade));
      } else if(FirebaseAuth.instance.currentUser!.displayName=="stationary"){
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: StationaryTabs(coltype: FirebaseAuth.instance.currentUser!.displayName.toString(),),
                type: PageTransitionType.fade));

      } else if(FirebaseAuth.instance.currentUser!.displayName=="grocery" || FirebaseAuth.instance.currentUser!.displayName=="miscellaneous"){
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: groceryandmiscellaneous(coltype: FirebaseAuth.instance.currentUser!.displayName.toString(),),
                type: PageTransitionType.fade));
      } else if(FirebaseAuth.instance.currentUser!.displayName?.substring(0, 3)=="food"){
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: ShopkeeperTabs(coltype: FirebaseAuth.instance.currentUser!.displayName.toString(),),
                type: PageTransitionType.fade));
      } else {
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: const ChoiceScreen(), type: PageTransitionType.fade));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(244, 233, 255, 1.0),
        body: Center(
          child: SizedBox(
            height: 170.h,
            width: 170.h,
            child: Image.asset('assets/images/appLogo.png'),
          ),
        ));
  }
}
