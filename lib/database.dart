import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
class Databases{
  late FirebaseFirestore firestore;
  initialise(){
    firestore = FirebaseFirestore.instance;
  }
  Future retrieve_menu(String? shop_key,String? collection_name) async {
    late Map? shop_info;
    var snapshot = await firestore.collection(collection_name!).doc(shop_key).get();
    shop_info=snapshot.data();
    return shop_info;
  }
  void update_menu(String shop_key,int index,Map Menu,String _name,num? _price,num _available,String Collection) async {
    final CollectionReference usersCollection = firestore.collection(Collection);

    Menu['Menu'][index]['Price']=_price;
    Menu['Menu'][index]['Name']=_name;
    Menu['Menu'][index]['Available']=_available;
    usersCollection.doc(shop_key).update({'Menu':Menu['Menu']});
  }
  void add_menu_item(String shop_key,Map Menu,String _name,num? _price,String Collection) async {
    final CollectionReference usersCollection = firestore.collection(Collection);
    Menu['Menu'].add({'Price':_price,'Name':_name,'Available':1});
    usersCollection.doc(shop_key).update({'Menu':Menu['Menu']});
  }
  Future retrieve_shop_info(String? collection,String? shop_key) async {
    late Map? shop_info;
    var snapshot=await firestore.collection(collection!).doc(shop_key).get();
    shop_info=snapshot.data();
    return shop_info;
  }
  Future retrieve_user_info(String? userId) async {
    late Map? user_info;
    var snapshot=await firestore.collection("users").doc(userId).get();
    user_info=snapshot.data();
    return user_info;
  }
  void create_user(String? userId,String email,String Name,num? p_number) async {
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
  void Add_to_Cart(String _item,num _price,String _shopkey,String _shopname,String? userId,String collection) async {
    late Map? user_info;
    late Map? shop_info;
    final CollectionReference shopCollection = firestore.collection(collection);
    var shopsnapshot=await firestore.collection(collection).doc(_shopkey).get();
    final CollectionReference usersCollection = firestore.collection('users');
    var snapshot=await firestore.collection("users").doc(userId).get();
    shop_info=await shopsnapshot.data();
    user_info=await snapshot.data();
    if(user_info==null){
      print('first login');
      return;
    }
    if(!user_info.containsKey('Cart')){
      user_info['Cart']=[];
    }
    int counter=0;
    print(_shopkey);
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
      'Items':[{'Item_Name':_item,'Price':_price,'Quantity':1}],
      'Collection':collection
    });
    usersCollection.doc(userId).update({'Cart':user_info!['Cart']});
    print(user_info!['Cart']);
    return;
  }
  Future Request_Order(String? userId, String shop_key,String Collection) async {
    late Map? user_info;
    late Map? shop_info;
    final CollectionReference usersCollection = firestore.collection('users');
    var snapshot=await firestore.collection("users").doc(userId).get();
    var shopsnapshot=await firestore.collection(Collection).doc(shop_key).get();
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
    final CollectionReference shopsCollection = firestore.collection(Collection);
    await ordersCollection.add({
      'Name':user_info["Name"],
      'User_Key':userId,
      'Status':'Requested',
      'Shop_Name':Cart['Shop_Name'],
      'Order_Items':Cart['Items'],
      'Shop_Key':shop_key,
      'Total_Amount':Cart['Total_Amount'],
      'Collection':Collection
    }).then((value){
      Order_Key=value.id;
    });
    user_info['Active_Orders'].add({
      'Total_Amount':Cart['Total_Amount'],
      'Status':'Requested',
      'Shop_Name':Cart['Shop_Name'],
      'Shop_Key':shop_key,
      'Order_Key':Order_Key,
      'Order_Items':Cart['Items'],
      'Collection':Collection
    });
    shop_info['Pending_Order'].add({
      'Name':user_info["Name"],
      'Order_Items':Cart['Items'],
      'Order_Key':Order_Key,
      'Status':'Requested',
      'User_Key':userId,
      'Total_Amount':Cart['Total_Amount']
    });
    usersCollection.doc(userId).update({'Active_Orders':user_info['Active_Orders'],'Cart':user_info['Cart']});
    shopsCollection.doc(shop_key).update({'Pending_Order':shop_info['Pending_Order']});
    return Order_Key;
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
  void incrementcart(int ind1,int ind2,List Cart,String? userId) async {
    final CollectionReference usersCollection = firestore.collection('users');
    Cart[ind1]['Items'][ind2]['Quantity']=Cart[ind1]['Items'][ind2]['Quantity']+1;
    Cart[ind1]['Total_Amount']=Cart[ind1]['Total_Amount']+Cart[ind1]['Items'][ind2]['Price'];

    usersCollection.doc(userId).update({
      'Cart':Cart
    });
  }
  void decrementcart(int ind1,int ind2,List Cart,String? userId) async {
    final CollectionReference usersCollection = firestore.collection('users');
    Cart[ind1]['Items'][ind2]['Quantity']=Cart[ind1]['Items'][ind2]['Quantity']-1;
    Cart[ind1]['Total_Amount']=Cart[ind1]['Total_Amount']-Cart[ind1]['Items'][ind2]['Price'];

    usersCollection.doc(userId).update({
      'Cart':Cart
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
    int days=Timestamp.now().toDate().difference(time.toDate()).inDays;
    int days2=Timestamp.now().toDate().weekday-time.toDate().weekday;
    if(days2<0){
      days2=days2+7;
    }
    if(days>=7 || (days>0 && days2==0)){
      last_seven=[amount,0,0,0,0,0,0];
      firestore.collection(collection).doc(shop_key).update({
        'Last7':last_seven,
        'Last_Update':Timestamp.now().toDate()
      });
      return;
    }
    if(days2==0){
      last_seven[0]=last_seven[0]+amount;
      firestore.collection(collection).doc(shop_key).update({
        'Last7':last_seven,
        'Last_Update':Timestamp.now().toDate()
      });
      return;
    }
    for(int i=days2-1;i>=0;i--){
      for(int j=5;j>=0;j--){
        last_seven[j+1]=last_seven[j];
      }
      last_seven[0]=0;
    }
    last_seven[0]=last_seven[0]+amount;
    firestore.collection(collection).doc(shop_key).update({
      'Last7':last_seven,
      'Last_Update':Timestamp.now().toDate()
    });
  }
  void addfavourite(String item_name,num price,String shop_key,String shop_name,String? userId,String collection) async {

    late Map? user_info;
    final CollectionReference usersCollection = firestore.collection('users');
    var snapshot=await firestore.collection("users").doc(userId).get();
    user_info=snapshot.data();
    if(user_info==null){
      return;
    }
    var counter=0;
    for(Map shopcart in user_info['Favourites']){
      if(shopcart['Item_Name']==item_name && shopcart['Shop_Key']==shop_key){
        counter=1;
      }
    }
    if(counter==1){
      return;
    }
    user_info['Favourites'].add({
      'Item_Name':item_name,
      'Price':price,
      'Shop_Key':shop_key,
      'Shop_Name':shop_name,
      'Collection':collection
    });
    // print(user_info['Favourites']);
    firestore.collection("users").doc(userId).update({
      'Favourites':user_info['Favourites']
    });

  }


  void removefavourite(String item_name,num price,String shop_key,String shop_name,String? userId,String collection) async {

    late Map? user_info;
    final CollectionReference usersCollection = firestore.collection('users');
    var snapshot=await firestore.collection("users").doc(userId).get();
    user_info=snapshot.data();
    if(user_info==null){
      return;
    }
    late Map? Item;
    var counter=0;
    print(user_info);
    for(Map shopcart in user_info['Favourites']){
      if(shopcart['Item_Name']==item_name && shopcart['Shop_Key']==shop_key && shopcart['Collection']==collection){
        Item=shopcart;
        counter=1;
      }
    }
    if(counter==0){
      return;
    }
    user_info['Favourites'].remove(Item);


    // print(user_info['Favourites']);
    firestore.collection("users").doc(userId).update({
      'Favourites':user_info['Favourites']
    });

  }


  void rating(num new_rating,String shop_key,String collection) async {

    late Map? shop_info;
    final CollectionReference shopCollection = firestore.collection(collection);
    var shopsnapshot=await firestore.collection(collection).doc(shop_key).get();
    shop_info=shopsnapshot.data();
    if(shop_info==null){
      return;
    }

    num tempRating = shop_info['current_rating'] * shop_info['total_review'] + new_rating;

    shop_info['total_review'] = shop_info['total_review'] + 1;

    tempRating = tempRating/shop_info['total_review'];

    shop_info['current_rating'] = tempRating;

    firestore.collection(collection).doc(shop_key).update({
      'current_rating':shop_info['current_rating'],
      'total_review':shop_info['total_review']
    });

  }
  void create_shop_user(String shop_key,num? p_number,String email,String shop_name ,String upi_id, String user_name,String collection) async {
    final CollectionReference shopCollection1 = firestore.collection('food-canteen');
    final CollectionReference shopCollection2 = firestore.collection('food-foodcourt');
    final CollectionReference shopCollection3 = firestore.collection('food-khokha');
    final CollectionReference shopCollection4 = firestore.collection('food-marketcomplex');
    if(collection=='food-canteen'){
      shopCollection1.doc(shop_key).set({
        'Active_Orders':[],
        'Email':email,
        'Last7':[],
        'Last_Update':Timestamp.now(),
        'Menu':[],
        'Number':p_number,
        'Pending_Order':[],
        'Verified':0,
        'UPI_id':upi_id,
        'ShopName':shop_name,
        'UserName':user_name,
        'collection':collection,
        'open':0,
        'type':"Food"
      });
    }
    else if(collection=='food-foodcourt'){
      shopCollection2.doc(shop_key).set({
        'Active_Orders':[],
        'Email':email,
        'Last7':[],
        'Last_Update':Timestamp.now(),
        'Menu':[],
        'Number':p_number,
        'Pending_Order':[],
        'Verified':0,
        'UPI_id':upi_id,
        'ShopName':shop_name,
        'UserName':user_name,
        'collection':collection,
        'open':0,
        'type':"Food"
      });
    }
    else if(collection=='food-khokha'){
      shopCollection3.doc(shop_key).set({
        'Active_Orders':[],
        'Email':email,
        'Last7':[],
        'Last_Update':Timestamp.now(),
        'Menu':[],
        'Number':p_number,
        'Pending_Order':[],
        'Verified':0,
        'UPI_id':upi_id,
        'ShopName':shop_name,
        'UserName':user_name,
        'collection':collection,
        'open':0,
        'type':"Food"
      });
    }
    else if(collection=='food-marketcomplex'){
      shopCollection4.doc(shop_key).set({
        'Active_Orders':[],
        'Email':email,
        'Last7':[],
        'Last_Update':Timestamp.now(),
        'Menu':[],
        'Number':p_number,
        'Pending_Order':[],
        'Verified':0,
        'UPI_id':upi_id,
        'ShopName':shop_name,
        'UserName':user_name,
        'collection':collection,
        'open':0,
        'type':"Food"
      });
    }
    final CollectionReference shopCollection5 = firestore.collection('grocery');
    final CollectionReference shopCollection6 = firestore.collection('miscellaneous');
    if(collection=='grocery'){
      shopCollection5.doc(shop_key).set({
        'Email':email,
        'Number':p_number,
        'Verified':0,
        'ShopName':shop_name,
        'UserName':user_name,
        'collection':collection,
        'open':0,
        'type':"Grocery"
      });
    }
    else if(collection=='miscellaneous'){
      shopCollection6.doc(shop_key).set({
        'Email':email,
        'Number':p_number,
        'Verified':0,
        'ShopName':shop_name,
        'UserName':user_name,
        'collection':collection,
        'open':0,
        'type':"Miscellaneous"
      });
    }
    final CollectionReference shopCollection7 = firestore.collection('stationary');
    if(collection=='stationary') {
      shopCollection7.doc(shop_key).set({
        'Active_Orders': [],
        'Email': email,
        'Number': p_number,
        'Verified':0,
        'UPI_id':upi_id,
        'Pending_Order': [],
        'ShopName': shop_name,
        'UserName': user_name,
        'collection': collection,
        'open': 0,
        'type': "Stationary"
      });
    }
  }

  void shopToggle(String shop_key , String collection) async {
    late Map? shop_info;
    final CollectionReference usersCollection = firestore.collection(collection);
    var snapshot=await firestore.collection(collection).doc(shop_key).get();
    shop_info=snapshot.data();

    if(shop_info!['open'] == 1){
      shop_info['open'] = 0 ;
    }
    else{
      shop_info['open'] = 1 ;
    }

    firestore.collection(collection).doc(shop_key).update({
      'open':shop_info['open']
    });
  }
  Future get_order_details(String? orderId) async {
    late Map? order_info;
    var snapshot=await firestore.collection("orders").doc(orderId).get();
    order_info=snapshot.data();
    return order_info;
  }

  Future<String> getUserType(String uid) async {
    CollectionReference usersCollection = firestore.collection('users');
    var usersnapshot= await usersCollection.doc(uid).get();
    if(usersnapshot.exists){
      return "users";
    }
    usersCollection = firestore.collection('food-canteen');
    usersnapshot= await usersCollection.doc(uid).get();
    if(usersnapshot.exists){
      return "food-canteen";
    }
    usersCollection = firestore.collection('food-foodcourt');
    usersnapshot= await usersCollection.doc(uid).get();
    if(usersnapshot.exists){
      return "food-foodcourt";
    }
    usersCollection = firestore.collection('food-khokha');
    usersnapshot= await usersCollection.doc(uid).get();
    if(usersnapshot.exists){
      return "food-khokha";
    }
    usersCollection = firestore.collection('food-marketcomplex');
    usersnapshot= await usersCollection.doc(uid).get();
    if(usersnapshot.exists){
      return "food-marketcomplex";
    }
    usersCollection = firestore.collection('stationary');
    usersnapshot= await usersCollection.doc(uid).get();
    if(usersnapshot.exists){
      return "stationary";
    }
    usersCollection = firestore.collection('grocery');
    usersnapshot= await usersCollection.doc(uid).get();
    if(usersnapshot.exists){
      return "grocery";
    }
    usersCollection = firestore.collection('miscellaneous');
    usersnapshot= await usersCollection.doc(uid).get();
    if(usersnapshot.exists){
      return "miscellaneous";
    }
    return "none";
  }
  void Reorder(List Items,String collection,String shop_key,String? userId) async {
    Map? shop_info;
    Map? user_info;
    var snapshot=await firestore.collection(collection).doc(shop_key).get();
    var usersnapshot=await firestore.collection("users").doc(userId).get();
    shop_info=snapshot.data();
    user_info=usersnapshot.data();
    Map shopcart;
    int counter=0;
    int index=0;
    for(Map cart in user_info!['Cart']){
      if(cart['Shop_Key']==shop_key && cart['Collection']==collection){
        shopcart=cart;
        user_info['Cart'].indexOf(shopcart);
        counter=1;
      }
    }
    if(counter==0){
      List Cart_Item=[];
      num Total=0;
      for(Map item in Items){
        // print();
        num price=0;
        int poss=0;

        for(Map menu in shop_info!['Menu']){
          if(menu['Name']==item['Item_Name'] && menu['Available']==1){
            poss=1;
            price=menu['Price'];
          }
        }
        if(poss==1){
          Total=Total+price*item['Quantity'];
          Cart_Item.add({
            'Item_Name':item['Item_Name'],
            'Price':price,
            'Quantity':item['Quantity']
          });
        }
      }
      user_info['Cart'].add({
        'Collection':collection,
        'Shop_Key':shop_key,
        'Shop_Name':shop_info!['ShopName'],
        'Items':Cart_Item,
        'Total_Amount':Total
      });
      firestore.collection("users").doc(userId).update({
        'Cart':user_info['Cart']
      });
    }else{
      for(Map item in Items) {
        num price = 0;
        int poss = 0;

        for (Map menu in shop_info!['Menu']) {
          if (menu['Name'] == item['Item_Name'] && menu['Available'] == 1) {
            poss = 1;
            price = menu['Price'];
          }
        }
        if(poss==1){
          int check=0;
          for(Map food in user_info['Cart'][index]['Items']){
            if(food['Item_Name']==item['Item_Name']){
              food['Quantity']=food['Quantity']+item['Quantity'];
              check=1;
            }
          }
          user_info['Cart'][index]['Total_Amount']=user_info['Cart'][index]['Total_Amount']+item['Quantity']*price;
          if(check==0){
            user_info['Cart'][index]['Items'].add({
              'Item_Name':item['Item_Name'],
              'Price':price,
              'Quantity':item['Quantity']
            });
          }
          firestore.collection("users").doc(userId).update({
            'Cart':user_info['Cart']
          });
        }
      }
    }
  }

  void edit_user(String username,String email,num? p_number,String? userId) async {
    print(username);
    firestore.collection('users').doc(userId).update({
      'Name':username,
      'Mail':email,
      'Phone_Number':p_number
    });
  }
  void removefromcart(String? userId,Map user_info,int index1,int index2) async {
    if(user_info['Cart'][index1]['Items'].length==1){
      user_info['Cart'].remove(user_info['Cart'][index1]);
    }else{
      user_info['Cart'][index1]['Items'].remove(user_info['Cart'][index1]['Items'][index2]);
    }
    firestore.collection("users").doc(userId).update({
      'Cart':user_info['Cart']
    });
  }
  void accepted(String userId,String? shop_key,String order_key,String? collection) async {
    late Map? user_info;
    var snapshot=await firestore.collection("users").doc(userId).get();
    user_info=snapshot.data();



    for(var item in user_info!['Active_Orders']){
      if(item['Order_Key'] == order_key){
        item['Status'] = "Approved";
        break;
      }
    }

    firestore.collection("users").doc(userId).update({
      'Active_Orders':user_info['Active_Orders']
    });

    late Map? shop_info;
    var snapshot2=await firestore.collection(collection!).doc(shop_key).get();
    shop_info=snapshot2.data();
    print(shop_info);
    var index = 0;
    Map temp={};
    for(var item in shop_info!['Pending_Order']){
      if(item['Order_Key'] == order_key){
        temp=item;
        break;
      }
    }

    shop_info['Pending_Order'].remove(temp);

    firestore.collection(collection).doc(shop_key).update({
      'Pending_Order':shop_info['Pending_Order']
    });

    late Map? order_info;
    var snapshot3=await firestore.collection('orders').doc(order_key).get();
    order_info=snapshot3.data();

    order_info!['Status'] = "Approved";

    firestore.collection("orders").doc(order_key).update({
      'Status':order_info['Status']
    });
  }
  void rejected(String userId,String? shop_key,String order_key,String? collection) async {
    late Map? user_info;
    var snapshot=await firestore.collection("users").doc(userId).get();
    user_info=snapshot.data();
    Map shop_item={};
    for(var item in user_info!['Active_Orders']){
      if(item['Order_Key'] == order_key){
        shop_item=item;
        break;
      }
    }
    user_info!['Active_Orders'].remove(shop_item);
    firestore.collection("users").doc(userId).update({
      'Active_Orders':user_info['Active_Orders']
    });
    late Map? shop_info;
    var snapshot2=await firestore.collection(collection!).doc(shop_key).get();
    shop_info=snapshot2.data();
    print(shop_info);
    var index = 0;
    Map temp={};
    for(var item in shop_info!['Pending_Order']){
      if(item['Order_Key'] == order_key){
        temp=item;
        break;
      }
    }
    shop_info['Pending_Order'].remove(temp);
    firestore.collection(collection).doc(shop_key).update({
      'Pending_Order':shop_info['Pending_Order']
    });
    await firestore.collection('orders').doc(order_key).delete();
  }
}