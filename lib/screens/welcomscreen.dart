import 'package:flutter/material.dart';
import 'package:kriti/bottomsheets/signupsheet.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
        // backgroundColor: ,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset('assets/images/appLogo.png'),
            ),
            const SizedBox(
              height: 50,
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
                      // backgroundColor: Colors.transparent,
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
                  onPressed: () {},
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
          ],
        ),
      ),
    ]);
  }
}
