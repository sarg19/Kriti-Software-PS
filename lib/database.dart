import 'package:cloud_firestore/cloud_firestore.dart';
class Databases{
  late FirebaseFirestore firestore;
  initialise(){
    firestore = FirebaseFirestore.instance;
  }
  Future retrieve_menu(String shop_key) async {
    final CollectionReference usersCollection = firestore.collection('shops');
    final QuerySnapshot snapshots=await usersCollection.get();
    for(var doc in snapshots.docs.toList()){
      if(doc.id==shop_key){
        Map Menu={"id":doc.id,"menu":doc["Menu"]};
        return Menu;
      }
    }
  }
  void update_menu(String shop_key,int index,Map Menu,String _name,num _price,num _available) async {
    final CollectionReference usersCollection = firestore.collection('shops');

    Menu['menu'][index]['Price']=_price;
    Menu['menu'][index]['Name']=_name;
    Menu['menu'][index]['Available']=_available;
    usersCollection.doc(shop_key).update({'Menu':Menu['menu']});
  }
  void add_menu_item(String shop_key,Map Menu,String _name,num _price) async {
    final CollectionReference usersCollection = firestore.collection('shops');
    Menu['menu'].add({'Price':_price,'Name':_name,'Available':1});
    usersCollection.doc(shop_key).update({'Menu':Menu['menu']});
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
    for(Map shopcart in user_info['Cart']){
      if(shopcart['Shop_Key']==shop_key){
        Cart=shopcart;
      }
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
}