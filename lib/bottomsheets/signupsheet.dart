import 'package:flutter/material.dart';

class SignUpSheet extends StatefulWidget {
  const SignUpSheet({Key? key}) : super(key: key);

  @override
  State<SignUpSheet> createState() => _SignUpSheetState();
}

class _SignUpSheetState extends State<SignUpSheet> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/blurbg.png',
        height: 490,
        fit: BoxFit.cover,
      ),
      Container(
        // color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(35, 0, 34, 0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          // color: Colors.black.withOpacity(0.1),
        ),
        height: 490.0,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    ]);
  }
}
