import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCard extends StatefulWidget {
  const QRCard({Key? key}) : super(key: key);

  @override
  State<QRCard> createState() => _QRCardState();
}

class _QRCardState extends State<QRCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
          color: Color.fromRGBO(253, 243, 223, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Center(
        child: QrImage(
          data:"6RZXUvmrVqqSCGtp1BCD",
          size: 280,
          backgroundColor: Color.fromRGBO(253, 243, 223, 1.0),
        ),
      ),
    );
  }
}
