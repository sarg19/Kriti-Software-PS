import 'package:flutter/material.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_previewer/file_previewer.dart';
import 'package:kriti/components/bottom_nav_bar.dart';

void main()=>{
  runApp(MaterialApp(
      home: uploadscreen()
  ))
};


class uploadscreen extends StatefulWidget {
  const uploadscreen({Key? key}) : super(key: key);

  @override
  State<uploadscreen> createState() => _uploadscreenState();
}

class _uploadscreenState extends State<uploadscreen> {
  FilePickerResult? result;
  List <PlatformFile> pickedfile=[];
  List <Widget> thumbnail=[];
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
        try {
          if (result!.files[i]!= null) {
            final thumbnailindex = await FilePreview.getThumbnail(
              result!.files[i].path!,
              height: 100,
              width: 200,
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
    extension="."+extension;
    final path=file.path ?? 'none';
    final filename=file.name;


    return Container(
      margin: EdgeInsets.fromLTRB(40,40,40,0),
      child: InkWell(
        onTap: ()=>openFile(file),
        child: Column(
          children: [
            Container(child: thumbnail,width: 200,height: 100),
            Center(
              child:Container(
                alignment: Alignment.center,
                width:300,
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
            title: Center(
              child: Container(
                height:50,
                width:50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),

                child: const Image(
                  image: AssetImage("assets/images/appLogo.png"),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 100.0,
            leading: IconButton(
              onPressed: (){},
              icon: const Icon(Icons.arrow_back_ios_new , color: Colors.black ),
            ),
            actions: [
              Transform.scale(
                scale: 1.5,
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.account_circle_outlined , color: Colors.black),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(width*0.076, height*0.0176, 0, 0),
                    child: ListTile(
                      title: Text("Kapili Stationary",style:TextStyle(fontSize: 25)),
                      subtitle: Text("Now Open",style: TextStyle(fontSize: 15),),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(width*0.7633, height*0.05875, 0, 0),
                    child:Text("Details",style: TextStyle(fontSize: 15),),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: height * 0.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.fromLTRB(40, 20, 40, 30),
                child: pickedfile.isNotEmpty ? PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      Container(
                        child: Column(
                          children: [
                            Container(
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
                                color: Color.fromRGBO(188, 157, 255, 1.0),
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      thumbnail.remove(thumbnail[index]);
                                      pickedfile.remove(pickedfile[index]);
                                    });
                                  },
                                  child: Text("Remove this item",style: TextStyle(color: Colors.white,fontSize: 20),)
                              ),
                            ),
                          ],
                        ),
                      ),
                  itemCount: pickedfile!.length,
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
                      color: Color.fromRGBO(188, 157, 255, 1.0),
                    ),
                    child: TextButton(
                        onPressed: (){
                          pickfile();
                        },
                        child: Text("Add more files",style: TextStyle(color: Colors.white,fontSize: 20),)
                    ),
                  ),
                  Container(
                    width: width*0.4122,
                    height: height*0.047,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(188, 157, 255, 1.0),
                    ),
                    child: TextButton(
                        onPressed: (){},
                        child: Text("Request Print",style: TextStyle(color: Colors.white,fontSize: 20),)
                    ),
                  )
                ],
              )
            ],
          ),
          bottomNavigationBar: BottomNavBar()
        ),

      ],
    );
  }
}
