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
      if(doc.id=="kOFNcRZ9JnFFiW3AtXzj"){
        Map Menu={"id":doc.id,"menu":doc["Menu"]};
        return Menu;
      }
    }
  }
  void update_menu(int index,Map Menu,String _name,num _price,num _available) async {
    final CollectionReference usersCollection = firestore.collection('shops');

    Menu['menu'][index]['Price']=_price;
    Menu['menu'][index]['Name']=_name;
    Menu['menu'][index]['Available']=_available;
    usersCollection.doc("kOFNcRZ9JnFFiW3AtXzj").update({'Menu':Menu['menu']});
  }
  void add_menu_item(Map Menu,String _name,num _price) async {
    final CollectionReference usersCollection = firestore.collection('shops');
    Menu['menu'].add({'Price':_price,'Name':_name,'Available':1});
    usersCollection.doc("kOFNcRZ9JnFFiW3AtXzj").update({'Menu':Menu['menu']});
  }
  Future retrieve_user_info() async {
    late Map? user_info;
    var snapshot=await firestore.collection("users").doc("01li51cY9718Ns75HOa9").get();
    user_info=snapshot.data();
    return user_info;
  }
  void create_user(String userId) async {
    final CollectionReference usersCollection = firestore.collection('users');
    usersCollection.doc(userId).set({
      'Active_Orders':[],
      'Cart':[],
      'Favourites':[],
      'Location':'Kapili',
      'Mail':'k.tarun@iitg.ac.in',
      'Name':'Tarun Kumar',
      'Recent_Orders':[]
    });
  }
  void Add_to_Cart(String _item,num _price,String _shopkey,String _shopname,String userId) async {
    late Map? user_info;
    final CollectionReference usersCollection = firestore.collection('users');
    var snapshot=await firestore.collection("users").doc(userId).get();
    user_info=snapshot.data();
    if(user_info==null){
      print('first login');
      return;
    }
    if(!user_info.containsKey('Cart')){
      user_info['Cart']=[];
    }
    for(Map shop in user_info!['Cart']){
      if(shop['Shop_Key']==_shopkey){
        for(Map item in shop['Items']){
          if(item['Item_Name']==_item){
            item['Quantity']=item['Quantity']+1;
            shop['Total_Amount']=shop['Total_Amount']+item['Price'];
            usersCollection.doc(userId).update({'Cart':user_info!['Cart']});
            return;
          }
        }
        shop['Items'].add({'Item_Name':_item,'Price':_price,'Quantity':1});
        shop['Total_Amount']=shop['Total_Amount']+_price;
        usersCollection.doc(userId).update({'Cart':user_info!['Cart']});
        return;
      }
    }
    user_info!['Cart'].add({
      'Shop_Key':_shopkey,
      'Shop_Name':_shopname,
      'Total_Amount':_price,
      'Items':[{'Item_Name':_item,'Price':_price,'Quantity':1}]
    });
    usersCollection.doc(userId).update({'Cart':user_info!['Cart']});
    print(user_info!['Cart']);
    return;
  }
}