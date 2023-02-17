import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCard extends StatefulWidget {
  final String order_key;
  const QRCard({Key? key, required this.order_key,}) : super(key: key);

  @override
  State<QRCard> createState() => _QRCardState();
}

class _QRCardState extends State<QRCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 300.h,
      decoration: BoxDecoration(
          color: Color.fromRGBO(253, 243, 223, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Center(
        child: QrImage(
          data:widget.order_key,
          size: 280.h,
          backgroundColor: Color.fromRGBO(253, 243, 223, 1.0),
        ),
      ),
    );
  }
}
