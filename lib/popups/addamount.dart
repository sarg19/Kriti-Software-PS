import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/textfield.dart';

class AddAmount extends StatefulWidget {
  const AddAmount({Key? key}) : super(key: key);

  @override
  State<AddAmount> createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 146.h,
        width: 304.w,
        decoration:  const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromRGBO(253, 243, 223, 1.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0.h),
              child: CustomTextField(controller: nameController, labelText: "Add Order Amount", hintText: "", inputType: TextInputType.number, labelColor: Colors.black, padding: 15, errorText: "",),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 90.w,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                        ),
                        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(188, 157, 255, 1.0)),
                      ),
                      onPressed: (){},
                      child: Text('Add',style: TextStyle(fontSize: 13.sp),)
                  ),
                ),
              ],
            ),
          ],

        )
    );
  }
}
