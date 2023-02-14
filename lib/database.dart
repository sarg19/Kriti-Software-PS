import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
class Databases{
  late FirebaseFirestore firestore;
  initialise(){
    firestore = FirebaseFirestore.instance;
  }
  Future retrieve_menu(String shop_key,String collection_name) async {
    late Map? shop_info;
    var snapshot = await firestore.collection(collection_name).doc(shop_key).get();
    shop_info=snapshot.data();
    return shop_info;
  }
  void update_menu(String shop_key,int index,Map Menu,String _name,num? _price,num _available) async {
    final CollectionReference usersCollection = firestore.collection('shops');

    Menu['Menu'][index]['Price']=_price;
    Menu['Menu'][index]['Name']=_name;
    Menu['Menu'][index]['Available']=_available;
    usersCollection.doc(shop_key).update({'Menu':Menu['Menu']});
  }
  void add_menu_item(String shop_key,Map Menu,String _name,num? _price) async {
    final CollectionReference usersCollection = firestore.collection('shops');
    Menu['Menu'].add({'Price':_price,'Name':_name,'Available':1});
    usersCollection.doc(shop_key).update({'Menu':Menu['Menu']});
  }
  Future retrieve_user_info(String userId) async {
    late Map? user_info;
    var snapshot=await firestore.collection("users").doc(userId).get();
    user_info=snapshot.data();
    return user_info;
  }
  void create_user(String userId,String email,String Name,num p_number) async {
    final CollectionReference usersCollection = firestore.collection('users');
    usersCollection.doc(userId).set({
      'Active_Orders':[],
      'Cart':[],
      'Favourites':[],
      'Phone_Number':p_number,
      'Mail':email,
      'Name':Name,
      'Recent_Orders':[]
    });
  }
  void Add_to_Cart(String _item,num _price,String _shopkey,String _shopname,String userId) async {
    late Map? user_info;
    late Map? shop_info;
    final CollectionReference shopCollection = firestore.collection('shops');
    var shopsnapshot=await firestore.collection('shops').doc(_shopkey).get();
    final CollectionReference usersCollection = firestore.collection('users');
    var snapshot=await firestore.collection("users").doc(userId).get();
    shop_info=shopsnapshot.data();
    user_info=snapshot.data();
    if(user_info==null){
      print('first login');
      return;
    }
    if(!user_info.containsKey('Cart')){
      user_info['Cart']=[];
    }
    int counter=0;
    for(Map item in shop_info!['Menu']){
      if(item['Name']==_item){
        if(item['Available']==0){
          counter=2;
        }else{
          _price=item['Price'];
          counter=1;
        }
      }
    }
    if(counter==0){
      print('No item found in menu');
      return;
    }
    if(counter==2){
      print('Item currently unavailable');
      return;
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
  void Request_Order(String userId, String shop_key) async {
    late Map? user_info;
    late Map? shop_info;
    final CollectionReference usersCollection = firestore.collection('users');
    var snapshot=await firestore.collection("users").doc(userId).get();
    var shopsnapshot=await firestore.collection("shops").doc(shop_key).get();
    user_info=snapshot.data();
    shop_info=shopsnapshot.data();
    if(shop_info==null){
      print("shop doesn't exists");
      return;
    }
    if(user_info==null){
      print('first login');
      return;
    }
    late Map? Cart;
    var counter=0;
    for(Map shopcart in user_info['Cart']){
      if(shopcart['Shop_Key']==shop_key){
        Cart=shopcart;
        counter=1;
      }
    }
    if(counter==0){
      return;
    }
    user_info['Cart'].remove(Cart);
    if(Cart==null){
      return;
    }
    if(Cart==[]){
      return;
    }
    print(user_info);
    var Order_Key;
    final CollectionReference ordersCollection = firestore.collection('orders');
    final CollectionReference shopsCollection = firestore.collection("shops");
    await ordersCollection.add({
      'Name':user_info["Name"],
      'User_Key':userId,
      'Status':'Requested',
      'Shop_Name':Cart['Shop_Name'],
      'Order_Items':Cart['Items'],
      'Shop_Key':shop_key
    }).then((value){
      Order_Key=value.id;
    });
    user_info['Active_Orders'].add({
      'Total_Amount':Cart['Total_Amount'],
      'Status':'Requested',
      'Shop_Name':Cart['Shop_Name'],
      'Shop_Key':shop_key,
      'Order_Key':Order_Key,
      'Order_Items':Cart['Items']
    });
    shop_info['Pending_Order'].add({
      'Name':user_info["Name"],
      'Order_Items':Cart['Items'],
      'Order_Key':Order_Key,
      'Status':'Requested',
      'User_Key':userId
    });
    usersCollection.doc(userId).update({'Active_Orders':user_info['Active_Orders'],'Cart':user_info['Cart']});
    shopsCollection.doc(shop_key).update({'Pending_Order':shop_info['Pending_Order']});
  }
  Future checkUser(String userId) async{
    final CollectionReference usersCollection = firestore.collection('users');
    var usersnapshot= await usersCollection.doc(userId).get();
    if(usersnapshot.exists){
      return 1;
    }else{
      return 0;
    }
  }
  void incrementcart(int ind1,int ind2,List Cart,String userId) async {
    final CollectionReference usersCollection = firestore.collection('users');
    Cart[ind1]['Items'][ind2]['Quantity']=Cart[ind1]['Items'][ind2]['Quantity']+1;
    Cart[ind1]['Total_Amount']=Cart[ind1]['Total_Amount']+Cart[ind1]['Items'][ind2]['Price'];

    usersCollection.doc(userId).update({
      'Cart':Cart
    });
  }
  void decrementcart(int ind1,int ind2,List Cart,String userId) async {
    final CollectionReference usersCollection = firestore.collection('users');
    Cart[ind1]['Items'][ind2]['Quantity']=Cart[ind1]['Items'][ind2]['Quantity']-1;
    Cart[ind1]['Total_Amount']=Cart[ind1]['Total_Amount']-Cart[ind1]['Items'][ind2]['Price'];

    usersCollection.doc(userId).update({
      'Cart':Cart
    });
  }
  void create_food_shop(String shop_key,String collection_name,String _name,String _email,String _shopname,num _phone,String _location, String _type) async{
    final CollectionReference shopsCollection = firestore.collection(collection_name);
    shopsCollection.doc(shop_key).set({
      'Menu':[],
      'Pending_Order':[],
      'UserName':_name,
      'ShopName':_shopname,
      'Email':_email,
      'Number':_phone,
      'Active_Order':[],
      'Location':_location,
      'type':_type,
      'collection':collection_name,
      'open':0
    });
  }
  Future getfoodshop(String collection_name) async {
    final CollectionReference shopsCollection = firestore.collection(collection_name);
    final QuerySnapshot snapshots=await shopsCollection.get();
    List shops=[];
    for(var shop in snapshots.docs.toList()){
      shops.add({
        'id':shop.id,
        'Name':shop['ShopName'],
        'open':shop['open']
      });
    }
    return shops;
  }
  void update_last_7(String collection,String shop_key,num amount)async{
    late Map? shop_info;
    var snapshot=await firestore.collection(collection).doc(shop_key).get();
    shop_info=snapshot.data();
    if(shop_info==null){
      return;
    }
    List last_seven=shop_info['Last7'];
    Timestamp time=shop_info['Last_Update'];
    print(Timestamp.now().toDate().difference(time.toDate()).inDays);
  }
}