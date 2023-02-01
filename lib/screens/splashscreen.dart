import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  final bool isLogin;
  const SplashScreen(this.isLogin, {super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(90,183,212,30),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(206,232,240,40),
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(2,2)
                    )
                  ]
              ),
            ),
          ),
          const SizedBox(height: 35 ,),
          Text(
            style: GoogleFonts.sansitaSwashed(
              textStyle: const TextStyle(
                  fontSize: 50,
                  color: Color.fromRGBO(206,232,240,40)
              )
            ),
            'Know Shop'
          )
        ]
      )
    );
  }
}