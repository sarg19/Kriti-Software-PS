import 'package:flutter/material.dart';

class ShopDetails extends StatefulWidget {
  const ShopDetails({Key? key}) : super(key: key);

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 231,
      decoration: const BoxDecoration(
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
                    onPressed: () =>
                    {
                      Navigator.pop(context)
                    },
                  ),
                ),
                const Text('Kapili', style: TextStyle(
                  fontSize: 24,
                ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 28.0),
                  child: ImageIcon(AssetImage('assets/icons/person.png'),
                    color: Colors.transparent,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 2.0),
                  child: Text('S23004xxx', style: TextStyle(
                    fontSize: 20,
                  )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text('Abxshk Sjxhsu', style: TextStyle(
                        fontSize: 20
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('Kapili Canteen', style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(
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
                    onPressed: () {},
                    child: const Text('Log Out')
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
