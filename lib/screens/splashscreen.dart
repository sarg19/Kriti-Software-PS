import 'package:flutter/material.dart';
import 'package:kriti/screens/welcomscreen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  final bool isLogin;
  const SplashScreen(this.isLogin, {super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (!mounted) return;

    if (!widget.isLogin) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const WelcomeScreen(), type: PageTransitionType.fade));
    } else {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const WelcomeScreen(), type: PageTransitionType.fade));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(244,233,255,30),
        body: Center(
          child: SizedBox(
            height: 170,
            width: 170,
            child: Image.asset('assets/images/appLogo.png'),
          ),
        )
    );
  }
}