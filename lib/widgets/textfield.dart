import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final Color? labelColor;
  final double? padding;
  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final String? errorText;
  final bool? obscureText;

  const CustomTextField({Key? key, required this.controller, required this.labelText, required this.hintText, required this.inputType, this.errorText, this.obscureText, this.labelColor, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 60.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
                color: labelColor ?? Colors.white,
                fontSize: 13.sp
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: errorText==""? 35.h : 50.h,
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                controller: controller,
                obscureText: obscureText??false,
                keyboardType: inputType,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3.5.h, left: 10.w),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(17.5))
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  errorText: errorText == "" ? null : errorText,
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(17.5))
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(17.5))
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(
          //   height: 10,
          // )
        ],
      ),
    );
  }
}
