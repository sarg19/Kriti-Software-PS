import 'dart:ui';

import 'package:flutter/material.dart';

class ProfilePopup extends StatefulWidget {
  const ProfilePopup({Key? key}) : super(key: key);

  @override
  State<ProfilePopup> createState() => _ProfilePopupState();
}

class _ProfilePopupState extends State<ProfilePopup> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        content: Container(
          height: 271,
          decoration:  const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color.fromRGBO(253, 243, 223, 1.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: const ImageIcon(AssetImage('assets/icons/back.png')),
                        onPressed: () => {
                          Navigator.pop(context)
                        },
                      ),
                    ),
                    const Text('Profile',style: TextStyle(
                      fontSize: 24,
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        icon: const ImageIcon(AssetImage('assets/icons/person.png')),
                        onPressed: (){},
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Sarvesh Gholap',style: TextStyle(
                        fontSize: 20,
                      )),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0,bottom: 14.0),
                        child: Text('sarvesh.iitg.ac.in',style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(
                                114, 114, 114, 1.0)
                        )),
                      ),
                      Text('2101010',style: TextStyle(
                          fontSize: 20
                      )),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                        child: Text('97547xxx',style: TextStyle(
                            fontSize: 20
                        )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                            ),
                            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(188, 157, 255, 1.0)),
                          ),
                          onPressed: (){},
                          child: const Text('Edit Profile')
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                            ),
                            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(188, 157, 255, 1.0)),
                          ),
                          onPressed: (){},
                          child: const Text('Log Out')
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
