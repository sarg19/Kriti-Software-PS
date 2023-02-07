import 'package:flutter/material.dart';
import 'package:kriti/bottomsheets/loginsheet.dart';
import 'package:kriti/bottomsheets/signupsheet.dart';
import 'package:kriti/screens/home.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
              const SizedBox(
                height: 140,
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/images/appLogo.png'),
              ),
              const SizedBox(
                height: 80,
              ),
              const Text(
                'Welcome',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                child: Text(
                  'Please login or sign up to continue using this app',
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context, builder: (context) => const SignUpSheet(),
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
                    child: const Text('Sign Up'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context, builder: (context) => const LoginSheet(),
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
                    child: const Text('Log In'),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Divider(
                thickness: 1.5,
                indent: (width-150)/2,
                endIndent: (width-150)/2,
                color: Colors.black,
                // height: 150,
              ),
              // const SizedBox(height: 15,),
              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const homescreen()));
                },
                child: const Text(
                  'Continue as Guest',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 40,
              // )
            ],
          ),
        ),
      ),
    ]);
  }
}
