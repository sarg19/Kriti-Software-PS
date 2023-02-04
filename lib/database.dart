import 'package:cloud_firestore/cloud_firestore.dart';
class Databases{
  late FirebaseFirestore firestore;
  initialise(){
    firestore = FirebaseFirestore.instance;
  }
  Future retrieve_menu() async {
    final CollectionReference usersCollection = firestore.collection('shops');
    final QuerySnapshot snapshots=await usersCollection.get();
    for(var doc in snapshots.docs.toList()){
      Map Menu={"id":doc.id,"menu":doc["Menu"]};
      return Menu;
    }
  }
  void update_menu(int index,Map Menu,String _name,num _price) async {
    final CollectionReference usersCollection = firestore.collection('shops');

    Menu['menu'][index]['Price']=_price;
    Menu['menu'][index]['Name']=_name;
    usersCollection.doc("kOFNcRZ9JnFFiW3AtXzj").update({'Menu':Menu['menu']});
  }
}