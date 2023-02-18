import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/popups/profilepopup.dart';
import 'package:kriti/popups/shopdetailspopup.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:kriti/screens/customertabs.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_previewer/file_previewer.dart';
import 'package:kriti/components/bottom_nav_bar.dart';

import '../database.dart';



class uploadscreen extends StatefulWidget {
  final String shop_key;
  const uploadscreen({Key? key, required this.shop_key}) : super(key: key);

  @override
  State<uploadscreen> createState() => _uploadscreenState();
}

class _uploadscreenState extends State<uploadscreen> {
  String Name='User';
  String email='abc@example.com';
  String stat_email = 'stationary@gmail.con';
  int Phone=1234567890;
  String ShopName="Shop";
  String open="Open";
  late Databases db;
  late Timer timer;
  initialise() {
    db = Databases();
    db.initialise();
    db.retrieve_shop_info('stationary', widget.shop_key).then((value){
      setState(() {
        stat_email = value['Email'];
      });
    });
    void Reload() async {
      db.retrieve_shop_info('stationary', widget.shop_key).then((value){
        if(!mounted){
          return;
        }
        setState(() {
          stat_email = value['Email'];
          open=value['open']==1?"Open":"Close";
          ShopName=value['ShopName'];
        });
      });
    }
    timer=Timer.periodic(Duration(milliseconds: 100), (timer) {
      Reload();
    });
    db.retrieve_user_info(FirebaseAuth.instance.currentUser?.uid).then((value){
      setState((){
        Name=value['Name'];
        email=value['Mail'];
        Phone=value['Phone_Number'];
      });

    });
  }
  @override
  void initState() {
    super.initState();
    initialise();
  }
  FilePickerResult? result;
  List <PlatformFile> pickedfile=[];
  List <Widget> thumbnail=[];
  List <String> paths = [];
  bool isloading=false;
  void pickfile()async{
    setState(() {
      isloading=true;
    });
    result=await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf','jpg','jpeg','doc','png'],
      allowMultiple: true,
      type: FileType.custom,
    );
    if(result!=null){
      for(var i=0;i<result!.files.length;i++){
        pickedfile.add(result!.files[i]);
        paths.add(result!.files[i].path!);
        try {
          if (result!.files[i]!= null) {
            final thumbnailindex = await FilePreview.getThumbnail(
              result!.files[i].path!,
              height: 100.h,
              width: 200.w,
            );
            setState(() {
              thumbnail.add(thumbnailindex);

            });
          }
        } catch (e) {
          print(e);
        }
      }
    }
    setState(() {
      isloading=false;
    });
  }
  Widget buildFile(PlatformFile file,Widget thumbnail) {
    final kb=file.size/1024;
    final mb=kb/1024;
    final fileSize=mb>=1? '${mb.toStringAsFixed(2)} MB': '${kb.toStringAsFixed(2)} KB';
    var extension=file.extension ?? 'none';
    extension=".$extension";
    final path=file.path ?? 'none';
    final filename=file.name;


    return Container(
      margin: EdgeInsets.fromLTRB(40.w,40.h,40.w,0),
      child: InkWell(
        onTap: ()=>openFile(file),
        child: Column(
          children: [
            SizedBox(width: 200.w,height: 100.h, child: thumbnail),
            Center(
              child:Container(
                alignment: Alignment.center,
                width:300.w,
                child: Text(filename),
              ),
            ),
            Center(
                child:Container(
                  alignment: Alignment.center,
                  child: Text(fileSize),
                )
            ),
          ],
        ),
      ),
    );
  }
  void openFile(PlatformFile file){
    OpenFile.open(file.path!);
  }
  @override
  Widget build(BuildContext context) {
    var width=  MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset('assets/images/bgImage1.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Image(
              height: 45.h,
              width: 45.h,
              image: const AssetImage("assets/images/appLogo.png"),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new , color: Colors.black ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ShowPopUp(
                      widgetcontent: Profile(Name: Name,Email: email,Phone: Phone,),
                    ),
                  );
                },
                iconSize: 30.h,
                icon: const ImageIcon(
                  AssetImage('assets/icons/person.png'),
                  color: Colors.black,
                ),
              )
            ],
          ),
          body: Column(
            children: [
              SizedBox(height: 10.h,),
              PreferredSize(
                preferredSize: Size.fromHeight(90.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width/6),
                      child: Text(
                        ShopName,  //change to ShopName
                        style: TextStyle(
                            fontSize: 25.sp,
                            fontFamily: 'DM-Sans'
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width/6),
                          child: Text(
                            'Now '+open,
                            style: TextStyle(
                                color: const Color.fromRGBO(114, 114, 114, 1.0),
                                fontSize: 15.sp,
                                fontFamily: 'DM-Sans'
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width/3),
                          child: TextButton(onPressed: (){
                            showDialog(context: context, builder: (BuildContext context){
                              return  ShowPopUp(widgetcontent: ShopDetails(shop_key: widget.shop_key,collection: 'stationary',),);
                            });
                          }, child: Text(
                            'details',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.sp,
                            ),
                          )),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: height * 0.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.fromLTRB(40.w, 20.h, 40.w, 30.h),
                child: pickedfile.isNotEmpty ? PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      Column(
                        children: [
                          SizedBox(
                            height: height * 0.25,
                            width: width * 0.67,
                            child: buildFile(pickedfile[index],thumbnail[index]),
                          ),
                          Container(
                            width: width*0.5,
                            height: height*0.047,
                            margin: EdgeInsets.fromLTRB(width/100, 0, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromRGBO(188, 157, 255, 1.0),
                            ),
                            child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    thumbnail.remove(thumbnail[index]);
                                    pickedfile.remove(pickedfile[index]);
                                  });
                                },
                                child: Text("Remove this item",style: TextStyle(color: Colors.white,fontSize: 16.sp),)
                            ),
                          ),
                        ],
                      ),
                  itemCount: pickedfile.length,
                  pageSnapping: true,
                ):
                Center(
                  child: IconButton(
                    onPressed: (){
                      pickfile();
                    },
                    icon: const ImageIcon(AssetImage('assets/icons/uploadicon.png')),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: width*0.4122,
                    height: height*0.047,
                    margin: EdgeInsets.fromLTRB(width*0.0712, 0, width*0.02544, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(188, 157, 255, 1.0),
                    ),
                    child: TextButton(
                        onPressed: (){
                          pickfile();
                        },
                        child: Text("Add more files",style: TextStyle(color: Colors.white,fontSize: 16.sp),)
                    ),
                  ),
                  Container(
                    width: width*0.4122,
                    height: height*0.047,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(188, 157, 255, 1.0),
                    ),
                    child: TextButton(
                        onPressed: () async {
                          if(pickedfile.isEmpty) return;
                          var result=await sendmail(email,paths,stat_email);
                          if(result=="SUCCESS"){
                            db.add_print(widget.shop_key, FirebaseAuth.instance.currentUser?.uid, 0);
                            setState((){
                              pickedfile=[];
                              thumbnail=[];
                              paths=[];
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Email sent successfully")));
                          }else if(result=="FAIL"){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Some error occurred")));
                          }
                        },
                        child: Text("Request Print",style: TextStyle(color: Colors.white,fontSize: 16.sp),)
                    ),
                  )
                ],
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(219, 202, 255, 1.0),
            selectedItemColor: Colors.black54,
            unselectedItemColor: Colors.black54,
            selectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/home.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 0)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/bag.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 1)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/favorite.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 2)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const ImageIcon(AssetImage('assets/icons/cart.png')),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const CustomerTabs(currentIndex: 3)),
                            (Route<dynamic> route) => false);
                  },
                ),
                label: '',
              ),
            ],
          ),
        ),

      ],
    );
  }
  Future<String> sendmail(String email,List<String> paths,String stationaryemail) async {
    List <Attachment> attachments=[];
    for(var i=0;i<paths.length;i++){
      attachments.add(FileAttachment(File(paths[i]))
        ..location = Location.inline
        ..cid = '<myimg@3.141>');
    }
    String username = 'knowshopkapili@gmail.com';
    String password = 'kcihnoydluldsgcm';
    final smtpServer = gmail(username, password);
    // Create our message.
    final message = Message()
      ..from = Address(username, 'KnowShop')
      ..recipients.add(stationaryemail)
      ..subject = 'Request for print from ${email}'
      ..html = 'Print the file attached in the mail below.\nPlease accept the print request on the app\n'
    ..attachments = attachments;
    try {
      final sendReport = await send(message, smtpServer);
      // print('Message sent: ' + sendReport.toString());
      return "SUCCESS";
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return "FAIL";
    }
  }
}
