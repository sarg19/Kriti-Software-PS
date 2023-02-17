import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/widgets/textfield.dart';
import '../database.dart';

class ShopkeeperEditProfile extends StatefulWidget {
  final String username;
  final String shopname;
  final String upiid;
  final num number;
  final String shoptype;
  ShopkeeperEditProfile({Key? key,this.username="",this.upiid="",this.number=12344,this.shopname="",this.shoptype=""}) : super(key: key);

  @override
  State<ShopkeeperEditProfile> createState() => _ShopkeeperEditProfileState();
}

class _ShopkeeperEditProfileState extends State<ShopkeeperEditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController shopnameController=TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController upiidController=TextEditingController();
  late Databases db;
  initialise() {
    db = Databases();
    db.initialise();
  }
  @override
  void initState() {
    super.initState();
    initialise();
    print(widget.upiid);
    print(widget.username);
    print(widget.shopname);
    print(widget.number.toString());
    nameController.text=widget.username;
    shopnameController.text=widget.shopname;
    upiidController.text=widget.upiid;
    phoneController.text=widget.number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 445.h,
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
                    labelText: " Username",
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
                    controller: shopnameController,
                    labelText: " Name of Shop",
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
                Padding(
                  padding: EdgeInsets.only(top: 6.0.h),
                  child: CustomTextField(
                    controller: upiidController,
                    labelText: " Upi id",
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
                        onPressed: () {
                          db.edit_shopkeeper(nameController.text,shopnameController.text,upiidController.text,int.parse(phoneController.text),FirebaseAuth.instance.currentUser?.uid,widget.shoptype);
                          Navigator.pop(context);
                        },
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