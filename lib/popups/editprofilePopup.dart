import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/widgets/textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromRGBO(253, 243, 223, 1.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 8.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0.w),
                  child: IconButton(
                    icon: const ImageIcon(AssetImage('assets/icons/back.png')),
                    onPressed: () => {Navigator.pop(context)},
                  ),
                ),
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 24.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0.w),
                  child: IconButton(
                    icon:
                        const ImageIcon(AssetImage('assets/icons/person.png')),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16.0.h),
                  child: CustomTextField(
                    controller: nameController,
                    labelText: " Name",
                    hintText: "",
                    inputType: TextInputType.text,
                    labelColor: Colors.black,
                    padding: 15,
                    errorText: "",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0.h),
                  child: CustomTextField(
                    controller: emailController,
                    labelText: " Email",
                    hintText: "",
                    inputType: TextInputType.text,
                    labelColor: Colors.black,
                    padding: 15,
                    errorText: "",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0.h),
                  child: CustomTextField(
                    controller: phoneController,
                    labelText: " Phone Number",
                    hintText: "",
                    inputType: TextInputType.text,
                    labelColor: Colors.black,
                    padding: 15,
                    errorText: "",
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h, left: 10.0.w, right: 10.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 90.w,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(188, 157, 255, 1.0)),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Ok',
                          style: TextStyle(fontSize: 13.sp),
                        )),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(188, 157, 255, 1.0)),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.sendPasswordResetEmail(
                            email: FirebaseAuth.instance.currentUser!.email!);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Password reset link has been sent to your email id.")));
                      },
                      child: Text(
                        'Change Password',
                        style: TextStyle(fontSize: 13.sp),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
